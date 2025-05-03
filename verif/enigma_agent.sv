`ifndef ENIGMA_AGENT_SV
`define ENIGMA_AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class enigma_agent extends uvm_agent;
    `uvm_component_utils(enigma_agent)

    enigma_driver driver;
    enigma_monitor monitor;
    uvm_sequencer #(enigma_seq_item) sequencer;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        driver = enigma_driver::type_id::create("driver", this);
        monitor = enigma_monitor::type_id::create("monitor", this);
        sequencer = uvm_sequencer#(enigma_seq_item)::type_id::create("sequencer", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
endclass

`endif
