`ifndef TinyALU_AGENT
`define TinyALU_AGENT

class tinyalu_agent extends uvm_agent;
  `uvm_component_utils(tinyalu_agent)

  tinyalu_sequencer sqr;
  tinyalu_driver drv;
  tinyalu_in_monitor mon;
  tinyalu_config tinyalu_cfg;

  virtual tinyalu_if tinyalu_vif;

  uvm_analysis_port #(tinyalu_seqitem) agt_ap;

  function new(string name="tinyalu_agent", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Get interface 
      if(!uvm_config_db #(tinyalu_config)::get(this,"","CFG",tinyalu_cfg))
      `uvm_fatal("build_phase","unable to get configuration object")

    sqr = tinyalu_sequencer::type_id::create("sqr", this);
    drv = tinyalu_driver::type_id::create("drv", this);
    mon = tinyalu_in_monitor::type_id::create("mon", this);
  
    agt_ap = new("agt_ap", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    drv.tinyalu_vif=tinyalu_cfg.tinyalu_vif;
    mon.tinyalu_vif=tinyalu_cfg.tinyalu_vif;
    drv.seqitem_port.connect(sqr.seqitem_export); //sqr.seqitem_imp
    mon.mon_ap.connect(agt_ap);
  endfunction

endclass : tinyalu_agent

`endif // End of include guard
