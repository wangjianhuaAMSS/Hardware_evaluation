

module key_spec
    (
        input wire [63:0] K0,
        input wire [63:0] K1,
        input wire [63:0] alpha,
        input wire [63:0] beta,
        output wire [63:0] k0,
        output wire [63:0] k1
    );
    localparam n = 64;
    assign k0 = {K0[0], K0[n-1:2], K0[1] ^ K0[n-1]} ^ alpha;
    assign k1 = {K1[n-2:1], K1[0] ^ K1[n-2] ,K1[n-1]} ^ beta;
    
endmodule
