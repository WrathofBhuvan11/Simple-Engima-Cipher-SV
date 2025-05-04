module rotor #(
    parameter [1:0] ROTOR_TYPE = 2'b00  // 00 = Rotor I, 01 = Rotor II, 10 = Rotor III
) (
    input  [25:0] in,         // Input letter (one-hot encoded, 26 bits)
    input  [4:0]  n,          // Rotor position (0-25, 5 bits)
    input         direction,  // 0 = forward (right to left), 1 = inverse (left to right)
    output [25:0] out         // Output letter (one-hot encoded, 26 bits)
);
    wire [25:0] shifted_in;   // Input after first shift
    wire [25:0] permuted;     // Result after permutation

    // First shift: Adjust input based on rotor position
    genvar i;
    generate
        for (i = 0; i < 26; i = i + 1) begin : first_shift
            assign shifted_in[i] = direction ? in[(i + n) % 26] : in[(i - n + 26) % 26];
        end
    endgenerate

    // Define permutations for Rotor I, II, III and their inverses
    reg [4:0] p_I [25:0];     // Rotor I forward permutation
    reg [4:0] p_II [25:0];    // Rotor II forward permutation
    reg [4:0] p_III [25:0];   // Rotor III forward permutation
    reg [4:0] p_inv_I [25:0]; // Rotor I inverse permutation
    reg [4:0] p_inv_II [25:0];// Rotor II inverse permutation
    reg [4:0] p_inv_III [25:0]; // Rotor III inverse permutation

    // Rotor I wiring: EKMFLGDQVZNTOWYHXUSPAIBRCJ
    always @* begin
        integer j;
        for (j = 0; j < 26; j = j + 1) begin
            case (j)
                0: p_I[j] = 4;   // A->E
                1: p_I[j] = 10;  // B->K
                2: p_I[j] = 12;  // C->M
                3: p_I[j] = 5;   // D->F
                4: p_I[j] = 11;  // E->L
                5: p_I[j] = 6;   // F->G
                6: p_I[j] = 3;   // G->D
                7: p_I[j] = 16;  // H->Q
                8: p_I[j] = 21;  // I->V
                9: p_I[j] = 25;  // J->Z
                10: p_I[j] = 13; // K->N
                11: p_I[j] = 19; // L->T
                12: p_I[j] = 14; // M->O
                13: p_I[j] = 22; // N->W
                14: p_I[j] = 24; // O->Y
                15: p_I[j] = 7;  // P->H
                16: p_I[j] = 23; // Q->X
                17: p_I[j] = 20; // R->U
                18: p_I[j] = 15; // S->P
                19: p_I[j] = 0;  // T->A
                20: p_I[j] = 8;  // U->I
                21: p_I[j] = 1;  // V->B
                22: p_I[j] = 17; // W->R
                23: p_I[j] = 2;  // X->C
                24: p_I[j] = 9;  // Y->J
                25: p_I[j] = 18; // Z->S
                default: p_I[j] = 0;
            endcase
        end
    end
    always @* begin
        integer j;
        for (j = 0; j < 26; j = j + 1) begin
            case (j)
                0: p_inv_I[j] = 19;  // A->T
                1: p_inv_I[j] = 21;  // B->V
                2: p_inv_I[j] = 23;  // C->X
                3: p_inv_I[j] = 6;   // D->G
                4: p_inv_I[j] = 0;   // E->A
                5: p_inv_I[j] = 3;   // F->D
                6: p_inv_I[j] = 5;   // G->F
                7: p_inv_I[j] = 15;  // H->P
                8: p_inv_I[j] = 20;  // I->U
                9: p_inv_I[j] = 24;  // J->Y
                10: p_inv_I[j] = 1;  // K->B
                11: p_inv_I[j] = 4;  // L->E
                12: p_inv_I[j] = 2;  // M->C
                13: p_inv_I[j] = 10; // N->K
                14: p_inv_I[j] = 12; // O->M
                15: p_inv_I[j] = 18; // P->S
                16: p_inv_I[j] = 7;  // Q->H
                17: p_inv_I[j] = 22; // R->W
                18: p_inv_I[j] = 25; // S->Z
                19: p_inv_I[j] = 11; // T->L
                20: p_inv_I[j] = 17; // U->R
                21: p_inv_I[j] = 8;  // V->I
                22: p_inv_I[j] = 13; // W->N
                23: p_inv_I[j] = 16; // X->Q
                24: p_inv_I[j] = 14; // Y->O
                25: p_inv_I[j] = 9;  // Z->J
                default: p_inv_I[j] = 0;
            endcase
        end
    end

    // Rotor II wiring: AJDKSIRUXBLHWTMCQGZNPYFVOE
    always @* begin
        integer j;
        for (j = 0; j < 26; j = j + 1) begin
            case (j)
                0: p_II[j] = 0;   // A->A
                1: p_II[j] = 9;   // B->J
                2: p_II[j] = 3;   // C->D
                3: p_II[j] = 10;  // D->K
                4: p_II[j] = 18;  // E->S
                5: p_II[j] = 8;   // F->I
                6: p_II[j] = 17;  // G->R
                7: p_II[j] = 20;  // H->U
                8: p_II[j] = 23;  // I->X
                9: p_II[j] = 1;   // J->B
                10: p_II[j] = 19; // K->T
                11: p_II[j] = 12; // L->M
                12: p_II[j] = 2;  // M->C
                13: p_II[j] = 16; // N->Q
                14: p_II[j] = 6;  // O->G
                15: p_II[j] = 25; // P->Z
                16: p_II[j] = 13; // Q->N
                17: p_II[j] = 14; // R->O
                18: p_II[j] = 24; // S->Y
                19: p_II[j] = 5;  // T->F
                20: p_II[j] = 21; // U->V
                21: p_II[j] = 11; // V->L
                22: p_II[j] = 15; // W->P
                23: p_II[j] = 4;  // X->E
                24: p_II[j] = 7;  // Y->H
                25: p_II[j] = 22; // Z->W
                default: p_II[j] = 0;
            endcase
        end
    end
    always @* begin
        integer j;
        for (j = 0; j < 26; j = j + 1) begin
            case (j)
                0: p_inv_II[j] = 0;   // A->A
                1: p_inv_II[j] = 9;   // B->J
                2: p_inv_II[j] = 12;  // C->M
                3: p_inv_II[j] = 2;   // D->C
                4: p_inv_II[j] = 23;  // E->X
                5: p_inv_II[j] = 19;  // F->T
                6: p_inv_II[j] = 14;  // G->O
                7: p_inv_II[j] = 24;  // H->Y
                8: p_inv_II[j] = 5;   // I->F
                9: p_inv_II[j] = 1;   // J->B
                10: p_inv_II[j] = 3;  // K->D
                11: p_inv_II[j] = 21; // L->V
                12: p_inv_II[j] = 11; // M->L
                13: p_inv_II[j] = 16; // N->Q
                14: p_inv_II[j] = 17; // O->R
                15: p_inv_II[j] = 22; // P->W
                16: p_inv_II[j] = 13; // Q->N
                17: p_inv_II[j] = 6;  // R->G
                18: p_inv_II[j] = 4;  // S->E
                19: p_inv_II[j] = 10; // T->K
                20: p_inv_II[j] = 7;  // U->H
                21: p_inv_II[j] = 20; // V->U
                22: p_inv_II[j] = 25; // W->Z
                23: p_inv_II[j] = 8;  // X->I
                24: p_inv_II[j] = 18; // Y->S
                25: p_inv_II[j] = 15; // Z->P
                default: p_inv_II[j] = 0;
            endcase
        end
    end

    // Rotor III wiring: BDFHJLCPRTXVZNYEIWGAKMUSQO
    always @* begin
        integer j;
        for (j = 0; j < 26; j = j + 1) begin
            case (j)
                0: p_III[j] = 1;   // A->B
                1: p_III[j] = 3;   // B->D
                2: p_III[j] = 5;   // C->F
                3: p_III[j] = 7;   // D->H
                4: p_III[j] = 9;   // E->J
                5: p_III[j] = 11;  // F->L
                6: p_III[j] = 2;   // G->C
                7: p_III[j] = 15;  // H->P
                8: p_III[j] = 17;  // I->R
                9: p_III[j] = 19;  // J->T
                10: p_III[j] = 23; // K->X
                11: p_III[j] = 21; // L->V
                12: p_III[j] = 25; // M->Z
                13: p_III[j] = 13; // N->N
                14: p_III[j] = 24; // O->Y
                15: p_III[j] = 8;  // P->I
                16: p_III[j] = 10; // Q->K
                17: p_III[j] = 12; // R->M
                18: p_III[j] = 20; // S->U
                19: p_III[j] = 18; // T->S
                20: p_III[j] = 16; // U->Q
                21: p_III[j] = 4;  // V->E
                22: p_III[j] = 6;  // W->G
                23: p_III[j] = 0;  // X->A
                24: p_III[j] = 14; // Y->O
                25: p_III[j] = 22; // Z->W
                default: p_III[j] = 0;
            endcase
        end
    end
    always @* begin
        integer j;
        for (j = 0; j < 26; j = j + 1) begin
            case (j)
                0: p_inv_III[j] = 23;  // A->X
                1: p_inv_III[j] = 0;   // B->A
                2: p_inv_III[j] = 6;   // C->G
                3: p_inv_III[j] = 1;   // D->B
                4: p_inv_III[j] = 21;  // E->V
                5: p_inv_III[j] = 2;   // F->C
                6: p_inv_III[j] = 22;  // G->W
                7: p_inv_III[j] = 3;   // H->D
                8: p_inv_III[j] = 15;  // I->P
                9: p_inv_III[j] = 4;   // J->E
                10: p_inv_III[j] = 16; // K->Q
                11: p_inv_III[j] = 5;  // L->F
                12: p_inv_III[j] = 17; // M->R
                13: p_inv_III[j] = 13; // N->N
                14: p_inv_III[j] = 24; // O->Y
                15: p_inv_III[j] = 7;  // P->H
                16: p_inv_III[j] = 20; // Q->U
                17: p_inv_III[j] = 8;  // R->I
                18: p_inv_III[j] = 19; // S->T
                19: p_inv_III[j] = 9;  // T->J
                20: p_inv_III[j] = 18; // U->S
                21: p_inv_III[j] = 11; // V->L
                22: p_inv_III[j] = 25; // W->Z
                23: p_inv_III[j] = 10; // X->K
                24: p_inv_III[j] = 14; // Y->O
                25: p_inv_III[j] = 12; // Z->M
                default: p_inv_III[j] = 0;
            endcase
        end
    end

    // Select permutation based on ROTOR_TYPE
    reg [4:0] p_selected [25:0];
    reg [4:0] p_inv_selected [25:0];
    always @* begin
        integer k;
        for (k = 0; k < 26; k = k + 1) begin
            case (ROTOR_TYPE)
                2'b00: begin // Rotor I
                    p_selected[k] = p_I[k];
                    p_inv_selected[k] = p_inv_I[k];
                end
                2'b01: begin // Rotor II
                    p_selected[k] = p_II[k];
                    p_inv_selected[k] = p_inv_II[k];
                end
                2'b10: begin // Rotor III
                    p_selected[k] = p_III[k];
                    p_inv_selected[k] = p_inv_III[k];
                end
                default: begin
                    p_selected[k] = k; // Identity mapping
                    p_inv_selected[k] = k;
                end
            endcase
        end
    end

    // Apply permutation
    wire [25:0] perm_p, perm_p_inv;
    generate
        for (i = 0; i < 26; i = i + 1) begin : permute
            assign perm_p[i] = shifted_in[p_selected[i]];
            assign perm_p_inv[i] = shifted_in[p_inv_selected[i]];
        end
    endgenerate
    assign permuted = direction ? perm_p_inv : perm_p;

    // Second shift: Compensate for rotor position
    generate
        for (i = 0; i < 26; i = i + 1) begin : second_shift
            assign out[i] = direction ? permuted[(i - n + 26) % 26] : permuted[(i + n) % 26];
        end
    endgenerate
endmodule
