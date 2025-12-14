`ifndef TinyALU_ERR_SEQ
`define TinyALU_ERR_SEQ

class tinyalu_err_seq extends tinyalu_main_seq;
`uvm_object_utils(tinyalu_err_seq)

    tinyalu_seq_item e_item;

    function new(string name = "tinyalu_err_seq");
        super.new(name);
    endfunction //new()

    virtual task body();
    `uvm_info(get_type_name(), "=== ERROR SEQUENCE STARTED ===", UVM_MEDIUM);
        for (int i = 0; i < 1000; i++) begin
            e_item = tinyalu_seq_item::type_id::create("e_item");
            start_item(e_item);
            assert(e_item.randomize());
            // Debug: print the error type and opcode
            `uvm_info(get_type_name(), 
                $sformatf("Item %0d: op=%0d, op_stable_err=%0b, operands_stable_err=%0b, invalid_opcode=%0b",
                    i, e_item.op, e_item.op_stable_err, e_item.operands_stable_err, e_item.invalid_opcode), 
                UVM_MEDIUM)
            finish_item(e_item);
        end
    endtask: body
endclass //tinyalu_err_sequence extends tinyalu_main_seq

`endif 


