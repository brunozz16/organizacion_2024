module controlUnit (
    input wire [6:0] op,
    input wire [2:0] funct3,
    input wire funct7,
    input wire zero,
    output wire branch, memWrite, aluSrc, regWrite, pcSrc,
    output wire [1:0] resSrc, inmSrc,
    output wire [2:0] ALUcontrol
);
    // delcaro señales intermedias en controlUnit para conectar las salidas de mainDeco a estas señales, y luego asignarlas a las salidas de controlUnit.
    // Señales intermedias para conectar mainDeco
    wire branch_int, memWrite_int, aluSrc_int, regWrite_int;
    wire [1:0] resSrc_int, inmSrc_int, aluOp;

    mainDeco main_decoder (
        .op(op),
        .branch(branch_int),
        .resSrc(resSrc_int),
        .memWrite(memWrite_int),
        .aluSrc(aluSrc_int),
        .inmSrc(inmSrc_int),
        .regWrite(regWrite_int),
        .aluOp(aluOp)
    );

    aluDeco alu_decoder (
        .aluOp(aluOp),
        .f3(funct3),
        .f7(funct7),
        .aluControl(ALUcontrol)
    );

    assign branch = branch_int;
    assign memWrite = memWrite_int;
    assign aluSrc = aluSrc_int;
    assign regWrite = regWrite_int;
    assign resSrc = resSrc_int;
    assign inmSrc = inmSrc_int;

    assign pcSrc = branch & zero;
endmodule
