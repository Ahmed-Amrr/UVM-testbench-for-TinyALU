`ifndef TinyALU_TEST_BASE
`define TinyALU_TEST_BASE

class tinyalu_test_base extends  uvm_test;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(tinyalu_test_base)
	tinyalu_config alu_config;
	tinyalu_env env;
	tinyalu_main_seq main_seq;
	tinyalu_reset_seq reset_seq;

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "tinyalu_test_base", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		alu_config = tinyalu_config::type_id::create("alu_config");
		main_seq = tinyalu_main_seq::type_id::create("main_seq");
		reset_seq = tinyalu_reset_seq::type_id::create("reset_seq");
		env = tinyalu_env::type_id::create("env", this);

		if (!(uvm_config_db#(virtual tinyalu_if)::get(this, "", "tinyalu_if", alu_config.tinyalu_vif))) 
			`uvm_fatal("build_phase", "unable to get vitual interface from top module");
		uvm_config_db#(tinyalu_config)::set(this, "*", "CFG", alu_config);
	endfunction : build_phase


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);

		`uvm_info("run phase", "Reset Asserted", UVM_LOW);
		reset_seq.start(env.agent.sqr);
		`uvm_info("run phase", "Reset Asserted", UVM_LOW);

		`uvm_info("run phase", "Stimulus Generation Started", UVM_LOW);
		main_seq.start(env.agent.sqr);
		`uvm_info("run phase", "Stimulus Generation Ended", UVM_LOW);

		phase.drop_objection(this);
	endtask : run_phase

	function void final_phase(uvm_phase phase);
		super.final_phase(phase);
		uvm_root::get().print_topology();
		uvm_factory::get().print();
	endfunction : final_phase
endclass : tinyalu_test_base
`endif