
module SubCells
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
	localparam m=32;
    genvar i;
    generate
        for(i=0; i<m; i=i+1)begin: gensbox
            sbox sbox_inst(indata[i*4+4-1:i*4], outdata[i*4+4-1:i*4]);
        end
    endgenerate
endmodule

module InvSubCells
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
	localparam m=32;
    genvar i;
    generate
        for(i=0; i<m; i=i+1)begin: geninvsbox
            Invsbox inv_sbox_inst(indata[i*4+4-1:i*4], outdata[i*4+4-1:i*4]);
        end
    endgenerate
endmodule