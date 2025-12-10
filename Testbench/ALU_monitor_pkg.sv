package ALU_monitor_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import ALU_sequence_item_pkg::*;/////////////////////////////////////

	class ALU_monitor extends uvm_monitor;
	/*-------------------------------------------------------------------------------
	-- UVM Factory register
	-------------------------------------------------------------------------------*/
		// Provide implementations of virtual methods such as get_type_name and create
		`uvm_component_utils(ALU_monitor)
	
	/*-------------------------------------------------------------------------------
	-- Interface, port, fields
	-------------------------------------------------------------------------------*/
		virtual ALU_inter ALU_vif; ////////////////////////////////////
		ALU_seq_item rsp_seq_item;//////////////////////////////////
		uvm_analysis_port #(ALU_seq_item) mon_ap;////////////////////
	
	/*-------------------------------------------------------------------------------
	-- Functions
	-------------------------------------------------------------------------------*/
		// Constructor
		function new(string name = "ALU_monitor", uvm_component parent=null);
			super.new(name, parent);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			mon_ap=new("mon_ap", this);
		endfunction : build_phase

		task run_phase(uvm_phase phase);	//check the names for vif & seq_item & variables
			super.run_phase(phase);
			forever begin
				rsp_seq_item=ALU_seq_item::type_id::create("rsp_seq_item");
				@(negedge ALU_vif.clk);
				rsp_seq_item.A=ALU_vif.A;
				rsp_seq_item.B=ALU_vif.B;
				rsp_seq_item.op=ALU_vif.op;
				rsp_seq_item.reset_n=ALU_vif.reset_n;
				rsp_seq_item.start=ALU_vif.start;
				rsp_seq_item.done=ALU_vif.done;
				rsp_seq_item.result=ALU_vif.result;
				mon_ap.write(rsp_seq_item);
				/*`uvm_info("run_phase", rsp_seq_item.convert2string(), UVM_HIGH)*/
			end
		endtask : run_phase
	
	endclass : ALU_monitor
endpackage : ALU_monitor_pkg