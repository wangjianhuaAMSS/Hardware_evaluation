


module qarma_top
    (
        input wire enc,
        input wire[63:0] K0, 
        input wire[63:0] K1, 
        input wire[63:0] P, 
        input wire[63:0] T0, 
        input wire[63:0] T1, 
        output wire[63:0] C
    );

    localparam round = 9;
    localparam n = 64;
    localparam [128-1:0] hexPi = {
    64'h243F6A8885A308D3, 64'h13198A2E03707344
    };
    genvar i;
    generate
        wire [n-1:0] alpha, beta;
        wire [n-1:0] roundConstants[round-1:0];
        assign roundConstants[0] = 0;
        
        assign alpha = hexPi[63:0];
        PSI PSI_inst0(.in(alpha), .out(beta));
        assign roundConstants[1] = hexPi[127:64];
        for (i = 2; i <round; i = i+1) begin: genrc
            PSI PSI_inst(.in(roundConstants[i-1]), .out(roundConstants[i]));
        end
        
        
        wire [n-1:0] k0, k1;
        wire [n-1:0] W0, W1;
        wire [n-1:0] tmp0, tmp1;
        wire [n-1:0] tmpT0, tmpT1;
        wire [n-1:0] tmpW0, tmpW1;

        wire [n-1:0] tmpk0, tmpk1, tmpK0, tmpK1;
        wire [n-1:0] tmpT0r[0:round-1];
        assign tmpK0 = enc? K0:k1;
        assign tmpK1 = enc? K1:k0;
        assign tmpk0 = enc? k0:K1;
        assign tmpk1 = enc? k1:K0;
          
        assign tmpT1 = enc? T1:T0;
        assign tmpW0 = enc? W0:W1;
        assign tmpW1 = enc? W1:W0;
        assign tmpT0r[0] = enc? T0:T1;
          
        for (i = 0; i < round-1; i = i+1) begin: gentmptweak
            ShuffleCellsTweak  h_inst1(.indata(tmpT0r[i]), .outdata(tmpT0r[i+1]));
        end
        assign tmpT0 = tmpT0r[round-1];
        key_spec key_spec_inst(.K0(K0), .K1(K1), .alpha(alpha), .beta(beta), .k0(k0), .k1(k1));
        key_spec key_spec_inst1(.K0(K0), .K1(K1), .alpha({(n){1'b0}}), .beta({(n){1'b0}}), .k0(tmp0), .k1(tmp1));
        key_spec key_spec_inst2(.K0(tmp0), .K1(tmp1), .alpha({(n){1'b0}}), .beta({(n){1'b0}}), .k0(W0), .k1(W1));

        wire [n-1:0] Pbuf[0:round];
        wire [n-1:0] Tbuf0[0:round];
        wire [n-1:0] Tbuf1[0:round];
        SubCells sub_inst(.indata(P^tmpK0), .outdata(Pbuf[0]));
        assign Tbuf0[0] = tmpT0;
        assign Tbuf1[0] = tmpT1;
       
        for(i=0; i<=round-1; i=i+1)begin: genrf
            if (i%2 == 1) begin: genodd
                Round round_inst(.tk(Tbuf0[i]^tmpK0^roundConstants[i]), .indata(Pbuf[i]), .outdata(Pbuf[i+1]));
                InvShuffleCellsTweak h_inst01(.indata(Tbuf0[i]), .outdata(Tbuf0[i+1]));
                assign Tbuf1[i+1] = Tbuf1[i];
            end else begin: geneven
                Round round_inst(.tk(Tbuf1[i]^tmpK1^roundConstants[i]), .indata(Pbuf[i]), .outdata(Pbuf[i+1]));
                ShuffleCellsTweak h_inst02 (.indata(Tbuf1[i]), .outdata(Tbuf1[i+1]));
                assign Tbuf0[i+1] = Tbuf0[i];
            end
        end

        wire [n-1:0] invPbuf[0:round]; 
        wire [n-1:0] preP, middleP, postP;


        wire [n-1:0] invTbuf0[0:round];
        wire [n-1:0] invTbuf1[0:round];

        ShuffleCells  shuffle_inst(.indata(Pbuf[round]), .outdata(preP));
        if (round % 2 == 1) begin: genoddmc
            MixColumns  mix_inst(.indata(preP ^ tmpW0), .outdata(postP));
            assign middleP = postP ^ tmpW1;
        end 
        else begin: genevenmc
            MixColumns  mix_inst(.indata(preP ^ tmpW1), .outdata(postP));
            assign middleP = postP ^ tmpW0;
        end
        InvShuffleCells shuffle_inv_inst(.indata(middleP), .outdata(invPbuf[round]));

        assign invTbuf0[round] = Tbuf0[round];
        assign invTbuf1[round] = Tbuf1[round];

        
        for(i=round-1; i>=0; i=i-1)begin: geninvrf
            if (i%2 == 1) begin:geninvodd
                iRound iround_inst(.tk(invTbuf1[i+1]^tmpk1^roundConstants[i]), .indata(invPbuf[i+1]), .outdata(invPbuf[i]));
                ShuffleCellsTweak h_inst11 (.indata(invTbuf1[i+1]), .outdata(invTbuf1[i]));
                assign invTbuf0[i] = invTbuf0[i+1];
            end else begin: geninveven
                iRound iround_inst(.tk(invTbuf0[i+1]^tmpk0^roundConstants[i]), .indata(invPbuf[i+1]), .outdata(invPbuf[i]));
                InvShuffleCellsTweak h_inst12 (.indata(invTbuf0[i+1]), .outdata(invTbuf0[i]));
                assign invTbuf1[i] = invTbuf1[i+1];
            end
        end
        wire [n-1:0] last;
        InvSubCells  inv_sub_inst(.indata(invPbuf[0]), .outdata(last));
        assign C = last^tmpk1;
    endgenerate
endmodule
