`timescale 1ns/1ps

module top_tb;

    reg clk;
    reg reset;

    // Instancia del módulo `top`
    top uut (
        .clk(clk),
        .reset(reset)
    );

    // Generación de la señal de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Reloj con un período de 10 unidades de tiempo
    end

    // Inicialización y activación del reset
    initial begin
        // Configuración de archivo de salida para onda de señales
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
        reset = 1;
        #10 reset = 0; // Desactiva reset después de 10 unidades de tiempo
    end

    // Monitoreo de señales
    initial begin
        $display("Tiempo | PC       | Instruccion       | s0   | s1   | t0   | t1   | Mem[0]  | Mem[4]  | Mem[8]");
        $display("-------------------------------------------------------------------------------");
        
        forever begin
            @(posedge clk);  // Muestra el estado en cada flanco positivo del reloj
            $display("%0d  | %h | %h | %h | %h | %h | %h | %h | %h | %h",
                     $time,
                     uut.processor.pc,                            // PC actual
                     uut.processor.instruction,                   // Instrucción actual
                     uut.processor.data_path.regFile.registers[8], // Registro s0
                     uut.processor.data_path.regFile.registers[9], // Registro s1
                     uut.processor.data_path.regFile.registers[5], // Registro t0
                     uut.processor.data_path.regFile.registers[6], // Registro t1
                     uut.processor.data_path.data_memory.memory[0], // Memoria en dirección 0
                     uut.processor.data_path.data_memory.memory[1], // Memoria en dirección 4
                     uut.processor.data_path.data_memory.memory[2]); // Memoria en dirección 8
        end
    end

    // Condición para finalizar la simulación
    initial begin
        #5000;  // Ejecuta la simulación por un tiempo suficiente
        $finish;
    end

endmodule
