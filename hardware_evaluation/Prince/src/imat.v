module imat(f_in, f_out);
    input [63 : 0] f_in;
    output [63: 0] f_out;
    wire [63: 0] tmp;
    
    assign  tmp = {f_in[63 : 60], f_in[11 : 08], f_in[23 : 20], f_in[35 : 32],
                    f_in[47 : 44], f_in[59 : 56], f_in[07 : 04], f_in[19 : 16],
                    f_in[31 : 28], f_in[43 : 40], f_in[55 : 52], f_in[03 : 00],
                    f_in[15 : 12], f_in[27 : 24], f_in[39 : 36], f_in[51 : 48]};

    M m (.f_in(tmp), .f_out(f_out)); 

endmodule