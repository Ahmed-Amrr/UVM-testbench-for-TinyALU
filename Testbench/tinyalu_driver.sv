`ifndef TinyALU_DRIVER
`define TinyALU_DRIVER

class tinyalu_driver extends uvm_driver;
    `uvm_component_utils(tinyalu_driver)

    virtual tinyalu_if tinyalu_vif;
    tinyalu_config    alu_cfg     ;
    tinyalu_seq_item   s_item     ;

    function new(string name = "tinyalu_driver", parent = null);
        super.new(name, parent);
    endfunction //new()

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(tiny_alu_config)::get(this, "", "CFG", alu_cfg))
            `uvm_fatal("TINY ALU ERROR DRIVER", "Can't get the configuration object!!")
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        tinyalu_vif = alu_cfg.tinyalu_vif;
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        s_item = tinyalu_seq_item::type_id::create("s_item", this);
        forever begin
            seq_item_port.get_next_item(s_item);
            @(cb);
            tinyalu_vif.A       = s_item.A;
            tinyalu_vif.B       = s_item.B;
            tinyalu_vif.opcode  = s_item.opcode;
            tinyalu_vif.start   = s_item.start;
            tinyalu_vif.reset_n = s_item.reset_n;
            seq_item_port.item_done();
        end
    endtask
endclass //tinyalu_driver extends uvm_driver

`endif 