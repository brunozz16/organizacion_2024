module aluDeco (
    input wire [1:0] aluOp,
    input wire [2:0] f3,
    input wire f7,
    output reg [2:0] aluControl
);

    always @(*) begin
        case (aluOp)
            2'b00: aluControl = 3'b000; // lw, sw - ADD
            2'b01: aluControl = 3'b001; // beq - SUB
            2'b10: begin
                case (f3)
                    3'b000: aluControl = f7 ? 3'b001 : 3'b000; // add/sub
                    3'b010: aluControl = 3'b100;               // SLT
                    3'b110: aluControl = 3'b011;               // OR
                    3'b111: aluControl = 3'b010;               // AND
                    default: aluControl = 3'b000;
                endcase
            end
            default: aluControl = 3'b000;
        endcase
    end
endmodule
