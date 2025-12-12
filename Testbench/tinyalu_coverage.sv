`ifndef TinyALU_COVERAGE
`define TinyALU_COVERAGE

class tinyalu_coverage extends  uvm_component;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(tinyalu_coverage)

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	uvm_analysis_export #(tinyalu_seq_item) cov_export;		//check seq_item name
	uvm_tlm_analysis_fifo #(tinyalu_seq_item) cov_fifo;
	tinyalu_seq_item seq_item_cov;

	covergroup CovGp ();
		reset_c : coverpoint seq_item_cov.reset_n{
			bins disabled = {1};
			bins abled = {0};
		}
		start_c : coverpoint seq_item_cov.start iff(!seq_item_cov.reset_n){
			bins disabled = {0};
			bins abled = {1};
		}
		A_c : coverpoint seq_item_cov.A iff(!seq_item_cov.reset_n&&seq_item_cov.start){
			bins Max = {8'b1111_1111};
			bins Min = {8'b0000_0000};
			bins others = default;
		}
		B_c : coverpoint seq_item_cov.B iff(!seq_item_cov.reset_n&&seq_item_cov.start){
			bins Max = {8'b1111_1111};
			bins Min = {8'b0000_0000};
			bins others = default;
		}
		op_c : coverpoint seq_item_cov.op iff(!seq_item_cov.reset_n&&seq_item_cov.start){
			bins no_op = {3'b000};
			bins add_op = {3'b001};
			bins and_op = {3'b010};
			bins xor_op = {3'b011};
			bins mul_op = {3'b100};
			bins unused_op = {[3'b100:3'b111]};
		}
		// A_B_op_c : cross A_c, B_c, op_c iff(!seq_item_cov.reset_n&&seq_item_cov.start){
		// 	ignore_bins no_operation = binsof(op_c.no_op);
		// 	ignore_bins unused_operation = binsof(op_c.unused_op);
		// }

		endgroup : CovGp

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "tinyalu_coverage", uvm_component parent=null);
		super.new(name, parent);
		CovGp=new();
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		cov_export=new("cov_export",this);
		cov_fifo=new("cov_fifo",this);
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		cov_export.connect(cov_fifo.analysis_export);
	endfunction : connect_phase

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			cov_fifo.get(seq_item_cov);
			CovGp.sample();
		end
	endtask : run_phase

endclass : tinyalu_coverage

`endif 
