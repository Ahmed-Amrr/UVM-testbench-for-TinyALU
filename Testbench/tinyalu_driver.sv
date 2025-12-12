`ifndef TinyALU_DRIVER
`define TinyALU_DRIVER

class tinyalu_driver extends uvm_driver #(tinyalu_seq_item);
    `uvm_component_utils(tinyalu_driver)

    virtual tinyalu_if tinyalu_vif;
    tinyalu_seq_item   s_item     ;

    function new(string name = "tinyalu_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction //new()

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
    endfunction


    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        s_item = tinyalu_seq_item::type_id::create("s_item", this);
        forever begin
            seq_item_port.get_next_item(s_item);
            tinyalu_vif.A       = s_item.A;
            tinyalu_vif.B       = s_item.B;
            tinyalu_vif.op      = s_item.op;
            tinyalu_vif.start   = s_item.start;
            tinyalu_vif.reset_n = s_item.reset_n;
            @(tinyalu_vif.cb);
            seq_item_port.item_done();
        end
    endtask
endclass //tinyalu_driver extends uvm_driver

`endif 