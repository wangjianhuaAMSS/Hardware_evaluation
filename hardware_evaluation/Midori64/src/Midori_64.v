module Midori_64(clk, rst, enc, K, P,  C);    
    localparam  round = 16; 
    localparam n = 64;
    input clk;
	input rst;
	input enc; 
    input [127:0] K; 
    input [n-1:0] P;
    output [n-1:0] C;

    Midori_clk
    U_midori_clk
    (
        .clk(clk),
        .rst(rst),
        .enc(enc), 
        .K(K), 
        .P(P), 
        .C(C)
    );
	
endmodule