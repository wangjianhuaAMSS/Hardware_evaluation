module MixColumns
    (
        input [127:0] indata,
        output [127:0] outdata
    );
    localparam n = 128;
    localparam m = 8;

    genvar col, l;
    generate
        for(col=0; col<4; col=col+1)begin: genrotcol
            RotCol  rotcol(
                {indata[m*(col+1)-1:m*col], indata[m*(4+col+1)-1:m*(4+col)], indata[m*(8+col+1)-1:m*(8+col)], indata[m*(12+col+1)-1:m*(12+col)]},
                {outdata[m*(col+1)-1:m*col], outdata[m*(4+col+1)-1:m*(4+col)], outdata[m*(8+col+1)-1:m*(8+col)], outdata[m*(12+col+1)-1:m*(12+col)]}); 
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
        for(i=0; i<4; i=i+1)begin: genout
            wire [m*4-1:0] shiftedCol;
            wire [m-1:0] rotCells[2:0];
            if (i == 0) begin: genb1
                assign shiftedCol = inCols;
            end
            else begin: genb2
                assign shiftedCol = {inCols[i*m-1:0], inCols[31:i*m]};
            end
            assign rotCells[0] = shiftedCol[2*m-1:m];
            assign rotCells[1] = shiftedCol[3*m-1:2*m];
            assign rotCells[2] = shiftedCol[4*m-1:3*m];
            assign outCols[m*(i+1)-1:i*m] = rotCells[0]^rotCells[1]^rotCells[2];
        end
    endgenerate
endmodule
