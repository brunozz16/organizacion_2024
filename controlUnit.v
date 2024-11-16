module controlUnit (
    input wire [6:0] op,
    input wire [2:0] funct3,
    input wire funct7,
    input wire zero,

    output wire branch, memWrite, aluSrc, regWrite, pcSrc,
    output wire [1:0] resultSrc, immSrc,
    output wire [2:0] ALUcontrol
);
    // delcaro señales intermedias en controlUnit para conectar las salidas de mainDeco a estas señales, y luego asignarlas a las salidas de controlUnit.
    // Señales intermedias para conectar mainDeco
    wire branch_int, memWrite_int, aluSrc_int, regWrite_int,jump_int;
    wire [1:0] resultSrc_int, immSrc_int, aluOp;
    
    //chequear esto
    mainDeco main_decoder(
        .op(op),
        //salidas
        .branch(branch_int),
        .resultSrc(resultSrc_int),
        .memWrite(memWrite_int),
        .aluSrc(aluSrc_int),
        .immSrc(immSrc_int),
        .regWrite(regWrite_int),
        .aluOp(aluOp),
        .jump(jump_int)
    );

    aluDeco alu_decoder(
        .op(aluOp),
        .opcode(op),
        .funct3(funct3),
        .funct7(funct7),
        //salida
        .ALUControl(ALUcontrol)
    );

    assign branch = branch_int;

    assign memWrite = memWrite_int;
    assign aluSrc = aluSrc_int;
    assign regWrite = regWrite_int;
    assign resultSrc = resultSrc_int;
    assign immSrc = immSrc_int;
    assign pcSrc = (branch & zero) | jump_int;

endmodule
