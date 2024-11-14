module ALU (
    input [31:0] srcA,
    input [31:0] srcB,
    input [2:0] ALUControl,
    output reg [31:0] result,
    output reg zero
);

    always @(*) begin
        case (ALUControl)
            3'b000: result = srcA + srcB;    // ADD
            3'b001: result = srcA - srcB;    // SUB
            3'b010: result = srcA & srcB;    // AND
            3'b011: result = srcA | srcB;    // OR
            3'b100: result = (srcA < srcB) ? 1 : 0; // SLT
            default: result = 0;
        endcase
        zero = (result == 0);
    end
endmodule
