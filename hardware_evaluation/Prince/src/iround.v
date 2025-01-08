module iround #(parameter n = 1)(f_in, key, f_out);  
    input [63 : 0] f_in;
    input [63 : 0] key;
    output  [63: 0] f_out;

    wire [63: 0] tmp [1:0];
    assign tmp[0] = f_in  ^ key;
    imat ima(.f_in(tmp[0]), .f_out(tmp[1]));
    genvar i;
    generate
        for (i = 0; i < 16; i=i+1) begin: genisb
          isbox isb(.f_in(tmp[1][(i+1)*4-1:i*4]), .f_out(f_out[(i+1)*4-1:i*4]));
        end
    endgenerate
    
    
endmodule
