module Midori_clk
	(clk, rst, enc, K, P, C);
    input clk;
	input rst;
    input enc;
    localparam n=128;
    localparam round=20;
    input [127:0] K;
    input [n-1:0] P;
    output [n-1:0] C;
    reg [n-1:0] C;

    wire [n-1:0] C_wire;

    reg enc_reg;
    reg [127:0] K_reg;
    reg [n-1:0] P_reg;

    Midori_top
    midori_top
    (
        .enc(enc_reg),
        .K(K_reg), 
        .P(P_reg), 
        .C(C_wire)
    );

	always@(posedge clk or negedge rst) begin: aclk
        if (rst == 0) begin: clkb1
            enc_reg <= 0;
            K_reg <= 0; 
            P_reg <= 0;
            C <= 0;
        end
        else begin: clkb2
            enc_reg <= enc;
            K_reg <= K; 
            P_reg <= P;
            C <= C_wire;
        end

    end
	
endmodule