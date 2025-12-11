`ifndef TinyALU_MONITOR
`define TinyALU_MONITOR

class tinyalu_monitor extends uvm_monitor;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(tinyalu_monitor)

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	virtual tinyalu_inter tinyalu_vif; ////////////////////////////////////
	tinyalu_seq_item rsp_seq_item;//////////////////////////////////
	uvm_analysis_port #(tinyalu_seq_item) mon_ap;////////////////////

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "tinyalu_monitor", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		mon_ap=new("mon_ap", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);	//check the names for vif & seq_item & variables
		super.run_phase(phase);
		forever begin
			rsp_seq_item=tinyalu_seq_item::type_id::create("rsp_seq_item");
			@(negedge tinyalu_vif.clk);
			rsp_seq_item.A=tinyalu_vif.A;
			rsp_seq_item.B=tinyalu_vif.B;
			rsp_seq_item.op=tinyalu_vif.op;
			rsp_seq_item.reset_n=tinyalu_vif.reset_n;
			rsp_seq_item.start=tinyalu_vif.start;
			rsp_seq_item.done=tinyalu_vif.done;
			rsp_seq_item.result=tinyalu_vif.result;
			mon_ap.write(rsp_seq_item);
			/*`uvm_info("run_phase", rsp_seq_item.convert2string(), UVM_HIGH)*/
		end
	endtask : run_phase

endclass : tinyalu_monitor

`endif 