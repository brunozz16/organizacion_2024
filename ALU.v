module ALU (
    input [31:0] srcA,
    input [31:0] srcB,
    input [2:0] ALUControl,
    output reg [31:0] ALUResult,
    output reg zero
);

    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = srcA + srcB;    // ADD
            3'b001: ALUResult = srcA - srcB;    // SUB
            3'b010: ALUResult = srcA & srcB;    // AND
            3'b011: ALUResult = srcA | srcB;    // OR
            3'b100: ALUResult = (srcA < srcB) ? 1 : 0; // SLT
            default: ALUResult = 0;
        endcase
        
    // Asignación de la señal zero
    if (ALUResult == 0)
    begin
        zero = 1'b1;
    end else begin
        zero = 1'b0;
    end

    end
endmodule
