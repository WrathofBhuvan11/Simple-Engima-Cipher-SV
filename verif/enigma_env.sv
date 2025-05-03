`ifndef ENIGMA_ENV_SV
`define ENIGMA_ENV_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class enigma_env extends uvm_env;
    `uvm_component_utils(enigma_env)

    enigma_agent agent;
    enigma_scoreboard scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = enigma_agent::type_id::create("agent", this);
        scoreboard = enigma_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.monitor.ap.connect(scoreboard.ap);
    endfunction
endclass

`endif
