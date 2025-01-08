
module sbox
    (
        input wire [7:0] indata,
        output wire [7:0] outdata
    );
    localparam [0:63] sigma = {
    4'h0, 4'he, 4'h2, 4'ha, 4'h9, 4'hf, 4'h8, 4'hb,
    4'h6, 4'h4, 4'h3, 4'h7, 4'hd, 4'hc, 4'h1, 4'h5
    };
    assign {outdata[6], outdata[4], outdata[2], outdata[0]} = sigma[indata[3:0]*4+: 4];
    assign {outdata[7], outdata[5], outdata[3], outdata[1]} = sigma[indata[7:4]*4+: 4];

endmodule

module Invsbox
    (
        input wire [7:0] indata,
        output wire [7:0] outdata
    );
    localparam [0:63] sigma = {
    4'h0, 4'he, 4'h2, 4'ha, 4'h9, 4'hf, 4'h8, 4'hb,
    4'h6, 4'h4, 4'h3, 4'h7, 4'hd, 4'hc, 4'h1, 4'h5
    };
    assign outdata[3:0] = sigma[{indata[6], indata[4], indata[2], indata[0]}*4+: 4];
    assign outdata[7:4] = sigma[{indata[7], indata[5], indata[3], indata[1]}*4+: 4];
        
endmodule