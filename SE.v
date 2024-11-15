module SE (
    input [24:0] inm,
    input [1:0] immSrc,
    output reg [31:0] immExt
);

    always @(*) begin
        case (immSrc)
            2'b00: immExt = {{20{inm[31]}}, inm[31:20]};                   // ii0
            2'b01: immExt = {{20{inm[31]}}, inm[31:25], inm[11:7]};        // is1
            2'b10: immExt = {{19{inm[31]}}, inm[31], inm[7], inm[30:25], inm[11:8], 1'b0};  // ib2
            2'b11: immExt = {{12{inm[31]}}, inm[19:12], inm[20], inm[30:21], 1'b0};                   // iu3
            default: immExt = 32'b0;
        endcase
    end
endmodule
