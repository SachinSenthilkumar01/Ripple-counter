module Ripple_counter (
    input wire clk,       // Clock input
    input wire reset,     // Asynchronous reset
    output wire [3:0] q   // 4-bit counter output
);

    // Declare flip-flop outputs (registers)
    reg [3:0] count;

    // Assign internal register to output
    assign q = count;

    // Ripple counter: each bit toggles on the falling edge of the previous bit
    always @(negedge clk or posedge reset) begin
        if (reset)
            count <= 4'b0000;
        else begin
            count[0] <= ~count[0];
            count[1] <= count[0] ^ count[1];
            count[2] <= (count[0] & count[1]) ^ count[2];
            count[3] <= (count[0] & count[1] & count[2]) ^ count[3];
        end
    end

endmodule