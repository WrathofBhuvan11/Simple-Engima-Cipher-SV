`ifndef ENIGMA_SCOREBOARD_SV
`define ENIGMA_SCOREBOARD_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class enigma_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(enigma_scoreboard)

    uvm_analysis_imp #(enigma_seq_item, enigma_scoreboard) ap;
    enigma_ref_model ref_model;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
        ref_model = new();
    endfunction

    function void write(enigma_seq_item item);
        bit [25:0] expected_output;
        expected_output = ref_model.encrypt(item.input_letter, item.n1, item.n2, item.n3);
        if (item.output_letter != expected_output) begin
            `uvm_error("SB", $sformatf("Mismatch: input %0h, n1 %0d, n2 %0d, n3 %0d, expected %0h, got %0h",
                item.input_letter, item.n1, item.n2, item.n3, expected_output, item.output_letter))
        end else begin
            `uvm_info("SB", "Output matches expected", UVM_LOW)
        end
    endfunction
endclass

`endif
