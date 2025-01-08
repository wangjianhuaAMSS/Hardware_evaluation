
module UpdateTweak
    (
        input wire [127:0] tk,
        output wire [127:0] newtk
    );
    wire [127:0] middle;
    ShuffleCellsTweak h_inst(tk, middle);
    LFSR  w_inst(middle, newtk);
endmodule

module InvUpdateTweak
    (
        input wire [127:0] tk,
        output wire [127:0] newtk
    );

        wire [127:0] middle;
        InvLFSR  w_inst(tk, middle);
        ShuffleCells  h_inst(middle, newtk);
endmodule
