`ifndef ENIGMA_TEST_SV
`define ENIGMA_TEST_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class enigma_test extends uvm_test;
    `uvm_component_utils(enigma_test)

    enigma_env env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = enigma_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        enigma_sequence seq;
        phase.raise_objection(this);
        seq = enigma_sequence::type_id::create("seq");
        seq.initial_n1 = 0;
        seq.initial_n2 = 0;
        seq.initial_n3 = 0;
        seq.num_letters = 100;
        seq.start(env.agent.sequencer);
        #100; // Allow time for all transactions
        phase.drop_objection(this);
    endtask
endclass

`endif
