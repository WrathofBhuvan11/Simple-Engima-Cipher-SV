`ifndef ENIGMA_MONITOR_SV
`define ENIGMA_MONITOR_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class enigma_monitor extends uvm_monitor;
    `uvm_component_utils(enigma_monitor)

    virtual enigma_if vif;
    uvm_analysis_port #(enigma_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual enigma_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "No virtual interface set")
    endfunction

    task run_phase(uvm_phase phase);
        enigma_seq_item item;
        forever begin
            @(vif.input_letter or vif.n1 or vif.n2 or vif.n3 or vif.output_letter);
            item = enigma_seq_item::type_id::create("item");
            item.input_letter = vif.input_letter;
            item.n1 = vif.n1;
            item.n2 = vif.n2;
            item.n3 = vif.n3;
            item.output_letter = vif.output_letter;
            ap.write(item);
        end
    endtask
endclass

`endif
