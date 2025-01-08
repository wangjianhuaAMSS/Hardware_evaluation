module isbox(f_in, f_out);
    input   [3:0]   f_in;
    output  [3:0]   f_out;
    reg [3:0]   f_out;
    always @(f_in)
    case(f_in)
      4'h0: f_out = 4'hb;
      4'h1: f_out = 4'h7;
      4'h2: f_out = 4'h3;
      4'h3: f_out = 4'h2;
      4'h4: f_out = 4'hf;
      4'h5: f_out = 4'hd;
      4'h6: f_out = 4'h8;
      4'h7: f_out = 4'h9;
      4'h8: f_out = 4'ha;
      4'h9: f_out = 4'h6;
      4'ha: f_out = 4'h4;
      4'hb: f_out = 4'h0;
      4'hc: f_out = 4'h5;
      4'hd: f_out = 4'he;
      4'he: f_out = 4'hc;
      4'hf: f_out = 4'h1;
    endcase 
endmodule