# Dictionary-Based-Compression
--
##
1. HASH_TABLE_SIZE and CHAIN_LENGTH parameters are defined to specify the size of the hash table and the maximum chain length
2. hash_table array is a two-dimensional array where each row corresponds to a hash value and each column corresponds to a key-value pair in the chain
3. hash function - the hash value is computed by XOR lower 4 bits and upper 4 bits of the key.
4. search function - returns the corresponding value from the hash table if the key is found, uses hit for indicatation
5. write function - success flag indicating whether the write operation was successful


###### References
- https://github.com/pbridd/lzrw1-compression-core
- https://users.ece.utexas.edu/~ryerraballi/MSB/pdfs/M2L3.pdf
- https://www.youtube.com/watch?v=qO19qbvgTqs
