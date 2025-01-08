
module MixColumns
    (
        input [127:0] indata,
        output [127:0] outdata
    );
    localparam n = 128;
    localparam m=n>>4;
    genvar i;


    genvar col;
    generate
        for(col=0; col<4; col=col+1)begin: genrotcol
            RotCol  rot(
                {indata[m*(col)+m-1:m*(col)], indata[m*(col+4)+m-1:m*(col+4)], indata[m*(col+8)+m-1:m*(col+8)], indata[m*(col+12)+m-1:m*(col+12)]},
                {outdata[m*(col)+m-1:m*(col)], outdata[m*(col+4)+m-1:m*(col+4)], outdata[m*(col+8)+m-1:m*(col+8)], outdata[m*(col+12)+m-1:m*(col+12)]});
        end
    endgenerate
endmodule

module RotCol
    (
		inCols, outCols
    );
    localparam m = 8;
	input wire [m*4-1:0] inCols;
	output wire [m*4-1:0] outCols;
    genvar i;
    generate
        for(i=0; i<4; i=i+1)begin: genrotcells
            wire [m*4-1:0] shiftedCol;
            wire [m-1:0] rotCells[0:2];
            if (i == 0) begin: genb1
                assign shiftedCol = inCols;
            end
            else begin: genb2
                assign shiftedCol = {inCols[i*m-1:0], inCols[31:i*m]};
            end
            assign rotCells[0] = {shiftedCol[2*m-2:m], shiftedCol[2*m-1:2*m-1]};
            assign rotCells[1] = {shiftedCol[3*m-5:2*m], shiftedCol[3*m-1:3*m-4]};
            assign rotCells[2] = {shiftedCol[4*m-6:3*m], shiftedCol[4*m-1:4*m-5]};
            assign outCols[m*(i+1)-1:i*m] = rotCells[0]^rotCells[1]^rotCells[2];
        end
    endgenerate
endmodule