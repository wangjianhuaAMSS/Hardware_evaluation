module SubCells
    (
        input wire [127:0] indata,
        output wire [127:0] outdata
    );
	localparam m=8;
    genvar i;
    generate
        for(i=0; i<4; i=i+1)begin: genSbox
            sbox8_0 sbox80(indata[i*8+8-1:i*8], outdata[i*8+8-1:i*8]);
            sbox8_1 sbox81(indata[32+i*8+8-1:32+i*8], outdata[32+i*8+8-1:32+i*8]);
            sbox8_2 sbox82(indata[64+i*8+8-1:64+i*8], outdata[64+i*8+8-1:64+i*8]);
            sbox8_3 sbox83(indata[96+i*8+8-1:96+i*8], outdata[96+i*8+8-1:96+i*8]);
        end
    endgenerate
    
endmodule
