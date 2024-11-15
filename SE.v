module  SE(
    input wire [24:0] inm,
    input wire [1:0] immSrc,
    output wire [31:0] immExt 
);
reg [31:0] aux;

always @(*)begin
    if(immSrc==2'b00)begin
        aux[11:0]=inm[24:13];
        aux[31:12]={22{inm[24]}};
    end
    if(immSrc==2'b01)begin
        aux[4:0]=inm[4:0];
        aux[11:5]=inm[24:18];
        aux[31:12]={22{inm[24]}};
    end
    if(immSrc==2'b10)begin
        aux[0]=1'b0;
        aux[4:1]=inm[4:1];
        aux[10:5]=inm[23:18];
        aux[11]=inm[0];
        aux[31:12]={20{inm[24]}};
    end
    if (immSrc==2'b11)begin
      aux[0]=1'b0;
      aux[10:1]=inm[23:14];
      aux[11]=inm[13];
      aux[19:12]=inm[12:5];
      aux[31:20]={12{inm[24]}};
    end
    /*if (immSrc==3'b100)begin
        aux[7:0]=inm[12:5];
        aux[8]=inm[13];
        aux[18:9]=inm[23:14];
        aux[31:19]={13{inm[24]}};
    end*/
end
    assign immExt=aux;

endmodule
