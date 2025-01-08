module Midori_top
    (
        input wire enc,
        input wire[127:0] K, 
        input wire[127:0] P, 
        output wire[127:0] C
    );
    genvar i, j;
    localparam blockLen=128;
    localparam round=20;
    //tweakey generation
    wire [blockLen*(round-1)-1:0] roundkey;
    wire [blockLen-1:0] WK;
    wire [blockLen*(round-1)-1:0] rk0;
    wire [blockLen*(round-1)-1:0] rk1;
    
    
    //constants
    localparam [0:19*16-1] constants = {
        16'hfc24, 16'h1156, 16'hc5a1, 16'hcb10, 16'h98c8, 16'h7451, 16'h0ec0, 
        16'h22ce, 16'h9025, 16'h441c, 16'hf994, 16'h0b8c, 16'h7410, 16'h195f, 
        16'h7237, 16'h9136, 16'h14a2, 16'h6784, 16'h0b1c
    };

    assign WK = (blockLen==128)? K: (K[127:64]^K[63:0]); 
    generate
        for (i = 0; i < round-1; i = i+1) begin: genrk
            wire [blockLen-1:0] tmpK0;
            wire [blockLen-1:0] tmpK1;
            //encrypt
            assign tmpK0 = (blockLen==128)? K: K[127-(i%2)*64:64-(i%2)*64];

            for (j = 0; j < blockLen; j= j+1) begin: genrk0
                assign rk0[i*blockLen+j] = (j % (blockLen/16) == 0)? tmpK0[j] ^ constants[16*i+15-j/(blockLen/16)]:tmpK0[j];
            end

            //decrypt 
            wire [blockLen-1:0] tmp[1:0];
            assign tmp[0] = (blockLen==128)? K: K[127-(i%2)*64:64-(i%2)*64];
            for (j = 0; j < blockLen; j= j+1) begin: gentmp
                assign tmp[1][j] = (j % (blockLen/16) == 0)? tmp[0][j] ^ constants[16*(-i+round-2)+15-j/(blockLen/16)]:tmp[0][j];
            end
            MixColumns  mix (.indata(tmp[1]), .outdata(tmpK1)); 
            InvShuffleCells invshuffle_inst(.indata(tmpK1), .outdata(rk1[(i+1)*blockLen-1:i*blockLen]));
        end
    endgenerate 
    assign roundkey = enc? rk0:rk1;


    //data
    wire [blockLen-1:0] tmpd[round:0];
    
    assign tmpd[0] = P ^ WK;
    generate
        for (i = 1; i < round; i = i+1) begin: genrf
            R  rf
            (
                .enc(enc),
                .rk(roundkey[i*blockLen-1:(i-1)*blockLen]),
                .indata(tmpd[i-1]),
                .outdata(tmpd[i])
            );
        end
    endgenerate
    wire [blockLen-1: 0] first;
    SubCells  sub_inst(.indata(tmpd[round-1]), .outdata(first));
    assign C = first ^ WK;
    
endmodule
