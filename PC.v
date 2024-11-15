module PC (
    input wire clk,
    input wire reset,
    input wire [31:0] pcNext,
    output reg [31:0] pc
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= pcNext;
    end
endmodule
