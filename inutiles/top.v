module top (
    input wire clk,
    input wire reset
);

    wire [31:0] pc;
    wire [31:0] instruction;

    // Instancia de la memoria ROM
    rom rom_inst (
        .address(pc[4:0]),   // Usa solo los 5 bits más bajos de `pc`
        .data(instruction)
    );

    // Instancia del procesador RV32I
    rv32i processor (
        .clk(clk),
        .reset(reset),
        .pc(pc),             // Conecta `pc` completo de 32 bits
        .instruction(instruction)
    );

endmodule

