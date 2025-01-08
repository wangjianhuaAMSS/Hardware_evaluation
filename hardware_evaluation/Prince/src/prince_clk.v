module prince_clk(clk, rst, enc, plaintext, key, ciphertext);
    input clk;
	  input rst;
    input enc;
    input   [63:0] plaintext;
    input   [127:0] key; 
    output  [63:0] ciphertext;
    reg  [63:0] ciphertext;

    reg enc_reg;
    reg [63:0] plaintext_reg;
    reg [127:0] key_reg;
    wire [63:0] ciphertext_wire;
    prince_top pt (.enc(enc_reg), .f_in(plaintext_reg), .key(key_reg), .f_out(ciphertext_wire));

    always@(posedge clk or negedge rst) begin: aclk
        if (rst == 0) begin: clkb1
          enc_reg <= 0;
          plaintext_reg <= 64'b0;
          key_reg <= 128'b0;
          ciphertext <= 64'b0;
        end
        else begin: clkb2
          enc_reg <= enc;
          plaintext_reg <= plaintext;
          key_reg <= key;
          ciphertext <= ciphertext_wire;
        end

    end
endmodule