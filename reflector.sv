module reflector (
    input  [25:0] in,
    output [25:0] out
);
    assign out[0]  = in[25];  // A → Z
    assign out[1]  = in[24];  // B → Y
    assign out[2]  = in[23];  // C → X
    assign out[3]  = in[22];  // D → W
    assign out[4]  = in[21];  // E → V
    assign out[5]  = in[20];  // F → U
    assign out[6]  = in[19];  // G → T
    assign out[7]  = in[18];  // H → S
    assign out[8]  = in[17];  // I → R
    assign out[9]  = in[16];  // J → Q
    assign out[10] = in[15];  // K → P
    assign out[11] = in[14];  // L → O
    assign out[12] = in[13];  // M → N
    assign out[13] = in[12];  // N → M
    assign out[14] = in[11];  // O → L
    assign out[15] = in[10];  // P → K
    assign out[16] = in[9];   // Q → J
    assign out[17] = in[8];   // R → I
    assign out[18] = in[7];   // S → H
    assign out[19] = in[6];   // T → G
    assign out[20] = in[5];   // U → F
    assign out[21] = in[4];   // V → E
    assign out[22] = in[3];   // W → D
    assign out[23] = in[2];   // X → C
    assign out[24] = in[1];   // Y → B
    assign out[25] = in[0];   // Z → A
endmodule
