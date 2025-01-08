module sbox
    (
        input wire [3:0] indata,
        output wire [3:0] outdata
    );
    localparam [0:63] sigma_rho = {
    4'h4, 4'h7, 4'h9, 4'hb, 4'hc, 4'h6, 4'he, 4'hf,
    4'h0, 4'h5, 4'h1, 4'hd, 4'h8, 4'h3, 4'h2, 4'ha
    };
    assign outdata = sigma_rho[indata*4+:4];
endmodule

module Invsbox
    (
        input wire [3:0] indata,
        output wire [3:0] outdata
    );
    localparam [0:63] inv_sigma_rho = {
    4'h8, 4'ha, 4'he, 4'hd, 4'h0, 4'h9, 4'h5, 4'h1,
    4'hc, 4'h2, 4'hf, 4'h3, 4'h4, 4'hb, 4'h6, 4'h7
    };
    assign outdata = inv_sigma_rho[indata*4+:4];
endmodule