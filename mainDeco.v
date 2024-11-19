module mainDeco (
    input [6:0] op,

    output reg branch,
    output reg [1:0] resultSrc,
    output reg memWrite,
    output reg aluSrc,
    output reg [1:0] immSrc,
    output reg regWrite,
    output reg [1:0] aluOp,
    output reg jump // (agregar)
);

    always @(*) begin
    if(op==7'b0000011)begin
        regWrite=1'b1;
        immSrc=2'b00;
        aluSrc=1'b1;
        memWrite=1'b0;
        resultSrc=2'b01;
        branch=1'b0;
        aluOp=2'b00;
        jump=1'b0;
    end
    else if(op==7'b0100011)begin
        regWrite=1'b0;
        immSrc=2'b01;
        aluSrc=1'b1;
        memWrite=1'b1;
        //resultSrc=2'bxx;
        branch=1'b0;
        aluOp=2'b00;
        jump=1'b0;
    end
    else  if(op==7'b0110011)begin
         regWrite=1'b1;
         //immSrc=2'bxx;
        aluSrc=1'b0;
        memWrite=1'b0;
        resultSrc=2'b00;
        branch=1'b0;
        aluOp=2'b10;
        jump=1'b0;
    end
    else if(op==7'b1100011)begin
        regWrite=1'b0;
        immSrc=2'b10;
        aluSrc=1'b0;
        memWrite=1'b0;
        //resultSrc=2'bxx;
        branch=1'b1;
        aluOp=2'b01;
        jump=1'b0;
    end
    else if (op==7'b0010011)begin
        regWrite=1'b1;
        immSrc=2'b00;
        aluSrc=1'b1;
        memWrite=1'b0;
        resultSrc=2'b00;
        branch=1'b0;
        aluOp=2'b10;
        jump=1'b0;
    end
    else if (op==7'b1101111)begin
        regWrite=1'b1;
        immSrc=2'b11;
        //aluSrc=1'bx;
        memWrite=1'b0;
        resultSrc=2'b10;
        branch=1'b0;
        //aluOp=2'bxx;
        jump=1'b1;
    end

end
endmodule