package tinyalu_reset_seq_pkg;
	import uvm_pkg::*;
	import tinyalu_seq_item_pkg::*;
	`include "uvm_macros.svh"

	class tinyalu_reset_seq extends uvm_sequence #(tinyalu_seq_item);
	    `uvm_object_utils(tinyalu_reset_seq)
	    
	    function new(string name = "tinyalu_reset_seq");
	        super.new(name);
	    endfunction 

	    task body();
            seq_item = tinyalu_seq_item::type_id::create(seq_item);
            start_item(seq_item);
            seq_item.reset_n = 0;
            finish_item(seq_item);
        endtask
	endclass 

endpackage