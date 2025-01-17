module sbox
    (
        input wire [3:0] indata,
        output wire [3:0] outdata
    );
    localparam [0:63] sigma = {
    4'h0, 4'he, 4'h2, 4'ha, 4'h9, 4'hf, 4'h8, 4'hb,
    4'h6, 4'h4, 4'h3, 4'h7, 4'hd, 4'hc, 4'h1, 4'h5
    };

    assign outdata = sigma[indata*4+:4];
endmodule

