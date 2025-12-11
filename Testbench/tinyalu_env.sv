`ifndef TinyALU_ENV
`define TinyALU_ENV

class tinyalu_env extends  uvm_env;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(tinyalu_env)
	tinyalu_agent agent;
	tinyalu_scoreboard scoreboard;
	tinyalu_coverage coverage;

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "tinyalu_env", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent = tinyalu_agent::type_id::create("agent", this);
		scoreboard = tinyalu_scoreboard::type_id::create("scoreboard", this);
		coverage = tinyalu_coverage::type_id::create("coverage", this);
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agent.agt_ap.connect(coverage.cov_export);
		agent.agt_ap.connect(scoreboard.sb_imp);
	endfunction : connect_phase
endclass : tinyalu_env`endif