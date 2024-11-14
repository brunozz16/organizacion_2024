module BR (
    input wire clk,
    input wire we,
    input wire [4:0] rs1, //a1
    input wire [4:0] rs2, //a2
    input wire [4:0] rd,  //a3
    input wire [31:0] writeData, //wd3
    output wire [31:0] readData1, //rd1
    output wire [31:0] readData2  //rd2
);

    reg [31:0] registers [31:0];

    // Lectura asíncrona
    assign readData1 = registers[rs1];
    assign readData2 = registers[rs2];

    // Escritura en flanco positivo del reloj
    always @(posedge clk) begin
        if (we && rd != 5'b0) // Registro 0 es siempre 0
            registers[rd] <= writeData;
    end

    // Inicializar registros para simulación
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end
endmodule
