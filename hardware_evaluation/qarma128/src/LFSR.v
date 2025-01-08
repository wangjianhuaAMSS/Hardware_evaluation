module LFSR
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
    localparam n = 128;
	localparam m=n>>4;
    localparam [15:0] indices = 
        1'b1 << 0 | 1'b1 << 1 | 1'b1 << 3 | 1'b1 << 4 | 1'b1 << 8 | 1'b1 << 11 | 1'b1 << 13;
    wire [n-1:0] inIS;
    assign inIS = {indata[0*m+:m], indata[1*m+:m], indata[2*m+:m], indata[3*m+:m],
                    indata[4*m+:m], indata[5*m+:m], indata[6*m+:m], indata[7*m+:m],
                    indata[8*m+:m], indata[9*m+:m], indata[10*m+:m], indata[11*m+:m],
                    indata[12*m+:m], indata[13*m+:m], indata[14*m+:m], indata[15*m+:m]
    };
    wire [n-1:0] outIS;

    assign outdata = {outIS[0*m+:m], outIS[1*m+:m], outIS[2*m+:m], outIS[3*m+:m],
                     outIS[4*m+:m], outIS[5*m+:m], outIS[6*m+:m], outIS[7*m+:m],
                     outIS[8*m+:m], outIS[9*m+:m], outIS[10*m+:m], outIS[11*m+:m],
                     outIS[12*m+:m], outIS[13*m+:m], outIS[14*m+:m], outIS[15*m+:m]
                    };
    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: genlfsr
            if(indices[i] == 1'b1) begin: lfsrb1
                LFSR_inner inner(inIS[i*m+:m], outIS[i*m+:m]);
            end
            else begin: lfsrb2
                assign outIS[i*m+:m] = inIS[i*m+:m];
            end
        end
    endgenerate
endmodule

module InvLFSR
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
    localparam n = 128;
	localparam m=n>>4;
    localparam [15:0] indices = 
        1'b1 << 0 | 1'b1 << 1 | 1'b1 << 3 | 1'b1 << 4 | 1'b1 << 8 | 1'b1 << 11 | 1'b1 << 13;
    wire [n-1:0] inIS;
    assign inIS = {indata[0*m+:m], indata[1*m+:m], indata[2*m+:m], indata[3*m+:m],
                    indata[4*m+:m], indata[5*m+:m], indata[6*m+:m], indata[7*m+:m],
                    indata[8*m+:m], indata[9*m+:m], indata[10*m+:m], indata[11*m+:m],
                    indata[12*m+:m], indata[13*m+:m], indata[14*m+:m], indata[15*m+:m]
    };
    wire [n-1:0] outIS;

    assign outdata = {outIS[0*m+:m], outIS[1*m+:m], outIS[2*m+:m], outIS[3*m+:m],
                     outIS[4*m+:m], outIS[5*m+:m], outIS[6*m+:m], outIS[7*m+:m],
                     outIS[8*m+:m], outIS[9*m+:m], outIS[10*m+:m], outIS[11*m+:m],
                     outIS[12*m+:m], outIS[13*m+:m], outIS[14*m+:m], outIS[15*m+:m]
                    };
    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: genlfsr
            if(indices[i] == 1'b1) begin: lfsrb1
                InvLFSR_inner invinner(inIS[i*m+:m], outIS[i*m+:m]);
            end
            else begin: lfsrb2
                assign outIS[i*m+:m] = inIS[i*m+:m];
            end
        end
    endgenerate
endmodule


module LFSR_inner
    (
        input wire [7:0] indata,
        output wire [7:0] outdata
    );
    assign outdata = {indata[0]^indata[2], indata[7:1]};
endmodule

module InvLFSR_inner
    (
        input wire [7:0] indata,
        output wire [7:0] outdata
    );
    assign outdata = {indata[6:0], indata[7]^indata[1]};

endmodule

