`ifndef ENIGMA_DRIVER_SV
`define ENIGMA_DRIVER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class enigma_driver extends uvm_driver #(enigma_seq_item);
    `uvm_component_utils(enigma_driver)

    virtual enigma_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual enigma_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "No virtual interface set")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            vif.input_letter <= req.input_letter;
            vif.n1 <= req.n1;
            vif.n2 <= req.n2;
            vif.n3 <= req.n3;
            #10; // Small delay to simulate transaction timing
            seq_item_port.item_done();
        end
    endtask
endclass

`endif
