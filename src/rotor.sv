module rotor (
    input  [25:0] in,
    input  [4:0]  n,      // Position (0-25, 5 bits suffice)
    input         direction, // 0 for forward, 1 for inverse
    output [25:0] out
);
    wire [25:0] shifted_in;
    wire [25:0] permuted;

    // First shift: right rotate by n for forward, left rotate by n for inverse
    genvar i;
    generate
        for (i = 0; i < 26; i = i + 1) begin : first_shift
            assign shifted_in[i] = direction ? in[(i + n) % 26] : in[(i - n) % 26];
        end
    endgenerate

    // Apply fixed permutation p or p^{-1} based on direction
    reg [4:0] p_out [25:0];
    reg [4:0] p_inv_out [25:0];
    always @* begin
        integer j;
        for (j = 0; j < 26; j = j + 1) begin
            case (j)
                0: p_out[j] = 4;   // A->E
                1: p_out[j] = 10;  // B->K
                2: p_out[j] = 12;  // C->M
                3: p_out[j] = 5;   // D->F
                4: p_out[j] = 11;  // E->L
                5: p_out[j] = 6;   // F->G
                6: p_out[j] = 3;   // G->D
                7: p_out[j] = 16;  // H->Q
                8: p_out[j] = 21;  // I->V
                9: p_out[j] = 25;  // J->Z
                10: p_out[j] = 13; // K->N
                11: p_out[j] = 19; // L->T
                12: p_out[j] = 14; // M->O
                13: p_out[j] = 22; // N->W
                14: p_out[j] = 24; // O->Y
                15: p_out[j] = 7;  // P->H
                16: p_out[j] = 23; // Q->X
                17: p_out[j] = 20; // R->U
                18: p_out[j] = 18; // S->S
                19: p_out[j] = 15; // T->P
                20: p_out[j] = 0;  // U->A
                21: p_out[j] = 8;  // V->I
                22: p_out[j] = 1;  // W->B
                23: p_out[j] = 17; // X->R
                24: p_out[j] = 2;  // Y->C
                25: p_out[j] = 9;  // Z->J
                default: p_out[j] = 0;
            endcase
        end
    end
    always @* begin
        integer j;
        for (j = 0; j < 26; j = j + 1) begin
            case (j)
                0: p_inv_out[j] = 20; // A->U
                1: p_inv_out[j] = 22; // B->W
                2: p_inv_out[j] = 24; // C->Y
                3: p_inv_out[j] = 6;  // D->G
                4: p_inv_out[j] = 0;  // E->A
                5: p_inv_out[j] = 3;  // F->D
                6: p_inv_out[j] = 5;  // G->F
                7: p_inv_out[j] = 15; // H->P
                8: p_inv_out[j] = 21; // I->V
                9: p_inv_out[j] = 25; // J->Z
                10: p_inv_out[j] = 1; // K->B
                11: p_inv_out[j] = 4; // L->E
                12: p_inv_out[j] = 2; // M->C
                13: p_inv_out[j] = 10;// N->K
                14: p_inv_out[j] = 12;// O->M
                15: p_inv_out[j] = 19;// P->T
                16: p_inv_out[j] = 7; // Q->H
                17: p_inv_out[j] = 23;// R->X
                18: p_inv_out[j] = 18;// S->S
                19: p_inv_out[j] = 11;// T->L
                20: p_inv_out[j] = 17;// U->R
                21: p_inv_out[j] = 8; // V->I
                22: p_inv_out[j] = 13;// W->N
                23: p_inv_out[j] = 16;// X->Q
                24: p_inv_out[j] = 14;// Y->O
                25: p_inv_out[j] = 9; // Z->J
                default: p_inv_out[j] = 0;
            endcase
        end
    end

    // Apply permutation
    wire [25:0] perm_p, perm_p_inv;
    generate
        for (i = 0; i < 26; i = i + 1) begin : permute
            assign perm_p[i] = shifted_in[p_out[i]];
            assign perm_p_inv[i] = shifted_in[p_inv_out[i]];
        end
    endgenerate
    assign permuted = direction ? perm_p_inv : perm_p;

    // Second shift: left rotate by n for forward, right rotate by n for inverse
    generate
        for (i = 0; i < 26; i = i + 1) begin : second_shift
            assign out[i] = direction ? permuted[(i - n) % 26] : permuted[(i + n) % 26];
        end
    endgenerate
endmodule
