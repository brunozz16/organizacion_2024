module rv32i_tb;
    // Declaración de entradas y salidas para el testbench
    reg clk;
    reg reset;
    wire [31:0] pc;
    wire [31:0] instruction;
    
    // Instancia del módulo rv32i
    rv32i uut (
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    // Reloj: Alterna el valor de clk cada 5 unidades de tiempo
    always #5 clk = ~clk;

    initial begin
    $dumpfile("rv32i_tb.vcd");
        $dumpvars(0, rv32i_tb);
        // Inicialización de señales
        clk = 0;
        reset = 1; // Activa reset al inicio
        
        // Espera para simular el pulso de reset
        #10 reset = 0; // Desactiva reset después de 10 unidades de tiempo

        // Ejecuta la simulación por suficiente tiempo para recorrer toda la ROM
        // Cambia el valor de 1000 si necesitas más tiempo para probar todas las instrucciones
        #1000; 
        
        // Termina la simulación
        $finish;
    end

    // Monitoreo de señales
    initial begin
        $monitor("Time=%0t | PC=%d | Instruction=%h",
             $time, pc, instruction);

    #200 $finish;
    end

endmodule
