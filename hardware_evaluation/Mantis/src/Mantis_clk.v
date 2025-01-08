module Mantis_clk
	(clk, rst, enc, T, K, P, C);
    localparam n = 64;
    input clk;
	input rst;
    input enc;
    input [127:0] K;
    input [n-1:0] T;
    input [n-1:0] P;
    output [n-1:0] C;
    reg [n-1:0] C;

    wire [n-1:0] C_wire;

    reg enc_reg;
    reg [127:0] K_reg;
    reg [n-1:0] T_reg;
    reg [n-1:0] P_reg;

    Mantis_top
    mantis_top
    (
        .enc(enc_reg),
        .T(T_reg),
        .K(K_reg), 
        .P(P_reg), 
        .C(C_wire)
    );

	always@(posedge clk or negedge rst) begin: aclk
        if (rst == 0) begin: clkb1
            enc_reg <= 0;
            T_reg <= 0;
            K_reg <= 0; 
            P_reg <= 0;
            C <= 0;
        end
        else begin: clkb2
            enc_reg <= enc;
            T_reg <= T;
            K_reg <= K; 
            P_reg <= P;
            C <= C_wire;
        end

    end
	
endmodule