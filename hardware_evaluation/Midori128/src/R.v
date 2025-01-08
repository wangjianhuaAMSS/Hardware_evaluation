module R
    (
        input enc,
        input wire [127:0] rk,
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
    localparam blockLen=128;
    wire [blockLen-1:0] first;
    SubCells  sub_inst(.indata(indata), .outdata(first));
        
        
    wire [blockLen-1:0] tmp [4:0];
    ShuffleCells shuffle_inst0(.indata(first), .outdata(tmp[0]));
    assign tmp[1]= (enc==0)? first: tmp[0];
            
    MixColumns  mix_inst(.indata(tmp[1]), .outdata(tmp[2]));
            
            
    InvShuffleCells  inv_shuffle_inst1(.indata(tmp[2]), .outdata(tmp[3]));

    assign tmp[4] = (enc==0)?tmp[3]:tmp[2];
            
    assign outdata = rk^tmp[4];
endmodule
