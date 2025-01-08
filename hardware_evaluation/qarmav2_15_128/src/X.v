module X
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
    localparam n = 128;
    localparam m = n>>2;
    assign outdata = {indata[2*m-1:m], indata[3*m-1:2*m], indata[n-1: 3*m], indata[m-1:0]}; 
endmodule