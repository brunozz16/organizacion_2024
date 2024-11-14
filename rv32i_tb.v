`timescale 1ns/1ps

module rv32i_tb;

    // Entradas
    reg clk;
    reg reset;
    reg [31:0] instruction;

    // Salidas
    wire [31:0] pc;

    // Instancia de rv32i
    rv32i uut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .pc(pc)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10 ns
    end

    // Procedimiento de prueba
    initial begin
        $dumpfile("rv32i_tb.vcd");  // Nombre del archivo .vcd
        $dumpvars(0, rv32i_tb);      // Dump de todas las variables del módulo de testbench
        // Inicialización de señales
        reset = 1;
        instruction = 32'h00000000; // Instrucción inicial

        // Liberar reset
        #10 reset = 0;

        // Prueba: Instrucción `lw`
        instruction = 32'b00000000000100000000001010000011; // lw x2, 1(x0)
        #10;

        // Prueba: Instrucción `sw`
        instruction = 32'b00000000001000000010000100100011; // sw x2, 2(x1)
        #10;

        // Prueba: Instrucción `add` (R-type)
        instruction = 32'b00000000000100000000000110110011; // add x3, x1, x1
        #10;

        // Prueba: Instrucción `beq`
        instruction = 32'b00000000000000001000000001100011; // beq x1, x2, offset
        #10;

        // Finalizar simulación
        $finish;
    end
endmodule
