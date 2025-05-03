`ifndef ENIGMA_REF_MODEL_SV
`define ENIGMA_REF_MODEL_SV

class enigma_ref_model;
    int plugboard[26];
    int rotor1[26], rotor2[26], rotor3[26];
    int rotor1_inv[26], rotor2_inv[26], rotor3_inv[26];
    int reflector[26];

    function new();
        // Initialize plugboard (A↔B, others unchanged)
        for (int i = 0; i < 26; i++) plugboard[i] = i;
        plugboard[0] = 1; plugboard[1] = 0;

        // Initialize rotor1 (example permutation)
        rotor1 = '{5, 3, 10, 15, 20, 25, 2, 8, 14, 19, 24, 1, 7, 12, 18, 23, 4, 9, 13, 17, 22, 0, 6, 11, 16, 21};
        for (int i = 0; i < 26; i++) rotor1_inv[rotor1[i]] = i;

        // Initialize rotor2
        rotor2 = '{4, 8, 12, 16, 20, 24, 3, 9, 15, 21, 0, 6, 11, 17, 22, 2, 7, 13, 18, 23, 1, 5, 10, 14, 19, 25};
        for (int i = 0; i < 26; i++) rotor2_inv[rotor2[i]] = i;

        // Initialize rotor3
        rotor3 = '{6, 10, 14, 18, 22, 0, 5, 11, 16, 21, 1, 7, 12, 17, 23, 2, 8, 13, 19, 24, 3, 9, 15, 20, 4, 25};
        for (int i = 0; i < 26; i++) rotor3_inv[rotor3[i]] = i;

        // Initialize reflector (A↔Z, B↔Y, etc.)
        for (int i = 0; i < 26; i++) reflector[i] = 25 - i;
    endfunction

    function bit [25:0] encrypt(bit [25:0] input_letter, int n1, int n2, int n3);
        int k = one_hot_to_index(input_letter);
        // Plugboard
        k = plugboard[k];
        // Rotors forward
        k = rotor_forward(k, rotor1, n1);
        k = rotor_forward(k, rotor2, n2);
        k = rotor_forward(k, rotor3, n3);
        // Reflector
        k = reflector[k];
        // Rotors inverse
        k = rotor_inverse(k, rotor3, n3);
        k = rotor_inverse(k, rotor2, n2);
        k = rotor_inverse(k, rotor1, n1);
        // Plugboard
        k = plugboard[k];
        return index_to_one_hot(k);
    endfunction

    function int rotor_forward(int k, int rotor[26], int n);
        int temp = (k - n + 26) % 26;
        temp = rotor[temp];
        return (temp + n) % 26;
    endfunction

    function int rotor_inverse(int k, int rotor_inv[26], int n);
        int temp = (k - n + 26) % 26;
        temp = rotor_inv[temp];
        return (temp + n) % 26;
    endfunction

    function int one_hot_to_index(bit [25:0] oh);
        for (int i = 0; i < 26; i++) if (oh[i]) return i;
        return -1;
    endfunction

    function bit [25:0] index_to_one_hot(int idx);
        bit [25:0] oh = 0;
        if (idx >= 0 && idx < 26) oh[idx] = 1;
        return oh;
    endfunction
endclass

`endif
