module SE (
    input [24:0] inm,
    input [1:0] src,
    output reg [31:0] inmExt
);

    always @(*) begin
        case (src)
            2'b00: inmExt = {{20{inm[31]}}, inm[31:20]};                   // ii0
            2'b01: inmExt = {{20{inm[31]}}, inm[31:25], inm[11:7]};        // is1
            2'b10: inmExt = {{19{inm[31]}}, inm[31], inm[7], inm[30:25], inm[11:8], 1'b0};  // ib2
            2'b11: inmExt = {{12{inm[24]}}, inm[24:12]};                   // iu3
            default: inmExt = 32'b0;
        endcase
    end
endmodule
