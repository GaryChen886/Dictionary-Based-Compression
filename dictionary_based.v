module dictionary_based(
    input [7:0] key,
    input [7:0] data_in,
    input clk,
    input reset,
    input write_enable,
    output reg [7:0] data_out,
    output reg hit
);

// hash table
parameter HASH_TABLE_SIZE = 16;
parameter CHAIN_LENGTH = 4;

//////////////////////////////////////////
// hash table and chain data structures //
//////////////////////////////////////////
// 8 bits 16*4
reg [7:0] hash_table [0 : HASH_TABLE_SIZE-1 ][ 0 : CHAIN_LENGTH-1 ];
// 4 bits *16
reg [3:0] chain_lengths [ 0 : HASH_TABLE_SIZE-1 ];

// Hash Function
// XOR the Lower 4 bits with higher 4 bits
function [3:0] hash;
input [7:0] key;
begin
    hash = key[3:0] ^ key[7:4];
end
endfunction

// Search Function
function search;
input [7:0] key;
output [7:0] data;
output hit;
begin
    integer i;
    hit = 0;
    data = 0;
    for (i = 0; i < CHAIN_LENGTH; i = i + 1) begin
        if (hash_table[hash(key)][i] == key) begin
            data = hash_table[hash(key)][i+CHAIN_LENGTH];
            hit = 1;
            break;
        end
    end
end
endfunction

// Define write function
function write;
input [7:0] key;
input [7:0] data;
output success;
begin
    integer i;
    success = 0;
    for (i = 0; i < CHAIN_LENGTH; i = i + 1) begin
        if (hash_table[hash(key)][i] == key) begin
            hash_table[hash(key)][i+CHAIN_LENGTH] = data;
            success = 1;
            break;
        end
        else if (hash_table[hash(key)][i] == 0) begin
            hash_table[hash(key)][i] = key;
            hash_table[hash(key)][i+CHAIN_LENGTH] = data;
            chain_lengths[hash(key)] = chain_lengths[hash(key)] + 1;
            success = 1;
            break;
        end
    end
end
endfunction


integer i, j;
always @(posedge clk or reset)begin
    if(reset)begin
        for(i = 0; i < HASH_TABLE_SIZE; i = i + 1)begin
            for (j = 0; j < CHAIN_LENGTH; j = j + 1) begin
                hash_table[i][j] = 0;
            end
        end
    end
    else if (write_enable)begin
        write(key, data_in, hit);
    end
    else begin
        search(key, data_out, hit);
    end
end



// Main logic
always @(posedge clk) begin
    if (reset) begin
        data_out <= 0;
        hit <= 0;
    end
    else if (write_enable) begin
        write(key, data_in, hit);
        data_out <= 0;
    end
    else begin
        search(key, data_out, hit);
    end
end

endmodule
