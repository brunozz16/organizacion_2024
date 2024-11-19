module  SE(
    input wire [24:0] inm,
    input wire [1:0] immSrc,
    output wire [31:0] immExt 
);
reg [31:0] inAux;

always @(*)begin
    if(immSrc==2'b00)begin
        inAux[11:0]=inm[24:13];
        inAux[31:12]={22{inm[24]}};
    end
    if(immSrc==2'b01)begin
        inAux[4:0]=inm[4:0];
        inAux[11:5]=inm[24:18];
        inAux[31:12]={22{inm[24]}};
    end
    if(immSrc==2'b10)begin
        inAux[0]=1'b0;
        inAux[4:1]=inm[4:1];
        inAux[10:5]=inm[23:18];
        inAux[11]=inm[0];
        inAux[31:12]={20{inm[24]}};
    end
    if (immSrc==2'b11)begin
      inAux[0]=1'b0;
      inAux[10:1]=inm[23:14];
      inAux[11]=inm[13];
      inAux[19:12]=inm[12:5];
      inAux[31:20]={12{inm[24]}};
    end
    
    /*
    if (immSrc==3'b100)begin
        inAux[7:0]=inm[12:5];
        inAux[8]=inm[13];
        inAux[18:9]=inm[23:14];
        inAux[31:19]={13{inm[24]}};
    end
    */
end
    assign immExt=inAux;

endmodule
