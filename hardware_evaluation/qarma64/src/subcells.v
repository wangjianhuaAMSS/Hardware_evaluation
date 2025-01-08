module SubCells
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    localparam n = 64;
	localparam m=n>>4;

    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: gensbox
            sbox  sbox_inst(indata[i*m+m-1:i*m], outdata[i*m+m-1:i*m]);
        end
    endgenerate
endmodule
