package tinyalu_allseq;
	import uvm_pkg::*;
	import tinyalu_seqitem::*; // handle till we write the seqitem
	`include "uvm_macros.svh"

	class tinyalu_allseq extends  uvm_sequence#(tinyalu_seqitem); //handle till we write the seqitem

	/*-------------------------------------------------------------------------------
	-- Interface, port, fields
	-------------------------------------------------------------------------------*/
		

	/*-------------------------------------------------------------------------------
	-- UVM Factory register
	-------------------------------------------------------------------------------*/
		// Provide implementations of virtual methods such as get_type_name and create
		`uvm_component_utils(TinyALU_AllSeq)
		tinyalu_seqitem item; // handle till we write the seqitem
	/*-------------------------------------------------------------------------------
	-- Functions
	-------------------------------------------------------------------------------*/
		// Constructor
		function new(string name = "TinyALU_AllSeq", uvm_component parent=null);
			super.new(name, parent);
		endfunction : new

		task body();
			for (int i = 0; i < 1000; i++) begin
				item = tinyalu_seqitem::type_id::create("item");
				start_item(item);
				assert(item.randomize());
				finish_item(item);
			end
		endtask : body
	endclass : tinyalu_allseq
endpackage : tinyalu_allseq