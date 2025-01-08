
module qarma_clk
	(clk, rst, enc, K0, K1, P, T0, T1, C);
    input clk;
	input rst;
    input enc;
    localparam n = 128;
	input [n-1:0] K0;
    input [n-1:0] K1; 
    input [n-1:0] P;
    input [n-1:0] T0; 
    input [n-1:0] T1; 
    output [n-1:0] C;
    reg [n-1:0] C;

 
    wire [n-1:0] C_wire;

    reg enc_reg;
    reg [n-1:0] K0_reg;
    reg [n-1:0] K1_reg; 
    reg [n-1:0] P_reg;
    reg [n-1:0] T0_reg; 
    reg [n-1:0] T1_reg; 
	qarma_top
    qarma_top_inst
    (
        .enc(enc_reg),
        .K0(K0_reg), 
        .K1(K1_reg), 
        .P(P_reg), 
        .T0(T0_reg), 
        .T1(T1_reg), 
        .C(C_wire)
    );

	always@(posedge clk or negedge rst) begin: aclk
        if (rst == 0) begin: b1
            enc_reg <= 0;
            K0_reg <= 0;
            K1_reg <= 0; 
            P_reg <= 0;
            T0_reg <= 0; 
            T1_reg <= 0; 
            C <= 0;
        end
        else begin: b2
         enc_reg <= enc;
          K0_reg <= K0;
            K1_reg <= K1; 
            P_reg <= P;
            T0_reg <= T0; 
            T1_reg <= T1; 
            C <= C_wire;
        end

    end
	
endmodule