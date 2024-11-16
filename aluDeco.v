module aluDeco (
    input opcode,
    input funct7,
    input [2:0] funct3,
    input [1:0] op,
    output reg [2:0] ALUControl
);
    reg[1:0] aux;
    
    always @(*) begin
        aux[0]=funct7;
        aux[1]=opcode;
        case (op)
            2'b00: ALUControl = 3'b000; // lw, sw (Add)
            2'b01: ALUControl = 3'b001; // beq (Subtract)
            2'b10: begin
                case (funct3)
                    3'b000: if (aux!=2'b11) 
                            ALUControl=3'b000; //add
                        else 
                            ALUControl=3'b001;  //subtract
                    3'b010: ALUControl = 3'b101; //stl              // slt
                    3'b110: ALUControl = 3'b011; //or               // or
                    3'b111: ALUControl = 3'b010; //and                // and
                    default: ALUControl = 3'b000;                     // default to add
                endcase
            end
            default: ALUControl = 3'b000; // Default case
        endcase
    end
endmodule