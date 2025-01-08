module sbox8_0 
    (
        input wire [7:0] indata,
        output wire [7:0] outdata
    );
    //8-bit 
    localparam [0:63] sigma = {
        4'h1, 4'h0, 4'h5, 4'h3, 4'he, 4'h2, 4'hf, 4'h7,
        4'hd, 4'ha, 4'h9, 4'hb, 4'hc, 4'h8, 4'h4, 4'h6
    };

    localparam [0:24-1] pb_0 = {
        3'h4, 3'h1, 3'h6, 3'h3, 3'h0, 3'h5, 3'h2, 3'h7
    };
    wire [7:0] tmp [1:0];
    genvar i;
    generate
        for (i = 0; i < 8; i = i+1) begin: genoutdata
            assign tmp[0][7-i] = indata[7-pb_0[i*3+:3]];
            assign outdata[7-pb_0[i*3+:3]] = tmp[1][7-i];
        end
    endgenerate
    assign tmp[1][7:4] = sigma[tmp[0][7:4]*4+:4];
    assign tmp[1][3:0] = sigma[tmp[0][3:0]*4+:4];
endmodule

module sbox8_1
    (
        input wire [7:0] indata,
        output wire [7:0] outdata
    );
    //8-bit 
    localparam [0:63] sigma = {
        4'h1, 4'h0, 4'h5, 4'h3, 4'he, 4'h2, 4'hf, 4'h7,
        4'hd, 4'ha, 4'h9, 4'hb, 4'hc, 4'h8, 4'h4, 4'h6
    };

    localparam [0:24-1] pb_1 = {
        3'h1, 3'h6, 3'h7, 3'h0, 3'h5, 3'h2, 3'h3, 3'h4
    };
    wire [7:0] tmp [1:0];
    genvar i;
    generate
        for (i = 0; i < 8; i = i+1) begin: genoutdata
            assign tmp[0][7-i] = indata[7-pb_1[i*3+:3]];
            assign outdata[7-pb_1[i*3+:3]] = tmp[1][7-i];
        end
    endgenerate
    assign tmp[1][7:4] = sigma[tmp[0][7:4]*4+:4];
    assign tmp[1][3:0] = sigma[tmp[0][3:0]*4+:4];
endmodule

module sbox8_2
    (
        input wire [7:0] indata,
        output wire [7:0] outdata
    );
    //8-bit 
    localparam [0:63] sigma = {
        4'h1, 4'h0, 4'h5, 4'h3, 4'he, 4'h2, 4'hf, 4'h7,
        4'hd, 4'ha, 4'h9, 4'hb, 4'hc, 4'h8, 4'h4, 4'h6
    };

    localparam [0:24-1] pb_2 = {
        3'h2, 3'h3, 3'h4, 3'h1, 3'h6, 3'h7, 3'h0, 3'h5
    };
    wire [7:0] tmp [1:0];
    genvar i;
    generate
        for (i = 0; i < 8; i = i+1) begin: genoutdata
            assign tmp[0][7-i] = indata[7-pb_2[i*3+:3]];
            assign outdata[7-pb_2[i*3+:3]] = tmp[1][7-i];
        end
    endgenerate
    assign tmp[1][7:4] = sigma[tmp[0][7:4]*4+:4];
    assign tmp[1][3:0] = sigma[tmp[0][3:0]*4+:4];
endmodule

module sbox8_3 
    (
        input wire [7:0] indata,
        output wire [7:0] outdata
    );
    //8-bit 
    localparam [0:63] sigma = {
        4'h1, 4'h0, 4'h5, 4'h3, 4'he, 4'h2, 4'hf, 4'h7,
        4'hd, 4'ha, 4'h9, 4'hb, 4'hc, 4'h8, 4'h4, 4'h6
    };

    localparam [0:24-1] pb_3 = {
        3'h7, 3'h4, 3'h1, 3'h2, 3'h3, 3'h0, 3'h5, 3'h6
    };
    wire [7:0] tmp [1:0];
    genvar i;
    generate
        for (i = 0; i < 8; i = i+1) begin: genoutdata
            assign tmp[0][7-i] = indata[7-pb_3[i*3+:3]];
            assign outdata[7-pb_3[i*3+:3]] = tmp[1][7-i];
        end
    endgenerate
    assign tmp[1][7:4] = sigma[tmp[0][7:4]*4+:4];
    assign tmp[1][3:0] = sigma[tmp[0][3:0]*4+:4];
endmodule