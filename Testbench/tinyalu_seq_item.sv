`ifndef TinyALU_SEQ_ITEM
`define TinyALU_SEQ_ITEM

class tinyalu_seq_item extends uvm_sequence_item;
	`uvm_object_utils(tinyalu_seq_item)

	rand bit [7:0] A      ;
	rand bit [7:0] B      ;
	rand bit [2:0] op     ;
	rand bit	   start  ;
	rand bit	   reset_n;

	logic done;
	logic[15:0] result;

	// variables used in error testcases
	rand bit [7:0] A_new ;
	rand bit [7:0] B_new ;
	rand bit [2:0] op_new;

	// error testcases enables 
	rand bit op_stable_err      ;
	rand bit operands_stable_err;
	rand bit invalid_opcode     ;

	// Constructor
	function new(string name = "tinyalu_seq_item");
		super.new(name);
	endfunction

	constraint c {
		// reset_n dist {1:/95, 0:/5};	
		reset_n == 1;
		start   dist {1:/90, 0:/10};
	}

	constraint valid_op {
		soft op inside {0, 1, 2, 3, 4};
	}
endclass : tinyalu_seq_item

`endif 


