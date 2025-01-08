module qarma_top
    (   input wire enc,
        input wire[127:0] K, 
        input wire[63:0] P, 
        input wire[63:0] T, 
        output wire[63:0] C
    );
    localparam n = 64; 
    localparam round = 7;
    localparam [0:256*6-1] hexPi = {
    256'h243F6A8885A308D313198A2E03707344A4093822299F31D0082EFA98EC4E6C89,
    256'h452821E638D01377BE5466CF34E90C6CC0AC29B7C97C50DD3F84D5B5B5470917,
    256'h9216D5D98979FB1BD1310BA698DFB5AC2FFD72DBD01ADFB7B8E1AFED6A267E96,
    256'hBA7C9045F12C7F9924A19947B3916CF70801F2E2858EFC16636920D871574E69,
    256'hA458FEA3F4933D7E0D95748F728EB658718BCD5882154AEE7B54A41DC25A59B5,
    256'h9C30D5392AF26013C5D1B023286085F0CA417918B8DB38EF8E79DCB0603A180E
    };
    genvar i;
    generate
        wire [n-1:0] alpha;
        wire [n*round-1:0] roundConstants;

        assign alpha = hexPi[6*n+:n];
        if(round <= 6)begin: genrc1
            for (i = 1; i < round; i = i+1) begin: genrcinner
                assign roundConstants[n*(i+1)-1:n*i] = hexPi[i*n+:n];
            end
            assign roundConstants[n-1:0] = {n{1'b0}};
        end
        else begin: genrc2
            for (i = 1; i <= 5; i = i+1) begin: genrcinner1
                assign roundConstants[n*(i+1)-1:n*i] = hexPi[i*n+:n];
            end
            for (i = 6; i < round; i = i+1) begin: genrcinner2
                assign roundConstants[n*(i+1)-1:n*i] = hexPi[(i+1)*n+:n];
            end
            assign roundConstants[n-1:0] = {n{1'b0}};
        end
        
        wire [n-1:0] w0, w1, k0, k1;
        key_spec  key_spec_inst(enc, K, w0, w1, k0, k1);

        wire [n-1:0] Pbuf[0:round];
        wire [n-1:0] Tbuf[0:round];
        assign Pbuf[0] = P^w0;
        assign Tbuf[0] = T;
        SubCells  sub_inst0 (Pbuf[0]^Tbuf[0]^k0^roundConstants[0*n+:n], Pbuf[1]);
        UpdateTweak  update_inst0(Tbuf[0], Tbuf[1]);
        for(i=1; i<round; i=i+1)begin: genrf
            Round  round_inst(Tbuf[i]^k0^roundConstants[i*n+:n], Pbuf[i], Pbuf[i+1]);
            UpdateTweak  update_inst(Tbuf[i], Tbuf[i+1]);
        end
        wire [n-1:0] invPbuf[0:round]; 
        wire [n-1:0] preP, postP; 
        Round preP_inst(Tbuf[round]^w1, Pbuf[round], preP);
        PReflector P_inst(k1, preP, postP);
        iRound invR_inst(Tbuf[round]^w0, postP, invPbuf[round]);
        for(i=round-1; i>0; i=i-1)begin: genirf
            iRound invR_inst(Tbuf[i]^k0^alpha^roundConstants[i*n+:n], invPbuf[i+1], invPbuf[i]);
        end
        SubCells  inv_sub_inst0(invPbuf[1], invPbuf[0]);
        assign C = invPbuf[0]^w1^Tbuf[0]^k0^alpha^roundConstants[0*n+:n];
    endgenerate
endmodule
