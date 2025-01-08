

module MixColumns
    (
        input [127:0] indata,
        output [127:0] outdata
    );
    localparam m = 4;

    genvar col;
    generate
        for(col=0; col<4; col=col+1)begin: genrotcol
            RotCol  rot1(
                {indata[m*(4-col)-1:m*(3-col)], indata[m*(8-col)-1:m*(7-col)], indata[m*(12-col)-1:m*(11-col)], indata[m*(16-col)-1:m*(15-col)]},
                {outdata[m*(4-col)-1:m*(3-col)], outdata[m*(8-col)-1:m*(7-col)], outdata[m*(12-col)-1:m*(11-col)], outdata[m*(16-col)-1:m*(15-col)]}); 
            RotCol  rot2(
                {indata[m*(16+4-col)-1:m*(16+3-col)], indata[m*(16+8-col)-1:m*(16+7-col)], indata[m*(16+12-col)-1:m*(16+11-col)], indata[m*(16+16-col)-1:m*(16+15-col)]},
                {outdata[m*(16+4-col)-1:m*(16+3-col)], outdata[m*(16+8-col)-1:m*(16+7-col)], outdata[m*(16+12-col)-1:m*(16+11-col)], outdata[m*(16+16-col)-1:m*(16+15-col)]}); 
        end
    endgenerate
endmodule


module RotCol
    (
		inCols, outCols
    );
    localparam m = 4;
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
                assign shiftedCol = {inCols[i*m-1:0], inCols[15:i*m]};
            end
            assign rotCells[0] = {shiftedCol[2*m-2:m], shiftedCol[2*m-1:2*m-1]};
            assign rotCells[1] = {shiftedCol[3*m-3:2*m], shiftedCol[3*m-1:3*m-2]};
            assign rotCells[2] = {shiftedCol[4*m-4:3*m], shiftedCol[4*m-1:4*m-3]};
            assign outCols[m*(i+1)-1:i*m] = rotCells[0]^rotCells[1]^rotCells[2];
        end
    endgenerate
endmodule
