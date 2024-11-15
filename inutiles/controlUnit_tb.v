`timescale 1ns/1ps

module controlUnit_tb;

    // Entradas
    reg [6:0] op;
    reg [2:0] funct3;
    reg funct7;
    reg zero;

    // Salidas
    wire branch;
    wire [1:0] resSrc;
    wire memWrite;
    wire aluSrc;
    wire [1:0] inmSrc;
    wire regWrite;
    wire [2:0] ALUcontrol;
    wire pcSrc;

    // Instancia de controlUnit
    controlUnit uut (
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
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

    // Procedimiento de prueba
    initial begin
        // Configuración de archivo de salida para onda de señales
        $dumpfile("controlUnit_tb.vcd");
        $dumpvars(0, controlUnit_tb);
        // Prueba de instrucción `lw`
        op = 7'b0000011; // lw
        funct3 = 3'b010;
        funct7 = 0;
        zero = 0;
        #10;

        // Prueba de instrucción `sw`
        op = 7'b0100011; // sw
        funct3 = 3'b010;
        funct7 = 0;
        zero = 0;
        #10;

        // Prueba de instrucción `R-type` (add)
        op = 7'b0110011; // R-type
        funct3 = 3'b000;
        funct7 = 0;
        zero = 0;
        #10;

        // Prueba de instrucción `beq`
        op = 7'b1100011; // beq
        funct3 = 3'b000;
        funct7 = 0;
        zero = 1; // Condición de salto
        #10;
        #10;
        #10;

        // Finalizar simulación
        $finish;
    end
endmodule
