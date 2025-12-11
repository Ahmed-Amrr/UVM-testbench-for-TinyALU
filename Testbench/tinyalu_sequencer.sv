`ifndef TinyALU_SEQUENCER
`define TinyALU_SEQUENCER

class tinyalu_sequencer extends uvm_sequencer #(tinyalu_seq_item);
    `uvm_component_utils(tinyalu_sequencer)
    function new(string name = "tinyalu_sequencer", uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()
endclass //tinyalu_sequencer extends uvm_sequencer

`endif // End of include guard