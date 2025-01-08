
module SubCells
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
    localparam n = 128;
	localparam m=n>>4;

    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: gensbox
            sbox  sbox_inst(indata[i*m+m-1:i*m], outdata[i*m+m-1:i*m]);
        end
    endgenerate
endmodule

module InvSubCells
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
    localparam n = 128;
	localparam m=n>>4;

    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: geninvsbox
            Invsbox  inv_sbox_inst(indata[i*m+m-1:i*m], outdata[i*m+m-1:i*m]);
        end
    endgenerate
endmodule