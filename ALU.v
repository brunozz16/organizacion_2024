module ALU (
    input wire [31:0] srcA,
input wire [31:0] srcB,
input wire [2:0] ALUControl,
output reg zero,
output wire [31:0] ALUResult
);

 reg [31:0] aux;
always@(*)begin
    if(ALUControl==3'b000)begin
        aux=srcA+srcB;
    end
    if (ALUControl==3'b001)begin
        aux=srcA-srcB;
    end
    if (ALUControl==3'b010)begin
        aux=srcA&srcB;
    end
    if (ALUControl==3'b011)begin
        aux=srcA|srcB;
    end
    if (ALUControl==3'b101)begin
        aux=srcA<srcB;
    end
    
    if(aux==32'b0)begin
        zero=1'b1;
    end 
    else begin 
        zero=1'b0;
    end
end

assign ALUResult=aux;


endmodule
