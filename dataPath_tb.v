module dataPath_tb;
    reg clk;
    reg reset;
    reg branch, aluSrc, memWrite, regWrite, pcSrc;
    reg [1:0] resSrc, inmSrc;
    reg [2:0] ALUcontrol;
    wire zero;
    wire [31:0] pc;
    wire [31:0] aluResult;
    wire [31:0] writeData;
    integer instruction_count = 0; // Contador de instrucciones

    // Instancia del módulo dataPath
    dataPath uut (
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
        .zero(zero),
        .pc(pc),
        .aluResult(aluResult),
        .writeData(writeData)
    );

    // Generación del reloj
    always #5 clk = ~clk;

    initial begin
    $dumpfile("dataPath_tb.vcd");
        $dumpvars(0, dataPath_tb);
        // Inicialización de señales
        clk = 0;
        reset = 1;
        branch = 0;
        aluSrc = 0;
        memWrite = 0;
        regWrite = 0;
        pcSrc = 0;
        resSrc = 2'b00;
        inmSrc = 2'b00;
        ALUcontrol = 3'b000;

        // Reset
        #10 reset = 0;

        // Configuración de control para la simulación
        while (instruction_count < 32) begin // Ajusta el límite según las instrucciones de la ROM
            @(posedge clk);
            instruction_count = instruction_count + 1;
        end

        $finish;
    end
endmodule
