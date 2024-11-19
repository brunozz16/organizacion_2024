`define DUMPSTR(x) `"x.vcd`" ///es para crear una funcion que crea ese archivo para usar en el gtkwire
`timescale 100 ns/10 ns ///escala de tiempo
module BR_tb();
    parameter duration=10;
    reg clk=0; ///inicializo en cero logico
    always #1 clk=~clk;  ///cada media unidad de tiempo le cambiamos su valor por su negado
    

    reg [4:0] test_a1;
    reg [4:0] test_a2;
    reg [4:0] test_a3;
    reg [31:0] test_wd;
    reg test_we;
    wire [31:0] test_rd1;
    wire [31:0] test_rd2;
    //defino las entradas
 //defino la salida

BR uut_br(
    .clk(clk),
    .a1(test_a1),
    .a2(test_a2),
    .a3(test_a3),
    .wd3(test_wd),
    .we3(test_we),
    .rd1(test_rd1),
    .rd2(test_rd2)
);
initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0,BR_tb);
        #2
        test_we=0;
        test_a1=5'b00000;
        test_a2=5'b00101;
        #2
        test_we=0;
         test_a1=5'b00100;
        test_a2=5'b11111;
        #2
        test_we=1;
        test_a3=5'b00100;
        test_wd=32'b00000000000000000000000000000100;
        #2
        test_a3=5'b00101;
         test_wd=32'b00000000000000000000000000001000;
        #2
          test_we=0;
        test_a1=5'b00100;
        test_a2=5'b00101;


   #(duration) $display ("Fin de la simulacion");
    $finish;
end
endmodule

        

      