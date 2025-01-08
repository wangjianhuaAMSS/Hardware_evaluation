
module ShuffleCells
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
	localparam m=4;
    localparam [0:63] perm_tau = {
    4'h0, 4'hb, 4'h6, 4'hd, 4'ha, 4'h1, 4'hc, 4'h7,
    4'h5, 4'he, 4'h3, 4'h8, 4'hf, 4'h4, 4'h9, 4'h2
    };

    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: gentau
            assign outdata[(16-i)*m-1:(15-i)*m] = indata[(16-perm_tau[i*4+:4])*m-1:(15-perm_tau[i*4+:4])*m];
            assign outdata[(32-i)*m-1:(31-i)*m] = indata[(32-perm_tau[i*4+:4])*m-1:(31-perm_tau[i*4+:4])*m];
        end
    endgenerate
endmodule

module InvShuffleCells
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
	localparam m=4;

    localparam [0:63] inv_tau = {
    4'h0, 4'h5, 4'hf, 4'ha, 4'hd, 4'h8, 4'h2, 4'h7,
    4'hb, 4'he, 4'h4, 4'h1, 4'h6, 4'h3, 4'h9, 4'hc
    };
    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: geninvtau
            assign outdata[(16-i)*m-1:(15-i)*m] = indata[(16-inv_tau[i*4+:4])*m-1:(15-inv_tau[i*4+:4])*m];
            assign outdata[(32-i)*m-1:(31-i)*m] = indata[(32-inv_tau[i*4+:4])*m-1:(31-inv_tau[i*4+:4])*m];
        end
    endgenerate
endmodule



module ShuffleCellsTweak
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
	localparam m=4;
    localparam [0:159] perm_phi = {
    5'h01, 5'h0a, 5'h0e, 5'h16, 5'h12, 5'h19, 5'h1d, 5'h15,
    5'h00, 5'h08, 5'h0c, 5'h04, 5'h13, 5'h1b, 5'h1f, 5'h17,
    5'h11, 5'h1a, 5'h1e, 5'h06, 5'h02, 5'h09, 5'h0d, 5'h05,
    5'h10, 5'h18, 5'h1c, 5'h14, 5'h03, 5'h0b, 5'h0f, 5'h07
    };
    genvar i;
    generate
        for(i=0; i<32; i=i+1)begin: genperm
            assign outdata[(32-i)*m-1:(31-i)*m] = indata[(32-perm_phi[i*5+:5])*m-1:(31-perm_phi[i*5+:5])*m];
        end
    endgenerate
endmodule

module InvShuffleCellsTweak
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
	localparam m=4;
    localparam [0:159] inv_phi = {
        5'h08, 5'h00, 5'h14, 5'h1c, 5'h0b, 5'h17, 5'h13, 5'h1f,
        5'h09, 5'h15, 5'h01, 5'h1d, 5'h0a, 5'h16, 5'h02, 5'h1e,
        5'h18, 5'h10, 5'h04, 5'h0c, 5'h1b, 5'h07, 5'h03, 5'h0f,
        5'h19, 5'h05, 5'h11, 5'h0d, 5'h1a, 5'h06, 5'h12, 5'h0e
    };
    genvar i;
    generate
        for(i=0; i<32; i=i+1)begin: geninvperm
            assign outdata[(32-i)*m-1:(31-i)*m] = indata[(32-inv_phi[i*5+:5])*m-1:(31-inv_phi[i*5+:5])*m];
        end
    endgenerate
endmodule
