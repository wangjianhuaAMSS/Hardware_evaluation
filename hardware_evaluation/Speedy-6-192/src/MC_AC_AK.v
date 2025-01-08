module MC_AC_AK (f_in, AC_AK, f_out);
localparam l = 32;
input [6*l-1:0] f_in;
input [6*l-1:0] AC_AK;
output [6*l-1:0] f_out;
genvar i, j;
generate 
    for (i = 0; i < l; i=i+1) begin: genacak1
        for (j = 0; j < 6; j=j+1) begin: genacak2
            assign f_out[i*6+j]= f_in[(i)%l*6+j] ^ f_in[(i+1)%l*6+j] ^ f_in[(i+5)%l*6+j]  ^ f_in[(i+9)%l*6+j] 
                            ^ f_in[(i+15)%l*6+j] ^ f_in[(i+21)%l*6+j] ^ f_in[(i+26)%l*6+j] ^ AC_AK[i*6+j];
        end
    end
endgenerate

endmodule