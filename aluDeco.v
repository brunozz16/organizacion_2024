module aluDeco (
    input opcode,
    input funct7,
    input [2:0] funct3,
    input [1:0] op,
    output reg [2:0] ALUControl
);
    reg[1:0] aux;
    
always@(*) begin
    aux[0]=funct7;
    aux[1]=opcode;
    if(op==2'b00)begin
        ALUControl=3'b000;
    end
    else if(op==2'b01)begin
        ALUControl=3'b001;
    end
    else if(op==2'b10 & funct3==3'b000 & aux!=2'b11)begin
            ALUControl=3'b000;
    end
    else if(op==2'b10 & funct3==3'b000 &aux==2'b11)begin
        ALUControl=3'b001;
    end
    else if(op==2'b10 &funct3==3'b010)begin
        ALUControl=3'b101;
    end
    else if(op==2'b10 & funct3==3'b110)begin
        ALUControl=3'b011;
    end
    else if (op==2'b10&funct3==3'b111)begin
        ALUControl=3'b010;
    end
end
endmodule