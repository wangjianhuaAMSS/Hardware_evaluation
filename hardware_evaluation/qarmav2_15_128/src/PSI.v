module PSI
    (
        input wire [64-1:0] in,
        output wire [64-1:0] out
    );
    wire [63:0] spill0, tmp, spill1;
    assign spill0 = in >> 51;
    assign tmp = (in << 13) ^ (spill0 << 50) ^ (spill0 << 33) ^ (spill0 << 19) ^ spill0;
    assign spill1 = tmp >> 54;
    assign out = (tmp << 10) ^ (spill1 << 50) ^ (spill1 << 33) ^ (spill1 << 19) ^ spill1;
    
endmodule