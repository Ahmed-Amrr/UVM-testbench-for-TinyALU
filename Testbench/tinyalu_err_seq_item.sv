`ifndef TinyALU_ERR_SEQ_ITEM
`define TinyALU_ERR_SEQ_ITEM

class tinyalu_err_seq_item extends tinyalu_seq_item;
	`uvm_object_utils(tinyalu_err_seq_item)
	
	function new(string name = "tinyalu_err_seq_item");
		super.new(name);
	endfunction 

	constraint c_one_err_at_a_time {
		(op_stable_err + operands_stable_err + invalid_opcode) == 1;
	}

	constraint c_strat {
		strat == 1;
	}

	constraint c_operands_stable_err {
		operands_stable_err -> (A_new != A && 
								B_new != B && 
								op_new == op );
	}

	constraint c_op_stable_err {
		op_stable_err -> (A_new == A && 
							B_new == B && 
							op_new != op );
	}

	constraint c_invalid_opcode {
		invalid_opcode -> op inside {5,6,7};
	}

endclass : tinyalu_err_seq_item

`endif 

