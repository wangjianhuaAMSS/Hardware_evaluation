module qarma128_0_M82_11(
	input clk,
	input rst,
	input enc,
	input wire [2*128-1:0] K,
	input wire [128-1:0] P,
	input wire [128-1:0] T,
	output wire [128-1:0] C
);

qarma_clk qarma_clk(clk, rst, enc, K, P, T, C);
endmodule