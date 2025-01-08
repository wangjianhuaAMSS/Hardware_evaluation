module qarma64_0_M42_7(
	input clk,
	input rst,
	input enc,
	input wire [2*64-1:0] K,
	input wire [64-1:0] P,
	input wire [64-1:0] T,
	output wire [64-1:0] C
);


qarma_clk qarma_clk(clk, rst, enc, K, P, T, C);

endmodule