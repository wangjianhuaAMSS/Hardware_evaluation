module Mantis_top
    (
        input wire enc,
        input wire [63:0] T,
        input wire[127:0] K, 
        input wire[63:0] P, 
        output wire[63:0] C
    );
    genvar i, j;

    localparam blockLen=64;
    localparam round=7;
    //tweakey generation
    wire [blockLen*2*round-1:0] roundkey;
    wire [blockLen*2-1:0] WK;
    wire [blockLen-1:0] k0;
    wire [blockLen-1:0] k0_;
    wire [blockLen-1:0] k1;
    wire [blockLen-1:0] tmpK;
    wire [blockLen-1:0] tmpk0[2:0];
    wire [blockLen-1:0] tmpT [round:0];

    localparam [0:64*8-1] constants = {
    64'h13198a2e03707344, 64'ha4093822299f31d0, 64'h082efa98ec4e6c89, 64'h452821e638d01377, 
    64'hbe5466cf34e90c6c, 64'hc0ac29b7c97c50dd, 64'h3f84d5b5b5470917, 64'h9216d5d98979fb1b
    };

    localparam [0:63] ALPHA = 64'h243f6a8885a308d3;

    assign k0 = enc? K[127 : 64]:tmpk0[2];
    assign k0_ = enc? tmpk0[2]:K[127 : 64];
    assign k1 = enc? K[63 : 0]:tmpK;

    assign tmpk0[1] = {tmpk0[0][0], tmpk0[0][63:2], tmpk0[0][1] ^ tmpk0[0][63]};
    assign WK[blockLen-1:0] = T ^ k1 ^ k0;
    
    assign tmpT[0] = T;
    generate
        for (j = 0; j < 16; j=j+1) begin: gentmpk0
            assign tmpk0[0][(j+1)*blockLen/16-1:j*blockLen/16] = K[64+(16-j)*blockLen/16-1:64+(15-j)*blockLen/16];
            assign tmpk0[2][(j+1)*blockLen/16-1:j*blockLen/16] = tmpk0[1][(16-j)*blockLen/16-1:(15-j)*blockLen/16];
        end
        for (j = 0; j < 16; j = j+1) begin:gentmpk1
            assign tmpK[(j+1)*blockLen/16-1:j*blockLen/16] = K[(j+1)*blockLen/16-1:j*blockLen/16] ^ ALPHA[j*blockLen/16+:blockLen/16];
            assign WK[blockLen+(j+1)*blockLen/16-1:blockLen+j*blockLen/16] = T[(j+1)*blockLen/16-1:j*blockLen/16] ^ k1[(j+1)*blockLen/16-1:j*blockLen/16] ^ k0_[(j+1)*blockLen/16-1:j*blockLen/16] ^ ALPHA[j*blockLen/16+:blockLen/16];
        end
        for (i = 0; i < round; i = i+1) begin: genrk
            HShuffleCells  Hshuffle_inst(.indata(tmpT[i]), .outdata(tmpT[i+1]));
            for (j = 0; j < 16; j = j+1) begin: genrkinner
                assign roundkey[i*blockLen+(j+1)*blockLen/16-1:i*blockLen+j*blockLen/16] = k1[(j+1)*blockLen/16-1:j*blockLen/16] ^ tmpT[i+1][(j+1)*blockLen/16-1:j*blockLen/16] ^ constants[i*blockLen+j*blockLen/16+:blockLen/16];
                assign roundkey[(2*round-i-1)*blockLen+(j+1)*blockLen/16-1:(2*round-i-1)*blockLen+j*blockLen/16] = k1[(j+1)*blockLen/16-1:j*blockLen/16] ^ tmpT[i+1][(j+1)*blockLen/16-1:j*blockLen/16] ^ ALPHA[j*blockLen/16+:blockLen/16] ^ constants[i*blockLen+j*blockLen/16+:blockLen/16];
            end
        end
    endgenerate 


    //data
    wire [blockLen-1:0] tmpd0[round:0];
    wire [blockLen-1:0] tmpd1[round:0];
    
    assign tmpd0[0] = P ^ WK[blockLen-1:0];
    generate
        wire [blockLen-1:0] mid[1:0];
        for (i = 1; i <= round; i = i+1) begin: genrf
            R  rf
            (
                .rk(roundkey[i*blockLen-1:(i-1)*blockLen]),
                .indata(tmpd0[i-1]),
                .outdata(tmpd0[i])
            );
            R_inv  rf_inv
            (
                .rk(roundkey[(i+round)*blockLen-1:(round+i-1)*blockLen]),
                .indata(tmpd1[i-1]),
                .outdata(tmpd1[i])
            );
        end
        SubCells  sub_inst0(.indata(tmpd0[round]), .outdata(mid[0]));
        MixColumns  mix_addkey_inst(.indata(mid[0]), .outdata(mid[1]));
        SubCells  sub_inst1(.indata(mid[1]), .outdata(tmpd1[0]));          
    endgenerate

    assign C = tmpd1[round] ^ WK[2*blockLen-1:blockLen];
endmodule
