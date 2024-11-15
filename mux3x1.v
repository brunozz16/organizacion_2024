module mux3x1(
    input wire [31:0] e1, e2, e3,
    input wire [1:0] sel,
    output [31:0] sal
);

assign sal = (sel == 2'b00) ? e1 :
                 (sel == 2'b01) ? e2 :
                 (sel == 2'b10) ? e3 :
                                     32'bx; // Default to undefined for control '11'
endmodule