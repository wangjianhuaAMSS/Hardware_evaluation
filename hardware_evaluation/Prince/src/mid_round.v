module mid_round (f_in,  f_out);  
    input [63 : 0] f_in;
    output  [63: 0] f_out;

    wire [63: 0] tmp [1:0];
    genvar i;
    generate
        for (i = 0; i < 16; i=i+1) begin: genmsbox
          sbox sb(.f_in(f_in[(i+1)*4-1:i*4]), .f_out(tmp[0][(i+1)*4-1:i*4]));
        end
    endgenerate
    
    M m(.f_in(tmp[0]), .f_out(tmp[1]));
    generate
        for (i = 0; i < 16; i=i+1) begin: genmisbox
          isbox isb(.f_in(tmp[1][(i+1)*4-1:i*4]), .f_out(f_out[(i+1)*4-1:i*4]));
        end
    endgenerate
    
endmodule
