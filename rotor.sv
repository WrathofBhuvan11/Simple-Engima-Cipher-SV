module rotor (
    input  [25:0] in,
    input  [4:0]  n,      // Position (0-25, 5 bits suffice)
    input         direction, // 0 for forward, 1 for inverse
    output [25:0] out
);
    wire [25:0] shifted_in;
    wire [25:0] permuted;

    // Rotate right by n
    genvar i;
    generate
        for (i = 0; i < 26; i = i + 1) begin : right_shift
            assign shifted_in[i] = in[(i + n) % 26];
        end
    endgenerate

    // Apply fixed permutation p or p^{-1} based on direction
    reg  [4:0] p [25:0];    // Fixed permutation
    reg  [4:0] p_inv [25:0]; // Inverse permutation
    initial begin
        // Define p and p_inv (example values)
        p[0] = 5; p[1] = 3; /* ... */ p[25] = 24;
        p_inv[0] = 2; p_inv[1] = 4; /* ... */ p_inv[25] = 23;
    end
    wire [25:0] perm_p, perm_p_inv;
    for (i = 0; i < 26; i = i + 1) begin : permute
        assign perm_p[i] = shifted_in[p_inv[i]];
        assign perm_p_inv[i] = shifted_in[p[i]];
    end
    assign permuted = direction ? perm_p_inv : perm_p;

    // Rotate left by n
    generate
        for (i = 0; i < 26; i = i + 1) begin : left_shift
            assign out[i] = permuted[(i - n) % 26];
        end
    endgenerate
endmodule
