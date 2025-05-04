module enigma (
    input clk,
    input rst_n,  // active-low reset
    input  [25:0] input_letter,
    input  [4:0]  n1, n2, n3, // Rotor positions
    output [25:0] output_letter
);

    // Input registers
    logic [25:0] input_reg;
    logic [4:0] n1_stage1, n2_stage1, n3_stage1;
    
    // Pipeline registers
    logic [25:0] reg1;
    logic [4:0] n1_stage2, n2_stage2, n3_stage2;
    logic [25:0] reg2;
    logic [4:0] n1_stage3, n2_stage3, n3_stage3;
    
    // Output register
    logic [25:0] output_reg;
    
    // Wires for combinational logic
    logic [25:0] after_plugboard1, after_rotor1_fwd, after_rotor2_fwd, after_rotor3_fwd, after_reflector, after_rotor3_inv, after_rotor2_inv, after_rotor1_inv, after_plugboard2;
    
    // Always block for registers
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            input_reg <= 26'b0;
            n1_stage1 <= 5'b0;
            n2_stage1 <= 5'b0;
            n3_stage1 <= 5'b0;
            reg1 <= 26'b0;
            n1_stage2 <= 5'b0;
            n2_stage2 <= 5'b0;
            n3_stage2 <= 5'b0;
            reg2 <= 26'b0;
            n1_stage3 <= 5'b0;
            n2_stage3 <= 5'b0;
            n3_stage3 <= 5'b0;
            output_reg <= 26'b0;
        end else begin
            input_reg <= input_letter;
            n1_stage1 <= n1;
            n2_stage1 <= n2;
            n3_stage1 <= n3;
            reg1 <= after_rotor2_fwd;
            n1_stage2 <= n1_stage1;
            n2_stage2 <= n2_stage1;
            n3_stage2 <= n3_stage1;
            reg2 <= after_rotor3_inv;
            n1_stage3 <= n1_stage2;
            n2_stage3 <= n2_stage2;
            n3_stage3 <= n3_stage2;
            output_reg <= after_plugboard2;
        end
    end
    
    // Module instantiations
    plugboard pb1 (.in(input_reg), .out(after_plugboard1));
    rotor #(.ROTOR_TYPE(2'b00)) r1_fwd (.in(after_plugboard1), .n(n1_stage1), .direction(0), .out(after_rotor1_fwd));
    rotor #(.ROTOR_TYPE(2'b01)) r2_fwd (.in(after_rotor1_fwd), .n(n2_stage1), .direction(0), .out(after_rotor2_fwd));
    rotor #(.ROTOR_TYPE(2'b10)) r3_fwd (.in(reg1), .n(n3_stage2), .direction(0), .out(after_rotor3_fwd));
    
    reflector ref (.in(after_rotor3_fwd), .out(after_reflector));
    
    rotor #(.ROTOR_TYPE(2'b10)) r3_inv (.in(after_reflector), .n(n3_stage2), .direction(1), .out(after_rotor3_inv));
    rotor #(.ROTOR_TYPE(2'b01)) r2_inv (.in(reg2), .n(n2_stage3), .direction(1), .out(after_rotor2_inv));
    rotor #(.ROTOR_TYPE(2'b00)) r1_inv (.in(after_rotor2_inv), .n(n1_stage3), .direction(1), .out(after_rotor1_inv));
    
    plugboard pb2 (.in(after_rotor1_inv), .out(after_plugboard2));
    
    // Assign output
    assign output_letter = output_reg;
    
endmodule
