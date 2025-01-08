module key_spec
    (
        input enc,
        input wire [127:0] key,
        output wire [63:0] w0,
        output wire [63:0] w1,
        output wire [63:0] k0,
        output wire [63:0] k1
    );
    localparam n = 64;
    localparam [0:256*6-1] hexPi = {
    256'h243F6A8885A308D313198A2E03707344A4093822299F31D0082EFA98EC4E6C89,
    256'h452821E638D01377BE5466CF34E90C6CC0AC29B7C97C50DD3F84D5B5B5470917,
    256'h9216D5D98979FB1BD1310BA698DFB5AC2FFD72DBD01ADFB7B8E1AFED6A267E96,
    256'hBA7C9045F12C7F9924A19947B3916CF70801F2E2858EFC16636920D871574E69,
    256'hA458FEA3F4933D7E0D95748F728EB658718BCD5882154AEE7B54A41DC25A59B5,
    256'h9C30D5392AF26013C5D1B023286085F0CA417918B8DB38EF8E79DCB0603A180E
    };
    wire [n-1:0] tmp0;
    wire [n-1:0] tmp1;
    wire [n-1:0] tmp2;
    assign tmp1 = key[n+:n];
    assign tmp0 = key[0+:n];
    assign w0 = enc? tmp1: {tmp1[0], tmp1[n-1:2], tmp1[1] ^ tmp1[n-1]};
    assign w1 = enc? {tmp1[0], tmp1[n-1:2], tmp1[1] ^ tmp1[n-1]}: tmp1;
    MixColumns mix(.indata(tmp0), .outdata(tmp2));
    assign k0 = enc? tmp0: tmp0 ^ hexPi[6*n+:n];
    assign k1 = enc? tmp0: tmp2;

endmodule
