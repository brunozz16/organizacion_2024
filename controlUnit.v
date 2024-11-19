module controlUnit (
    input wire [6:0] op,
    input wire [2:0] funct3,
    input wire funct7,
    input wire zero,

    output wire branch, memWrite, aluSrc, regWrite, pcSrc,
    output wire [1:0] resultSrc, immSrc,
    output wire [2:0] ALUcontrol
);
    wire [1:0] aluOp;
    wire jump;

    // Instancia de mainDeco
    mainDeco main_decoder(
        .op(op),
        .branch(branch),
        .resultSrc(resultSrc),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .immSrc(immSrc),
        .regWrite(regWrite),
        .aluOp(aluOp),
        .jump(jump)
    );


    // Instancia de aluDeco
    aluDeco alu_decoder(
        .op(aluOp),
        .opcode(op[5]),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUcontrol)
    );

    // Asignacion de pcSrc
    assign pcSrc = (branch & zero) | jump;

endmodule