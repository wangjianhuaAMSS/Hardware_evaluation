module PReflector
    (
        input wire [63:0] tk,
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    localparam n = 64;
    wire [n-1:0] first, middle, last;
    ShuffleCells shuffle_inst(indata, first);
    MixColumns  mix_inst(first, middle);
    assign last = middle^tk;
    InvShuffleCells  inv_shuffle_inst(last, outdata);
endmodule
