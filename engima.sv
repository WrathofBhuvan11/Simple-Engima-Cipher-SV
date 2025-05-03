module enigma (
    input  [25:0] input_letter,
    input  [4:0]  n1, n2, n3, // Rotor positions
    output [25:0] output_letter
);
    wire [25:0] after_plugboard1;
    wire [25:0] after_rotor1_fwd, after_rotor2_fwd, after_rotor3_fwd;
    wire [25:0] after_reflector;
    wire [25:0] after_rotor3_inv, after_rotor2_inv, after_rotor1_inv;

    plugboard pb1 (.in(input_letter), .out(after_plugboard1));
    rotor r1_fwd (.in(after_plugboard1), .n(n1), .direction(0), .out(after_rotor1_fwd));
    rotor r2_fwd (.in(after_rotor1_fwd), .n(n2), .direction(0), .out(after_rotor2_fwd));
    rotor r3_fwd (.in(after_rotor2_fwd), .n(n3), .direction(0), .out(after_rotor3_fwd));
    reflector ref (.in(after_rotor3_fwd), .out(after_reflector));
    rotor r3_inv (.in(after_reflector), .n(n3), .direction(1), .out(after_rotor3_inv));
    rotor r2_inv (.in(after_rotor3_inv), .n(n2), .direction(1), .out(after_rotor2_inv));
    rotor r1_inv (.in(after_rotor2_inv), .n(n1), .direction(1), .out(after_rotor1_inv));
    plugboard pb2 (.in(after_rotor1_inv), .out(output_letter));
endmodule
