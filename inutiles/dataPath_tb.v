module DP_tb;

    // Declaración de señales
    reg clk;
    reg reset;
    reg [1:0] DP_ResultSrc;
    reg [2:0] DP_ALUControl;
    reg [1:0] DP_ImmSrc;
    reg DP_RegWrite;
    reg DP_ALUSrc;
    reg DP_MemWrite;
    reg DP_PCSrc;
    wire [31:0] pc;
    wire [31:0] instr;
    wire [6:0] op;
    wire [2:0] funct3;
    wire funct7;
    wire zero;

    // Instancia del módulo Datapath (DP)
    DP uut (
        .clk(clk),
        .reset(reset),
        .aluSrc(DP_ResultSrc),
        .ALUcontrol(DP_ALUControl),
        .immSrc(DP_ImmSrc),
        .regWrite(DP_RegWrite),
        .DP_ALUSrc(DP_ALUSrc),
        .memWrite(DP_MemWrite),
        .pcSrc(DP_PCSrc),
        .pc(pc),
        .instr(instr),
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .zero(zero)
    );
// Generador de reloj
    always #5 clk = ~clk; // Reloj alterna cada 5 unidades de tiempo

    // Inicialización y estímulos
    initial begin
        $dumpfile("DP_tb.vcd");
        $dumpvars(0, DP_tb);

        // Inicialización de señales
        clk = 0;
        reset = 1; // Activa reset
        DP_ResultSrc = 2'b00; // Configuración inicial del multiplexor de resultados
        DP_ALUControl = 3'b010; // Operación ALU por defecto (suma)
        DP_ImmSrc = 2'b00; // Modo inmediato inicial
        DP_RegWrite = 0;
        DP_ALUSrc = 0;
        DP_MemWrite = 0;
        DP_PCSrc = 0;

        // Ciclo de reset
        #10 reset = 0; // Desactiva reset después de 10 unidades de tiempo

        // Estímulos
        // Simula operaciones de ejemplo
        #10 DP_RegWrite = 1; DP_ALUSrc = 1; // Habilita escritura en registros y selecciona operandos inmediatos
        #20 DP_PCSrc = 1; DP_ResultSrc = 2'b01; // Cambia a branch y selecciona datos de memoria
        #30 DP_ALUControl = 3'b101; // Cambia operación ALU (ej: SLT)
        #40 DP_PCSrc = 0; DP_ResultSrc = 2'b00; // Regresa a modo normal
        #50 DP_RegWrite = 0; DP_MemWrite = 1; // Escribe en memoria

        // Terminar simulación después de suficiente tiempo
        #100;
        $finish;
    end

    // Monitoreo de señales clave
    initial begin
        $monitor("Time=%0t | PC=%h | Instr=%h | ALU ResultSrc=%b | ImmSrc=%b | Zero=%b",
            $time, pc, instr, DP_ResultSrc, DP_ImmSrc, zero);
    end

endmodule