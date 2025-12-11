class tinyalu_driver extends uvm_driver;
    `uvm_component_utils(tinyalu_driver)

    virtual tinyalu_if tiny_alu_vif;
    tinyalu_seq_item   s_item     ;

    function new(string name = "tinyalu_driver", parent = null);
        super.new(name, parent);
    endfunction //new()

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual tinyalu_if)::get(this, "", "vif", tiny_alu_vif))
            `uvm_fatal("TINY_ALU_DRIVER", "Can't get the handle of virtual interface!!")
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        s_item = tinyalu_seq_item::type_id::create("s_item", this);
        forever begin
            seq_item_port.get_next_item(s_item);
            @(cb);
            tiny_alu_vif.A       = s_item.A;
            tiny_alu_vif.B       = s_item.B;
            tiny_alu_vif.opcode  = s_item.opcode;
            tiny_alu_vif.start   = s_item.start;
            tiny_alu_vif.reset_n = s_item.reset_n;
            seq_item_port.item_done();
        end
    endtask
endclass //tinyalu_driver extends uvm_driver