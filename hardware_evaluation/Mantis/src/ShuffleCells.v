module ShuffleCells
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
	localparam m= 4;
    genvar i;
    localparam [0:4*16-1] perm = {
    4'h0, 4'hb, 4'h6, 4'hd, 4'ha, 4'h1, 4'hc, 4'h7,
    4'h5, 4'he, 4'h3, 4'h8, 4'hf, 4'h4, 4'h9, 4'h2
    };
    generate
        for(i=0; i< 16; i=i+1)begin: genPerm
            assign outdata[(i+1)*m-1:i*m] = indata[(perm[i*4+:4]+1)*m-1:perm[i*4+:4]*m];
        end
    endgenerate
endmodule

module InvShuffleCells
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
	localparam m= 4;
    genvar i;
    localparam [0:4*16-1] inv_perm = {
    4'h0, 4'h5, 4'hf, 4'ha, 4'hd, 4'h8, 4'h2, 4'h7,
    4'hb, 4'he, 4'h4, 4'h1, 4'h6, 4'h3, 4'h9, 4'hc
    };
    generate
        for(i=0; i< 16; i=i+1)begin: genInvPerm
            assign outdata[(i+1)*m-1:i*m] = indata[(inv_perm[i*4+:4]+1)*m-1:inv_perm[i*4+:4]*m];
        end
    endgenerate
endmodule


module HShuffleCells
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
	localparam m= 4;
    genvar i;
    localparam [0:4*16-1] h = {
    4'h6, 4'h5, 4'he, 4'hf, 4'h0, 4'h1, 4'h2, 4'h3,
    4'h7, 4'hc, 4'hd, 4'h4, 4'h8, 4'h9, 4'ha, 4'hb
    };
    generate
        for(i=0; i< 16; i=i+1)begin: genHPerm
            assign outdata[(i+1)*m-1:i*m] = indata[(h[i*4+:4]+1)*m-1:h[i*4+:4]*m];
        end
    endgenerate
endmodule