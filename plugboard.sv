module plugboard (
    input  [25:0] in,
    output [25:0] out
);
    assign out[0]  = in[1];   // A → B
    assign out[1]  = in[0];   // B → A
    assign out[2]  = in[2];   // C → C
    assign out[3]  = in[3];   // D → D
    assign out[4]  = in[4];   // E → E
    assign out[5]  = in[5];   // F → F
    assign out[6]  = in[6];   // G → G
    assign out[7]  = in[7];   // H → H
    assign out[8]  = in[8];   // I → I
    assign out[9]  = in[9];   // J → J
    assign out[10] = in[10];  // K → K
    assign out[11] = in[11];  // L → L
    assign out[12] = in[12];  // M → M
    assign out[13] = in[13];  // N → N
    assign out[14] = in[14];  // O → O
    assign out[15] = in[15];  // P → P
    assign out[16] = in[16];  // Q → Q
    assign out[17] = in[17];  // R → R
    assign out[18] = in[18];  // S → S
    assign out[19] = in[19];  // T → T
    assign out[20] = in[20];  // U → U
    assign out[21] = in[21];  // V → V
    assign out[22] = in[22];  // W → W
    assign out[23] = in[23];  // X → X
    assign out[24] = in[24];  // Y → Y
    assign out[25] = in[25];  // Z → Z
endmodule
