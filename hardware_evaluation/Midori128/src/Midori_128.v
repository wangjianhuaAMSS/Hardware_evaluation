module Midori_128(clk, rst, enc, K, P, C);
    input clk;
	input rst;
    localparam  round = 20; 
    localparam n = 128;

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