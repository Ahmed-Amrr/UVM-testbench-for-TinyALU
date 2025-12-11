package tinyalu_pkg;
  // Import UVM
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // Include ALL TB files
  `include "tinyalu_config.sv"
  `include "tinyalu_seq_item.sv"
  `include "tinyalu_err_seq_item.sv"
  `include "tinyalu_main_seq.sv"
  `include "tinyalu_err_seq.sv"
  `include "tinyalu_reset_seq.sv"
  `include "tinyalu_sequencer"
  `include "tinyalu_driver.sv"
  `include "tinyalu_err_driver.sv"
  `include "tinyalu_monitor.sv"
  `include "tinyalu_scoreboard.sv"
  `include "tinyalu_agent.sv"
  `include "tinyalu_env.sv"
  `include "tinyalu_test_base.sv"
  `include "tinyalu_test_err.sv"

endpackage : tinyalu_pkg
