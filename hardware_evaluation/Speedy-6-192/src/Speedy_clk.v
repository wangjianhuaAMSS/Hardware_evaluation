module Speedy_clk (clk, rst, f_in, K, f_out);
localparam l = 32;
localparam r = 7;
input clk;
input rst;
input [6*l-1:0] f_in;
input [6*l-1:0] K;
output [6*l-1:0] f_out;
reg [6*l-1:0] f_out;

reg [6*l-1:0] f_in_reg;
reg [6*l-1:0] K_reg;
wire [6*l-1:0] f_out_wire;

Speedy_top  speedy_top(.f_in(f_in_reg), .K(K_reg), .f_out(f_out_wire));

always@(posedge clk or negedge rst) begin: aclk
        if (rst == 0) begin: clkb1
          f_in_reg <= 0;
          K_reg <= 0;
          f_out <= 0;
        end
        else begin: clkb2
          f_in_reg <= f_in;
          K_reg <= K;
          f_out <= f_out_wire;
        end

end

endmodule

