`ifndef ENIGMA_SEQ_ITEM_SV
`define ENIGMA_SEQ_ITEM_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class enigma_seq_item extends uvm_sequence_item;
    rand bit [25:0] input_letter; // One-hot encoded input letter
    bit [4:0] n1, n2, n3;        // Rotor positions, set by sequence
    bit [25:0] output_letter;     // Observed output for scoreboard

    // Register fields with UVM factory
    `uvm_object_utils_begin(enigma_seq_item)
        `uvm_field_int(input_letter, UVM_ALL_ON)
        `uvm_field_int(n1, UVM_ALL_ON)
        `uvm_field_int(n2, UVM_ALL_ON)
        `uvm_field_int(n3, UVM_ALL_ON)
        `uvm_field_int(output_letter, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "enigma_seq_item");
        super.new(name);
    endfunction

    // Constraint to ensure input_letter is one-hot
    constraint one_hot_c {
        $countones(input_letter) == 1;
    }
endclass

`endif
