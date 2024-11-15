`default_nettype none
`define VCD_OUTPUT "BR_tb.vcd"
`timescale 100 ns / 10 ns

module BR_tb;

    reg clk;                      // Señal de reloj
    reg [4:0] a1, a2, a3;        // Direcciones de los registros
    reg [31:0] wd3;              // Datos a escribir
    reg we;                      // Habilitación de escritura
    wire [31:0] rd1, rd2;        // Salidas de los registros

    // Instancia del módulo BR
    BR uut (
        .clk(clk),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .wd3(wd3),
        .we3(we),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Generador de la señal de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Reloj con periodo de 10 unidades de tiempo
    end

    // Procedimiento de prueba
    initial begin
        // Archivos de volcado para la simulación en VCD
        $dumpfile(`VCD_OUTPUT);
        $dumpvars(0, BR_tb);

        // Inicializa las señales
        a1 = 5'b00000;
        a2 = 5'b00001;
        a3 = 5'b00010;
        wd3 = 32'hDEADBEEF;
        we = 0;

        // Espera algunos ciclos y prueba varios valores
        #10;
        we = 1;  // Habilitar escritura
        #10; 
        we = 0;  // Deshabilitar escritura
        #10;

        // Leer los registros
        a1 = 5'b00010;  // Leer el registro 2
        a2 = 5'b00001;  // Leer el registro 1
        #10;

        // Termina la simulación
        #50 $display("End of simulation");
        $finish;
    end
endmodule
