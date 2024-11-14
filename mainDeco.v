module mainDeco (
    input [6:0] op,
    output reg branch,
    output reg [1:0] resSrc,
    output reg memWrite,
    output reg aluSrc,
    output reg [1:0] inmSrc,
    output reg regWrite,
    output reg [1:0] aluOp
);

    always @(*) begin
        //valores predeterminados
        regWrite = 0;
        inmSrc = 2'b00;
        aluSrc = 0;
        memWrite = 0;
        resSrc = 2'b00;
        branch = 0;
        aluOp = 2'b00;
        case (op)
            7'b0000011: begin // lw
                regWrite = 1;
                inmSrc = 2'b00;
                aluSrc = 1;
                memWrite = 0;
                resSrc = 2'b01;
                branch = 0;
                aluOp = 2'b00;
            end
            7'b0100011: begin // sw
                regWrite = 0;
                inmSrc = 2'b01;
                aluSrc = 1;
                memWrite = 1;
                resSrc = 2'bXX; // Ignorado
                branch = 0;
                aluOp = 2'b00;
            end
            7'b0110011: begin // R-type
                regWrite = 1;
                inmSrc = 2'bXX;
                aluSrc = 0;
                memWrite = 0;
                resSrc = 2'b00;
                branch = 0;
                aluOp = 2'b10;
            end
            7'b1100011: begin // beq
                regWrite = 0;
                inmSrc = 2'b10;
                aluSrc = 0;
                memWrite = 0;
                resSrc = 2'b00;
                branch = 1;
                aluOp = 2'b01;
            end
            7'b0010011: begin // addi
                regWrite = 1;
                inmSrc = 2'b00; // Tipo I
                aluSrc = 1;
                memWrite = 0;
                resSrc = 2'b00;
                branch = 0;
                aluOp = 2'b00; // Suma
            end
            7'b1101111: begin // jal
                regWrite = 1;
                inmSrc = 2'b11; // Tipo J
                aluSrc = 0;     // No usamos inmediato como operando ALU
                resSrc = 2'b10; // Resultado es pc + 4
                branch = 1;     // Activar salto
                memWrite = 0;
            end
            default: begin
                //valores ya inicializados
            end
        endcase
    end
endmodule
