module mux3x1(
    input wire [31:0] e1, e2, e3,
    input wire [1:0] sel,
    output reg [31:0] sal
);

always @(*)begin
   if(sel==2'b00)begin
    sal=e1;
   end
   if(sel==2'b01)begin
    sal=e2;
   end
   if(sel==2'b10)begin
    sal=e3;
   end 
end

endmodule