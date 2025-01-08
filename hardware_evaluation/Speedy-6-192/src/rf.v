
module Rf (f_in, AC_AK, f_out);
localparam l = 32;
input [6*l-1:0] f_in;
input [6*l-1:0] AC_AK;
output [6*l-1:0] f_out;
wire [6*l-1:0] tmp[3:0];

Sbox_layer SL1(.f_in(f_in), .f_out(tmp[0])); 
SC  SC1(.f_in(tmp[0]), .f_out(tmp[1]));

Sbox_layer  SL2(.f_in(tmp[1]), .f_out(tmp[2])); 
SC  SC2(.f_in(tmp[2]), .f_out(tmp[3]));
MC_AC_AK  MCK(.f_in(tmp[3]), .AC_AK(AC_AK), .f_out(f_out));

endmodule


module rf (f_in, AK, f_out);
localparam l = 32;
input [6*l-1:0] f_in;
input [6*l-1:0] AK;
output [6*l-1:0] f_out;
wire [6*l-1:0] tmp[2:0];

Sbox_layer  SL1(.f_in(f_in), .f_out(tmp[0])); 
SC  SC1(.f_in(tmp[0]), .f_out(tmp[1]));

Sbox_layer SL2(.f_in(tmp[1]), .f_out(tmp[2])); 

assign f_out = tmp[2] ^ AK;

endmodule