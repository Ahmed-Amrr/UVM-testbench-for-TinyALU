`ifndef TinyALU_RESET_SEQ
`define TinyALU_RESET_SEQ

class tinyalu_reset_seq extends uvm_sequence #(tinyalu_seq_item);
	`uvm_object_utils(tinyalu_reset_seq)

	tinyalu_seq_item seq_item;
	
	function new(string name = "tinyalu_reset_seq");
		super.new(name);
	endfunction 

	task body();
		seq_item = tinyalu_seq_item::type_id::create("seq_item");
		start_item(seq_item);
		assert (seq_item.randomize());
		seq_item.reset_n = 0;
		finish_item(seq_item);
	endtask
endclass 

`endif 

