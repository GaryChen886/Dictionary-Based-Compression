module search(
    input [7:0] key;
    input clk;
    input reset,
    input write_enable,
    output [7:0] data;
    output hit;
);    
    localparam CHAIN_LENGTH = 4;

    localparam IDLE = 0; 
    localparam SEARCH = 1;
    localparam FIND = 2;
    localparam DONE = 3;
    integer i;
    reg [1:0]cnt;
    reg currState, nextState;


    always @(*) begin
        
    end
    always @(posedge clk) begin
        if(write_enable || reset)   cnt <= 0;
        else begin
            cnt <= cnt + 1;
        end
    end

    always @(posedge clk or reset) begin
        if(reset || write_enable)begin
            currState <= IDLE;
        end
        else begin
            currState <= nextState;
        end
    end
    always @(*) begin
        if(reset || write_enable) begin
            nextState = IDLE;
        end
        else begin
            case (currState)
                IDLE : 
                SEARCH :
                FIND : 
                DONE : 
                default: 
            endcase
        end
    end
endmodule