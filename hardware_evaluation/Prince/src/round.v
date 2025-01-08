module round (f_in, key, f_out);  
    input [63 : 0] f_in;
    input [63 : 0] key;
    output  [63: 0] f_out;

    wire [63: 0] tmp [1:0];
    genvar i;
    generate
        for (i = 0; i < 16; i=i+1) begin: gensb
          sbox sb(.f_in(f_in[(i+1)*4-1:i*4]), .f_out(tmp[0][(i+1)*4-1:i*4]));
        end
    endgenerate
    
    mat ma(.f_in(tmp[0]), .f_out(tmp[1]));
    assign f_out = tmp[1] ^ key;
endmodule