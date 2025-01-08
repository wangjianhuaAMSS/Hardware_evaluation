module prince(clk, rst, enc, plaintext, key, ciphertext);
    input clk;
	input rst;

	input enc; 
    input [127:0] key; 
    input [63:0] plaintext;
    output [63:0] ciphertext;
    prince_clk
    U_prince_clk
    (
        .clk(clk),
        .rst(rst),
        .enc(enc), 
        .plaintext(plaintext), 
        .key(key),
        .ciphertext(ciphertext)
    );
	
endmodule