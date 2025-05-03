`ifndef ENIGMA_SEQUENCE_SV
`define ENIGMA_SEQUENCE_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class enigma_sequence extends uvm_sequence #(enigma_seq_item);
    `uvm_object_utils(enigma_sequence)

    int initial_n1 = 0;   // Initial rotor positions
    int initial_n2 = 0;
    int initial_n3 = 0;
    int num_letters = 100; // Number of letters to process
    int turnover1 = 16;    // Example turnover positions (e.g., Q for rotor 1)
    int turnover2 = 4;     // E for rotor 2
    int turnover3 = 0;     // Not typically used for left rotor

    function new(string name = "enigma_sequence");
        super.new(name);
    endfunction

    task body();
        enigma_seq_item item;
        int current_n1 = initial_n1;
        int current_n2 = initial_n2;
        int current_n3 = initial_n3;

        for (int i = 0; i < num_letters; i++) begin
            item = enigma_seq_item::type_id::create("item");
            start_item(item);
            if (!item.randomize()) begin
                `uvm_fatal("RAND_FAIL", "Failed to randomize sequence item")
            end
            item.n1 = current_n1;
            item.n2 = current_n2;
            item.n3 = current_n3;
            finish_item(item);

            // Update rotor positions
            current_n1 = (current_n1 + 1) % 26;
            if (current_n1 == turnover1) begin
                current_n2 = (current_n2 + 1) % 26;
                if (current_n2 == turnover2) begin
                    current_n3 = (current_n3 + 1) % 26;
                end
            end
        end
    endtask
endclass

`endif
