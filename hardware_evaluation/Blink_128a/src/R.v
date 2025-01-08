

module R
    (
        input wire [127:0] tk,
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
        localparam blockLen = 128;
        wire [blockLen-1:0] first;

        SubCells sub_inst(.indata(indata), .outdata(first));
        wire [blockLen-1:0] middle;
        MixColumns_AddKey  mix_addkey_inst(.indata(first), .key(tk), .outdata(middle));
        ShuffleCells  shuffle_inst(.indata(middle), .outdata(outdata));
endmodule
