`ifndef TOP_SV
`define TOP_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

module top;
    // Import all necessary files
    `include "enigma_if.sv"
    `include "enigma_seq_item.sv"
    `include "enigma_sequence.sv"
    `include "enigma_ref_model.sv"
    `include "enigma_driver.sv"
    `include "enigma_monitor.sv"
    `include "enigma_scoreboard.sv"
    `include "enigma_agent.sv"
    `include "enigma_env.sv"
    `include "enigma_test.sv"

    // Instantiate interface
    enigma_if vif();

    // Instantiate DUT
    enigma dut (
        .input_letter(vif.input_letter),
        .n1(vif.n1),
        .n2(vif.n2),
        .n3(vif.n3),
        .output_letter(vif.output_letter)
    );

    initial begin
        uvm_config_db#(virtual enigma_if)::set(null, "*", "vif", vif);
        run_test("enigma_test");
    end
endmodule

`endif
