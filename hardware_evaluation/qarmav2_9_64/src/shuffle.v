

module ShuffleCells
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
	localparam m=4;
    localparam [0:63] perm_tau = {
    4'h0, 4'hb, 4'h6, 4'hd, 4'ha, 4'h1, 4'hc, 4'h7,
    4'h5, 4'he, 4'h3, 4'h8, 4'hf, 4'h4, 4'h9, 4'h2
    };

    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: genpermtau
            assign outdata[(16-i)*m-1:(15-i)*m] = indata[(16-perm_tau[i*4+:4])*m-1:(15-perm_tau[i*4+:4])*m];
        end
    endgenerate
endmodule

module InvShuffleCells
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
	localparam m=4;
    localparam [0:63] inv_tau = {
    4'h0, 4'h5, 4'hf, 4'ha, 4'hd, 4'h8, 4'h2, 4'h7,
    4'hb, 4'he, 4'h4, 4'h1, 4'h6, 4'h3, 4'h9, 4'hc
    };
    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: geninvpermtau
            assign outdata[(16-i)*m-1:(15-i)*m] = indata[(16-inv_tau[i*4+:4])*m-1:(15-inv_tau[i*4+:4])*m];
        end
    endgenerate
endmodule

module ShuffleCellsTweak
(
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
	localparam m=4;
    localparam [0:63] perm = {
    4'h1, 4'ha, 4'he, 4'h6, 4'h2, 4'h9, 4'hd, 4'h5,
    4'h0, 4'h8, 4'hc, 4'h4, 4'h3, 4'hb, 4'hf, 4'h7
    };

    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: genperm
            assign outdata[(16-i)*m-1:(15-i)*m] = indata[(16-perm[i*4+:4])*m-1:(15-perm[i*4+:4])*m];
        end
    endgenerate
endmodule

module InvShuffleCellsTweak
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
	localparam m=4;
    localparam [0:63] inv_perm = {
    4'h8, 4'h0, 4'h4, 4'hc, 4'hb, 4'h7, 4'h3, 4'hf,
    4'h9, 4'h5, 4'h1, 4'hd, 4'ha, 4'h6, 4'h2, 4'he
    };
    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: geninvperm
            assign outdata[(16-i)*m-1:(15-i)*m] = indata[(16-inv_perm[i*4+:4])*m-1:(15-inv_perm[i*4+:4])*m];
        end
    endgenerate
endmodule