
module Round
    (
        input wire [63:0] tk,
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    localparam n = 64;
    wire [n-1:0] first;
    wire [n-1:0] last;
    wire [n-1:0] tmp;

    assign first = tk^indata;
    wire [n-1:0] middle;
    ShuffleCells shuffle_inst(first, middle);
    MixColumns mix_inst(middle, last);
    SubCells  sub_inst(last, outdata);

endmodule


module iRound
    (
        input wire [63:0] tk,
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    localparam n = 64;
    wire [n-1:0] first;
    wire [n-1:0] last;

    InvSubCells  inv_sub_inst(indata, first);
    wire [n-1:0] middle;
    MixColumns  mix_inst(first, middle);
    InvShuffleCells  inv_shuffle_inst(middle, last);
    assign outdata = tk^last;
endmodule