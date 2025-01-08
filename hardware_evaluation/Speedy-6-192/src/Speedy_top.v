module Speedy_top (f_in, K, f_out);
localparam l = 32;
localparam r = 6;
input [6*l-1:0] f_in;
input [6*l-1:0] K;
output [6*l-1:0] f_out;
wire [6*l-1:0] tmp[r-1:0];
wire [6*l-1:0] rk[r:0];
wire [6*l-1:0] rkc[r-1:0];

localparam [0:100*64-1] rc  = 6400'h243f6a8885a308d313198a2e03707344a4093822299f31d0082efa98ec4e6c89452821e638d01377be5466cf34e90c6cc0ac29b7c97c50dd3f84d5b5b54709179216d5d98979fb1bd1310ba698dfb5ac2ffd72dbd01adfb7b8e1afed6a267e96ba7c9045f12c7f9924a19947b3916cf70801f2e2858efc16636920d871574e69a458fea3f4933d7e0d95748f728eb658718bcd5882154aee7b54a41dc25a59b59c30d5392af26013c5d1b023286085f0ca417918b8db38ef8e79dcb0603a180e6c9e0e8bb01e8a3ed71577c1bd314b2778af2fda55605c60e65525f3aa55ab945748986263e8144055ca396a2aab10b6b4cc5c341141e8cea15486af7c72e993b3ee1411636fbc2a2ba9c55d741831f6ce5c3e169b87931eafd6ba336c24cf5c7a325381289586773b8f48986b4bb9afc4bfe81b6628219361d809ccfb21a991487cac605dec8032ef845d5de98575b1dc262302eb651b8823893e81d396acc50f6d6ff383f442392e0b4482a484200469c8f04a9e1f9b5e21c66842f6e96c9a670c9c61abd388f06a51a0d2d8542f68960fa728ab5133a36eef0b6c137a3be4ba3bf0507efb2a98a1f1651d39af017666ca593e82430e888cee8619456f9fb47d84a5c33b8b5ebee06f75d885c12073401a449f56c16aa64ed3aa62363f77061bfedf72429b023d37d0d724d00a1248db0fead349f1c09b075372c980991b7b25d479d8f6e8def7e3fe501ab6794c3b976ce0bd04c006bac1a94fb6409f60c45e5c9ec2196a246368fb6faf3e6c53b51339b2eb3b52ec6f6dfc511f9b30952ccc814544af5ebd09bee3d004de334afd660f2807192e4bb3c0cba85745c8740fd20b5f39b9d3fbdb5579c0bd1a60320ad6a100c6402c7279679f25fefb1fa3cc8ea5e9f8db3222f83c7516dffd616b152f501ec8ad0552ab323db5fafd23876053317b483e00df829e5c57bbca6f8ca01a87562edf1769dbd542a8f6287effc3ac6732c68c4f5573695b27b0bbca58c8e1ffa35db8f011a010fa3d98fd2183b84afcb56c2dd1d35b9a53e479b6f84565d28e49bc4bfb9790e1ddf2daa4cb7e3362fb1341cee4c6e8ef20cada36774c01d07e9efe2bf11fb495dbda4dae909198;
assign rk[0] = K;
genvar i, j;
generate
    for (i = 0; i < r; i = i+1) begin: genkpb
        Key_PB  kpb(.f_in(rk[i]), .f_out(rk[i+1]));
        if (i < r-1) begin: pkbb1
            wire [6*l-1:0] Tmp;
            assign Tmp = {rc[l*6*i+:6*l]};
            for (j = 0; j < 6*l; j=j+1) begin: genrkc
                assign rkc[i][j] = rk[i+1][j] ^ Tmp[6*l-1-j]; 
            end
        end
    end
endgenerate
assign tmp[0] = f_in ^ rk[0];
generate
    for (i = 0; i < r-1; i=i+1) begin: genrf
        Rf  Rf(.f_in(tmp[i]), .AC_AK(rkc[i]), .f_out(tmp[i+1]));
    end
endgenerate

rf  rf(.f_in(tmp[r-1]), .AK(rk[r]), .f_out(f_out));

endmodule