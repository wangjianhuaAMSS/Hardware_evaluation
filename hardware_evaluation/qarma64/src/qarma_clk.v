module qarma_clk
    (
        input wire clk,
		input wire rst,
		input wire enc,
		input wire[127:0] K, 
        input wire[63:0] P, 
        input wire[63:0] T, 
        output reg[63:0] C
    );
	localparam n = 64;
	reg enc_reg;
	reg [2*n-1:0] K_reg;
	reg [n-1:0] P_reg;
	reg [n-1:0] T_reg;
	wire [n-1:0] C_out;
	
	qarma_top  qarma_top(enc_reg, K_reg, P_reg, T_reg, C_out);

	always@(posedge clk or negedge rst) begin: aclk
        if (rst == 0) begin: clkb1
			enc_reg <= 0;
            K_reg <= 0;
            P_reg <= 0;
            T_reg <= 0; 
            C <= 0;
        end
        else begin: clkb2
			enc_reg <= enc;
            K_reg <= K;
            P_reg <= P;
            T_reg <= T; 
            C <= C_out;
        end

    end
	
endmodule