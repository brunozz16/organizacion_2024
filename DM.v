module DM (
    input wire clk,
    input wire [4:0] a,
    input wire [31:0] wd,
    input wire we,
    output reg [31:0] rd
);
    // Memoria de 32 palabras de 32 bits cada una
    reg [31:0] memory [0:31];

    // Escritura en memoria
    always @(posedge clk) begin
        if (we) begin
            memory[a] <= wd;
        end
    end

    // Lectura de memoria (asíncrona)
    always @(*) begin
        rd = memory[a];
    end
endmodule
