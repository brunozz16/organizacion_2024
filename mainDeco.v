module mainDeco (
    input [6:0] op,

    output reg branch,
    output reg [1:0] resultSrc,
    output reg memWrite,
    output reg aluSrc,
    output reg [1:0] immSrc,
    output reg regWrite,
    output reg [1:0] aluOp,
    output reg jump //(agregar)
);

    always @(*) begin
        //valores predeterminados
        regWrite = 0;
        immSrc = 2'b00;
        aluSrc = 0;
        memWrite = 0;
        resultSrc = 2'b00;
        branch = 0;
        aluOp = 2'b00;
        jump = 0;
        case (op)
            7'b0000011: begin // lw
                regWrite = 1;
                immSrc = 2'b00;
                aluSrc = 1;
                memWrite = 0;
                resultSrc = 2'b01;
                branch = 0;
                aluOp = 2'b00;
                jump = 0;
            end
            7'b0100011: begin // sw
                regWrite = 0;
                immSrc = 2'b01;
                aluSrc = 1;
                memWrite = 1;
                resultSrc = 2'bXX; // Ignorado
                branch = 0;
                aluOp = 2'b00;
                jump = 0;
            end
            7'b0110011: begin // R-type
                regWrite = 1;
                immSrc = 2'bXX;
                aluSrc = 0;
                memWrite = 0;
                resultSrc = 2'b00;
                branch = 0;
                aluOp = 2'b10;
                jump = 0;
            end
            7'b1100011: begin // beq
                regWrite = 0;
                immSrc = 2'b10;
                aluSrc = 0;
                memWrite = 0;
                resultSrc = 2'bXX;
                branch = 1;
                aluOp = 2'b01;
                jump = 0;
            end
            7'b0010011: begin // addi
                regWrite = 1;
                immSrc = 2'b00; // Tipo I
                aluSrc = 1;
                memWrite = 0;
                resultSrc = 2'b00;
                branch = 0;
                aluOp = 2'b10; // Suma
                jump = 0;
            end
            7'b1101111: begin // jal
                regWrite = 1;
                immSrc = 2'b11; // Tipo J
                aluSrc = 1'bX;     // No usamos inmediato como operando ALU
                resultSrc = 2'b10; // Resultado es pc + 4
                branch = 0;     // Activar salto
                memWrite = 0;
                aluOp = 2'bXX;
                jump = 1;
            end
            default: begin
                //valores ya inicializados
            end
        endcase
    end
endmodule
