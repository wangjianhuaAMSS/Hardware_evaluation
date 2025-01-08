
module ShuffleCells
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    localparam n = 64;
	localparam m=n>>4;
    localparam [0:63] perm_tau = {
    4'h0, 4'hb, 4'h6, 4'hd, 4'ha, 4'h1, 4'hc, 4'h7,
    4'h5, 4'he, 4'h3, 4'h8, 4'hf, 4'h4, 4'h9, 4'h2
    };

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
        for(i=0; i<16; i=i+1)begin: genperm
            assign outIS[i*m+:m] = inIS[perm_tau[i*4+:4]*m+:m];
        end
    endgenerate
endmodule

module InvShuffleCells
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    localparam n = 64;
	localparam m=n>>4;
    localparam [0:63] inv_tau = {
    4'h0, 4'h5, 4'hf, 4'ha, 4'hd, 4'h8, 4'h2, 4'h7,
    4'hb, 4'he, 4'h4, 4'h1, 4'h6, 4'h3, 4'h9, 4'hc
    };
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
        for(i=0; i<16; i=i+1)begin: geninvperm
            assign outIS[i*m+:m] = inIS[inv_tau[i*4+:4]*m+:m];
        end
    endgenerate
endmodule



module ShuffleCellsTweak
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    localparam n = 64;
	localparam m=n>>4;

    localparam [0:63] perm_h = {
    4'h6, 4'h5, 4'he, 4'hf, 4'h0, 4'h1, 4'h2, 4'h3,
    4'h7, 4'hc, 4'hd, 4'h4, 4'h8, 4'h9, 4'ha, 4'hb
    };

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
        for(i=0; i<16; i=i+1)begin: genperm
            assign outIS[i*m+:m] = inIS[perm_h[i*4+:4]*m+:m];
        end
    endgenerate
endmodule

module InvShuffleCellsTweak
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    localparam n = 64;
	localparam m=n>>4;

    localparam [0:63] inv_h = {
    4'h4, 4'h5, 4'h6, 4'h7, 4'hb, 4'h1, 4'h0, 4'h8,
    4'hc, 4'hd, 4'he, 4'hf, 4'h9, 4'ha, 4'h2, 4'h3
    };
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
        for(i=0; i<16; i=i+1)begin: geninvperm
            assign outIS[i*m+:m] = inIS[inv_h[i*4+:4]*m+:m];
        end
    endgenerate
endmodule