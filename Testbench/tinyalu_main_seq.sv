`ifndef TinyALU_MAIN_SEQ
`define TinyALU_MAIN_SEQ

class tinyalu_main_seq extends uvm_sequence#(tinyalu_seq_item); 
    `uvm_object_utils(tinyalu_main_seq)

    tinyalu_seq_item item;
    // Saved values for multiplication operation
    bit [7:0] A_1_new    ;
    bit [7:0] B_1_new    ;
    bit [2:0] op_1_new   ;
    bit       start_1_new;

    function new(string name = "tinyalu_main_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        for (int i = 0; i < 50; i++) begin
            item = tinyalu_seq_item::type_id::create("item");
            //  Cycle 1: randomize and send the item
            start_item(item);
            assert(item.randomize());
            finish_item(item);
            // If the operation is a multiplication (op=4, start=1),
            // the TinyALU requires inputs to stay stable
            // for 3 cycles. So we repeat 2 more cycles
            // with the same A, B, op, and start values.
            if ((item.op == 4) && (item.start == 1)) begin
                A_1_new     = item.A;
                B_1_new     = item.B;
                op_1_new    = item.op;
                start_1_new = item.start;
                `uvm_info("UVM_MULT_TRANSACTION",$sformatf("A_new: %0d, B_new: %0d, op_new: %0d, start_new: %0d", A_1_new, B_1_new, op_1_new, start_1_new), UVM_LOW)

                // Cycle 2: force the oprations and operands to be stable
                start_item(item);
                assert(item.randomize() with {A == A_1_new; B == B_1_new; op == op_1_new; start == start_1_new;});
                `uvm_info("UVM_MULT_TRANSACTION",$sformatf("A_new: %0d, B_new: %0d, op_new: %0d, start_new: %0d", item.A, item.B, item.op, item.start), UVM_LOW)
                finish_item(item);
                if(item.reset_n == 0)
                    continue;

                // Cycle 3: force the oprations and operands to be stable
                start_item(item);
                assert(item.randomize() with {A == A_1_new; B == B_1_new; op == op_1_new; start == start_1_new;});
                `uvm_info("UVM_MULT_TRANSACTION",$sformatf("A_new: %0d, B_new: %0d, op_new: %0d, start_new: %0d", item.A, item.B, item.op, item.start), UVM_LOW)
                finish_item(item);
                if(item.reset_n == 0)
                    continue;

                // Cycle 4: force the oprations and operands to be stable
                start_item(item);
                assert(item.randomize() with {A == A_1_new; B == B_1_new; op == op_1_new; start == start_1_new;});
                `uvm_info("UVM_MULT_TRANSACTION",$sformatf("A_new: %0d, B_new: %0d, op_new: %0d, start_new: %0d", item.A, item.B, item.op, item.start), UVM_LOW)
                finish_item(item);
                if(item.reset_n == 0)
                    continue;
            end 
        end
    endtask : body
endclass : tinyalu_main_seq

`endif // End of include guard
