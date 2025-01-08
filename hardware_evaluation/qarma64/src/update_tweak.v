
module UpdateTweak
    (
        input wire [63:0] tk,
        output wire [63:0] newtk
    );
    wire [63:0] middle;
    ShuffleCellsTweak h_inst(tk, middle);
    LFSR  w_inst(middle, newtk);
endmodule

module InvUpdateTweak
    (
        input wire [63:0] tk,
        output wire [63:0] newtk
    );

        wire [63:0] middle;
        InvLFSR  w_inst(tk, middle);
        ShuffleCells  h_inst(middle, newtk);
endmodule