module rom (
    input wire [4:0] address,     // Dirección de la memoria ROM(estaba en 4:0)
    output reg [31:0] readData        // Instrucción de salida
);

    // Declaración de contenido de la memoria ROM
   reg [31:0] memory [0:31];//(2^16)-1:0

    // Inicialización de la memoria ROM con las instrucciones proporcionadas
        initial begin
        
            memory[0]  <= 32'h00300413; // addi s0, zero, 3 
            memory[1]  <= 32'h00100493; // addi s1, zero, 1 
            memory[2]  <= 32'h01000913; // addi s2, zero, 16 
            memory[3]  <= 32'h009462b3; // or t0, s0, s1 
            memory[4]  <= 32'h00947333; // and t1, s0, s1 
            memory[5]  <= 32'h009403b3; // add t2, s0, s1 
            memory[6]  <= 32'h40940e33; // sub t3, s0, s1 
            memory[7]  <= 32'h40848eb3; // sub t4, s1, s0 
            memory[8]  <= 32'h00942f33; // slt t5, s0, s1  (tipo R)
            memory[9]  <= 32'h0084afb3; // slt t6, s1, s0 
            memory[10] <= 32'h01d4afb3; // slt t6, s1, t4 
            memory[11] <= 32'h00100293; // addi t0, zero, 1 
            memory[12] <= 32'h00000313; // addi t1, zero, 0 
            memory[13] <= 32'h01228863; // beq t0, s2, sal1 
            memory[14] <= 32'h005282b3; // add t0, t0, t0
            memory[15] <= 32'h00130313; // addi t1, t1, 1

            memory[16] <= 32'hff5ff06f; // j while
            memory[17] <= 32'h000004b3; // add s1, zero, zero
            memory[18] <= 32'h00000293; // addi t0, zero, 0
            memory[19] <= 32'h00a00313; // addi t1, zero, 10
            memory[20] <= 32'h00628863; // beq t0, t1, sal2
            memory[21] <= 32'h008484b3; // add s1, s1, s0
            memory[22] <= 32'h00128293; // addi t0, t0, 1
            memory[23] <= 32'hff5ff06f; // j for
            
            memory[24] <= 32'h00802023; // sw s0, 0(zero)
            memory[25] <= 32'h00902223; // sw s1, 4(zero)
            memory[26] <= 32'h01202423; // sw s2, 8(zero)
            memory[27] <= 32'h00002283; // lw t0, 0(zero)
            memory[28] <= 32'h00402303; // lw t1, 4(zero)
            memory[29] <= 32'h00802383; // lw t2, 8(zero)
            // Direcciones restantes en 0 para completar la ROM
            
        end

    // Proceso de lectura de la ROM
    always @(*) begin
        readData <= memory[address];  // Asigna el valor de la memoria correspondiente a la salida
    end
    
endmodule