module R_inv
    (
        input wire [63:0] rk,
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    localparam blockLen=64;
    wire [blockLen-1:0] first;
    MixColumns  mix_addkey_inst(.indata(indata), .outdata(first));
    wire [blockLen-1:0] tmp [1:0];
    InvShuffleCells  invshuffle_inst(.indata(first), .outdata(tmp[0]));
    assign tmp[1] = tmp[0] ^ rk;
    SubCells sub_inst(.indata(tmp[1]), .outdata(outdata));          
endmodule
