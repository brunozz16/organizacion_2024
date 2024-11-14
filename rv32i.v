module rv32i (
    input wire clk,
    input wire reset,
    input wire [31:0] instruction,
    output wire [31:0] pc
);

    // Señales de control
    wire branch, memWrite, aluSrc, regWrite, pcSrc;
    wire [1:0] resSrc, inmSrc;
    wire [2:0] ALUcontrol;
    wire zero;
    wire [31:0] aluResult, writeData;

    // Unidad de Control
    controlUnit control_unit (
        .op(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[30]),
        .zero(zero),
        .branch(branch),
        .resSrc(resSrc),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .inmSrc(inmSrc),
        .regWrite(regWrite),
        .ALUcontrol(ALUcontrol),
        .pcSrc(pcSrc)
    );

    // Camino de Datos
    dataPath data_path (
        //entradas
        .clk(clk),
        .reset(reset),
        .branch(branch),
        .aluSrc(aluSrc),
        .memWrite(memWrite),
        .regWrite(regWrite),
        .pcSrc(pcSrc),
        .resSrc(resSrc),
        .inmSrc(inmSrc),
        .ALUcontrol(ALUcontrol),
        //salidas
        .zero(zero),
        .pc(pc),
        .aluResult(aluResult),
        .writeData(writeData)
    );

endmodule
