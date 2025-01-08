module R
    (
        input wire [63:0] rk,
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    localparam blockLen=64;
    wire [blockLen-1:0] first;
    SubCells  sub_inst(.indata(indata), .outdata(first));
        
    wire [blockLen-1:0] tmp [1:0];

    assign tmp[0] = first ^ rk;
    ShuffleCells  shuffle_inst(.indata(tmp[0]), .outdata(tmp[1]));
        
    MixColumns mix_addkey_inst(.indata(tmp[1]), .outdata(outdata));
endmodule
