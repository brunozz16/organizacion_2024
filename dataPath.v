module dataPath (
    input wire clk,
    input wire reset,
    input wire branch, aluSrc, memWrite, regWrite, pcSrc,
    input wire [1:0] resSrc, inmSrc,
    input wire [2:0] ALUcontrol,
    output wire zero,
    output wire [31:0] pc,
    output wire [31:0] aluResult, // Salida de la ALU para pruebas
    output wire [31:0] writeData  // Dato a escribir en memoria
);

    // Señales internas necesarias
    wire [31:0] pcNext, pcPlus4, branchTarget, signExtImm;
    wire [31:0] rd1, rd2, srcb, readData, result,instructionrom;
    
    // Registro del Contador de Programa (PC)
    PC pc_reg (
        .clk(clk),
        .reset(reset),
        .pcNext(pcNext),
        .pc(pc)
    );

    // Memoria de Instrucciones
    rom instructionMemory (
        .address(pc[4:0]),
        .data(instructionrom)
    );

    // Banco de Registros (BR)
    BR regFile (
        .clk(clk),
        .we(regWrite),
        .rs1(instructionrom[19:15]),
        .rs2(instructionrom[24:20]),
        .rd(instructionrom[11:7]),
        .writeData(result),
        .readData1(rd1),
        .readData2(rd2)
    );

    // Extensión de Signo (SE)
    SE sign_ext (
        .inm(instructionrom[31:7]),
        .src(inmSrc),
        .inmExt(signExtImm)
    );

    // ALU para operaciones aritmético-lógicas
    ALU alu (
        .srcA(rd1),
        .srcB(srcb),
        .ALUControl(ALUcontrol),
        .result(aluResult),
        .zero(zero)
    );
    
    // Memoria de Datos
    DM data_memory (
        .clk(clk),
        .addresDM(aluResult[4:0]),
        .wd(rd2),
        .we(memWrite),
        .rd(readData)
    );

    // Sumador para calcular PC + 4
    Adder pc_increment (
        .op1(pc),
        .op2(32'd4),
        .res(pcPlus4)
    );

    // Multiplexor para seleccionar entrada de ALU (srcB)
    Mux2x1 alu_src_mux (
        .e1(rd2),
        .e2(signExtImm),
        .sel(aluSrc),
        .salMux(srcb)
    );

    // Sumador para dirección de salto (Branch)
    Adder branch_adder (
        .op1(pc),
        .op2(signExtImm),
        .res(branchTarget)
    );

    // Selección de próxima dirección del PC (pcNext)
    Mux2x1 pc_mux (
        .e1(pcPlus4),
        .e2(branchTarget),
        .sel(pcSrc),
        .salMux(pcNext)
    );

    // Multiplexor para seleccionar dato a escribir en BR o Memoria
    Mux2x1 dm_br_mux (
        .e1(aluResult),
        .e2(readData),
        .sel(resSrc),
        .salMux(result)
    );

endmodule
