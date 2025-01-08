module SPEEDY_Sbox(f_in, f_out);
input [5:0] f_in;
output [5:0] f_out;
assign f_out[0] = ( f_in[3] & (~f_in[5]) ) | ( f_in[3] & f_in[4] & f_in[2] ) | ((~f_in[3]) & f_in[1] & f_in[0]) | ( f_in[5] & f_in[4] & f_in[1] );
assign f_out[1] = ( f_in[5] & f_in[3] & (~f_in[2])) | ((~f_in[5]) & f_in[3] & (~f_in[4])) | ( f_in[5] & f_in[2] & f_in[0]) | ((~f_in[3]) & (~f_in[0]) & f_in[1] );
assign f_out[2] = ((~f_in[3]) & f_in[0] & f_in[4] ) | ( f_in[3] & f_in[0] & f_in[1] ) | ((~f_in[3]) & (~f_in[4]) & f_in[2]) | ((~f_in[0]) & (~f_in[2]) & (~f_in[5]));
assign f_out[3] = ((~f_in[0]) & f_in[2] & (~f_in[3])) | ( f_in[0] & f_in[2] & f_in[4] ) | ( f_in[0] & (~f_in[2]) & f_in[5]) | ((~f_in[0]) & f_in[3] & f_in[1] );
assign f_out[4] = ( f_in[0] & (~f_in[3]) ) | ( f_in[0] & (~f_in[4]) & (~f_in[2])) | ((~f_in[0]) & f_in[4] & f_in[5]) | ((~f_in[4]) & (~f_in[2]) & f_in[1] );
assign f_out[5] = ( f_in[2] & f_in[5] ) | ((~f_in[2]) & (~f_in[1]) & f_in[4] ) | ( f_in[2] & f_in[1] & f_in[0]) | ((~f_in[1]) & f_in[0] & f_in[3] );
endmodule

module Sbox_layer (f_in, f_out);
localparam l = 32;
input [6*l-1:0] f_in;
output [6*l-1:0] f_out;
genvar i;
generate
    for (i = 0; i < l; i=i+1) begin: gensbox
        SPEEDY_Sbox sbox(.f_in(f_in[i*6+5: i*6]), .f_out(f_out[i*6+5: i*6]));
    end
endgenerate

endmodule
