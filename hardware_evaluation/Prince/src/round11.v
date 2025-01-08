module  round11(f_in, key, f_out);
    input [63 : 0] f_in;
    input [63 : 0] key;
    output  [63: 0] f_out;

    assign  f_out =  f_in ^ key;

endmodule