`ifndef TinyALU_ERR_SEQ
`define TinyALU_ERR_SEQ

class tinyalu_err_sequence extends tinyalu_main_seq;
`uvm_object_utils(tinyalu_err_sequence)

    tinyalu_seq_item e_item;

    function new(string name = "tinyalu_err_sequence");
        super.new(name);
    endfunction //new()

    virtual task body();
        e_item = tinyalu_err_seq_item::type_id::create("e_item");
        for (int i = 0; i < 100; i++) begin
            start_item(e_item);
            assert(e_item.randomize());
            finish_item(e_item);
        end
    endtask: body
endclass //tinyalu_err_sequence extends tinyalu_main_seq

`endif 


