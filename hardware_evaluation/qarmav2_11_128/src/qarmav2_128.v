
module qarmav2_128(clk, rst, enc, K0, K1, P, T0, T1, C);
    input clk;
	input rst;
    localparam n = 128;
    input enc;
	input [n-1:0] K0;
    input [n-1:0] K1; 
    input [n-1:0] P;
    input [n-1:0] T0; 
    input [n-1:0] T1; 
    output [n-1:0] C;
    
	qarma_clk Uclk(.clk(clk), .rst(rst), .enc(enc), .K0(K0), .K1(K1), .P(P), .T0(T0), .T1(T1), .C(C));

	
endmodule