
module key_spec
    (
        input wire [127:0] K0,
        input wire [127:0] K1,
        input wire [127:0] alpha,
        input wire [127:0] beta,
        output wire [127:0] k0,
        output wire [127:0] k1
    );
        localparam n =128;
        assign k0 = {K0[0], K0[n-1:2], K0[1] ^ K0[n-1]} ^ alpha;
        assign k1 = {K1[n-2:1], K1[0] ^ K1[n-2] ,K1[n-1]} ^ beta;
    
endmodule
