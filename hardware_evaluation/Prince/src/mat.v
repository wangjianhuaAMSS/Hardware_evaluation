module mat(f_in, f_out);
    input [63 : 0] f_in;
    output [63: 0] f_out;
    wire [63: 0] tmp;
    M m (.f_in(f_in), .f_out(tmp));

    assign f_out = {tmp[63 : 60], tmp[43 : 40], tmp[23 : 20], tmp[03 : 00],
           tmp[47 : 44], tmp[27 : 24], tmp[07 : 04], tmp[51 : 48],
           tmp[31 : 28], tmp[11 : 08], tmp[55 : 52], tmp[35 : 32],
           tmp[15 : 12], tmp[59 : 56], tmp[39 : 36], tmp[19 : 16]};

endmodule