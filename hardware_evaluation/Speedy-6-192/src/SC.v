module SC (f_in, f_out);
localparam l = 32;
input [6*l-1:0] f_in;
output [6*l-1:0] f_out;
genvar i, j;
generate
    for (i = 0; i < l; i=i+1) begin:gensc1
        for (j = 0; j < 6; j=j+1) begin: gensc2
            assign f_out[i*6+j]=f_in[(i+j)%l*6+j];
        end
    end
endgenerate

endmodule