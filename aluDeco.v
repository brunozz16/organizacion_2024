module aluDeco (
    input wire [1:0] op,           // Señal de operación de la ALU
    input wire [6:0] opcode,          // Opcode de la instrucción
    input wire [2:0] funct3,          // Campo funct3 de la instrucción
    input wire funct7,                // Bit funct7 de la instrucción
    output reg [3:0] ALUControl       // Señal de control para la ALU
);

    // Definición de las operaciones de la ALU (códigos de ALUControl)
    localparam ADD  = 4'b0000;
    localparam SUB  = 4'b0001;
    localparam AND  = 4'b0010;
    localparam OR   = 4'b0011;
    localparam XOR  = 4'b0100;
    localparam SLL  = 4'b0101;
    localparam SRL  = 4'b0110;
    localparam BEQ  = 4'b1000;
    localparam JAL  = 4'b1001;

    always @(*) begin
        case (op)
            2'b00: begin
                // Operaciones de carga/almacenamiento
                // `opcode` de `LW` (cargar palabra) y `SW` (almacenar palabra)
                if (opcode == 7'b0000011 || opcode == 7'b0100011) 
                    ALUControl = ADD;  // Usamos ADD para calcular la dirección
                else
                    ALUControl = 4'bxxxx;
            end
            2'b01: begin
                // Operaciones de tipo branch (por ejemplo, BEQ)
                if (opcode == 7'b1100011 && funct3 == 3'b000)
                    ALUControl = BEQ;  // BEQ
                else
                    ALUControl = 4'bxxxx;
            end
            2'b10: begin
                // Operaciones R-type e I-type aritméticas y lógicas
                case ({funct7, funct3})
                    4'b0000_000: ALUControl = ADD; // ADD (R-type e I-type)
                    4'b0100_000: ALUControl = SUB; // SUB (solo R-type)
                    4'b0000_111: ALUControl = AND; // AND (R-type e I-type)
                    4'b0000_110: ALUControl = OR;  // OR  (R-type e I-type)
                    4'b0000_100: ALUControl = XOR; // XOR (R-type e I-type)
                    4'b0000_001: ALUControl = SLL; // SLL (R-type e I-type)
                    4'b0000_101: ALUControl = SRL; // SRL (R-type e I-type)
                    default: ALUControl = 4'bxxxx;
                endcase
            end
            2'b11: begin
                // Operación JAL (salto incondicional)
                if (opcode == 7'b1101111)
                    ALUControl = JAL;
                else
                    ALUControl = 4'bxxxx;
            end
            default: ALUControl = 4'bxxxx;
        endcase
    end

endmodule