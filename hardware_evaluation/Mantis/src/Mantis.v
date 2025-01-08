module Mantis(clk, rst, enc, T, K, P,  C);
    input clk;
	input rst;
    localparam  round = 7; 
    localparam n = 64;
	input enc; 
    input [n-1:0] T;
    input [127:0] K; 
    input [n-1:0] P;
    output [n-1:0] C;

    Mantis_clk
    U_mantis_clk
    (
        .clk(clk),
        .rst(rst),
        .enc(enc), 
        .T(T),
        .K(K), 
        .P(P), 
        .C(C)
    );
	
endmodule