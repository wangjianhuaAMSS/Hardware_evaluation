module MixColumns
    (
        input [63:0] indata,
        output [63:0] outdata
    );
    localparam n = 64;
    localparam m = 4;

    genvar col, l;
    generate
        for(col=0; col<4; col=col+1)begin: gen_col
            for (l = 0; l < n/64; l = l+1) begin: gen_plane
                RotCol rotcol(
                {indata[m*(l*16+col+1)-1:m*(l*16+col)], indata[m*(l*16+4+col+1)-1:m*(l*16+4+col)], indata[m*(l*16+8+col+1)-1:m*(l*16+8+col)], indata[m*(l*16+12+col+1)-1:m*(l*16+12+col)]},
                {outdata[m*(l*16+col+1)-1:m*(l*16+col)], outdata[m*(l*16+4+col+1)-1:m*(l*16+4+col)], outdata[m*(l*16+8+col+1)-1:m*(l*16+8+col)], outdata[m*(l*16+12+col+1)-1:m*(l*16+12+col)]}); 
            end
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
        for(i=0; i<4; i=i+1)begin: gen_element
            wire [m*4-1:0] shiftedCol;
            if (i == 0) begin: branch1
                assign shiftedCol = inCols;
            end
            else begin: branch2
                assign shiftedCol = {inCols[(15+i*m)%16:0], inCols[15:i*m]};
            end
            assign outCols[m*(i+1)-1:i*m] = shiftedCol[2*m-1:m]^shiftedCol[3*m-1:2*m]^shiftedCol[4*m-1:3*m];
        end
    endgenerate
endmodule


