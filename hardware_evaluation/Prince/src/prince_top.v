module prince_top (enc, f_in, key, f_out); //enc = 1 encrypt, else decrypt
    input enc;
    input [63: 0] f_in;
    input [127: 0] key;
    output [63: 0] f_out;

    wire [63:0] tmp[13:0];
    wire [63:0] k0;
    wire [63:0] k1;
    wire [63:0] kp;
    localparam ALPHA = 64'hc0ac29b7c97c50dd;
    localparam [64*12-1: 0] rc = {   
    64'hc0ac29b7c97c50dd,
    64'hd3b5a399ca0c2399,
    64'h64a51195e0e3610d,
    64'hc882d32f25323c54,
    64'h85840851f1ac43aa,
    64'h7ef84f78fd955cb1,
    64'hbe5466cf34e90c6c,
    64'h452821e638d01377,
    64'h082efa98ec4e6c89,
    64'ha4093822299f31d0,
    64'h13198a2e03707344,
    64'h0000000000000000
    };
    
    assign k0 = enc? key[127 : 64]:{kp[0], kp[63 : 2], (kp[1] ^ kp[63])};
    assign k1 = enc? key[63 : 0] : key[63 : 0] ^ ALPHA;
    assign kp = enc? {k0[0], k0[63 : 2], (k0[1] ^ k0[63])}:key[127 : 64];


    assign tmp[0] = f_in ^ k0;
    round0 r0(.f_in(tmp[0]), .key(k1  ^ rc[63:0]), .f_out(tmp[1]));
    genvar i;
    generate
        for (i = 1; i <= 5; i = i+1) begin: genrf
            wire [63:0] mid;
            round  r (.f_in(tmp[i]), .key(k1 ^ rc[(i+1)*64-1:i*64]),  .f_out(tmp[i+1]));
            iround  ir (.f_in(tmp[i+6]), .key(k1 ^ rc[(i+6)*64-1:(i+5)*64]),  .f_out(tmp[i+7]));
        end
    endgenerate
    mid_round mr(.f_in(tmp[6]), .f_out(tmp[7]));


    round11 r11(.f_in(tmp[12]), .key(k1 ^ rc[12*64-1: 11*64]),  .f_out(tmp[13]));
    assign  f_out = tmp[13] ^ kp;

endmodule