module dataPath (
    input wire clk,
    input wire reset,
    input wire aluSrc, memWrite, regWrite, pcSrc,
    input wire [1:0] resultSrc, immSrc,
    input wire [2:0] ALUcontrol,

    output wire zero,
    output wire [31:0] pc,
    //output wire [31:0] aluResult, // Salida de la ALU para pruebas
    output wire [31:0] writeData,  // Dato a escribir en memoria
    output wire [31:0] instruction     //unidad de control
);

    // Señales internas
    wire [31:0] pcNext, pcPlus4, pcTarget, immExt;
    wire [31:0] rd1, rd2, srcb, readData, result;

    wire [31:0] aluResult;

    // Registro del Contador de Programa (PC)
    PC pc_reg (
        .clk(clk),
        .reset(reset),
        .pcNext(pcNext),
        //salida
        .pc(pc)
    );

    // Memoria de Instrucciones
    rom instructionMemory (
        .address(pc[31:0]),
        //salida
        .readData(instruction)
    );

    // Banco de Registros (Register File)
    BR regFile (
        .clk(clk),
        .we3(regWrite),
        .a1(instruction[19:15]),
        .a2(instruction[24:20]),
        .a3(instruction[11:7]),
        .wd3(result),
        //salidas
        .rd1(rd1),
        .rd2(rd2)
    );

    // Extensión de Signo
    SE sign_ext (
        .inm(instruction[31:7]),
        .immSrc(immSrc),
        //salida
        .immExt(immExt)
    );

    // ALU
    ALU alu (
        .srcA(rd1),
        .srcB(srcb),
        .ALUControl(ALUcontrol),
        //salida
        .ALUResult(aluResult),
        .zero(zero)
    );

    // Memoria de Datos
    DM data_memory (
        .clk(clk),
        .a(aluResult[4:0]),
        .wd(rd2),
        .we(memWrite),
        //salida
        .rd(readData)
    );

    // Sumador para PC + 4
    Adder pc_increment (
        .op1(pc),
        .op2(32'd4),
        //salida
        .res(pcPlus4)
    );

    // Multiplexor para seleccionar entrada de ALU (srcB)
    Mux2x1 alu_src_mux (
        .e1(rd2),
        .e2(immExt),
        .sel(aluSrc),
        //salida
        .salMux(srcb)
    );

    // Sumador para dirección de salto (Branch)
    Adder branch_adder (
        .op1(pc),
        .op2(immExt),
        //salida
        .res(pcTarget)
    );

    // Multiplexor para seleccionar la próxima dirección del PC
    Mux2x1 pc_mux (
        .e1(pcPlus4),
        .e2(pcTarget),
        .sel(pcSrc),
        //salida
        .salMux(pcNext)
    );

    // Multiplexor para seleccionar el resultado de la operación
    mux3x1 result_mux(
        .e1(aluResult),
        .e2(readData),
        .e3(pcPlus4),
        .sel(resultSrc),
        .sal(result)
    );

    assign writeData = rd2; // Salida para datos a escribir en memoria de datos

endmodule
