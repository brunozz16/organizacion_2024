module BR (
    input wire clk,
    input wire we3,               // Señal para habilitar la escritura
    input wire [4:0] a1,              // Índice del primer registro de lectura
    input wire [4:0] a2,              // Índice del segundo registro de lectura
    input wire [4:0] a3,               // Índice del registro de escritura
    input wire [31:0] wd3,       // Dato a escribir
    output wire [31:0] rd1,      // Salida del primer registro de lectura
    output wire [31:0] rd2       // Salida del segundo registro de lectura
);

    // Definición de los 32 registros de 32 bits
    reg [31:0] registers [31:0];

    // Inicialización de registros a cero
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 0;
        end
    end

    // Lectura de registros (asíncrona)
    assign rd1 = registers[a1];
    assign rd2 = registers[a2];

    // Escritura de registros (sincronizada con el reloj)
    always @(posedge clk) begin
        if (we3 && a3 != 0) begin  // a3 = 0 es el registro cero, que debe permanecer en cero
            registers[a3] <= wd3;
        end
    end
endmodule