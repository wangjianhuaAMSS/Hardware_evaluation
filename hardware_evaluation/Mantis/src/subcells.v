module SubCells
    (
        input wire [63:0] indata,
        output wire [63:0] outdata
    );
    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin: genSbox
            sbox4  sbox4(indata[i*4+4-1:i*4], outdata[i*4+4-1:i*4]);
        end
    endgenerate
endmodule
