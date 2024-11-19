module BR (
    input wire clk,                 // Señal de reloj
    input wire [4:0] a1,            // Dirección del primer registro a leer
    input wire [4:0] a2,            // Dirección del segundo registro a leer
    input wire [4:0] a3,            // Dirección del registro a escribir
    input wire [31:0] wd3,          // Datos a escribir
    input wire we3,                 // Habilitación de escritura
    output wire [31:0] rd1,         // Salida: Contenido del registro a1
    output wire [31:0] rd2          // Salida: Contenido del registro a2
);

    // Definición de la memoria de registros (32 registros de 32 bits)
    reg [31:0] registers [0:31];

    // Inicialización de registros
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;   // Inicializo todos los registros en 0
        end

    end

    // Lógica para escribir en los registros
    always @(posedge clk) begin
        if (we3 && a3 != 0) begin
            registers[a3] <= wd3;  // Escribir en el registro a3 si we3 está habilitado y no es el registro 0
        end

    end

    // Lectura asíncrona de los registros
    assign rd1 = registers[a1]; // El registro 0 siempre devuelve 0
    assign rd2 = registers[a2]; // El registro 0 siempre devuelve 0

endmodule
