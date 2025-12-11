`ifndef TinyALU_ERR_DRIVER
`define TinyALU_ERR_DRIVER

class tinyalu_err_driver extends uvm_driver;
    `uvm_component_utils(tinyalu_err_driver)

    virtual tinyalu_if tinyalu_vif;
    tinyalu_config    alu_cfg     ;
    tinyalu_seq_item   s_item     ;

    function new(string name = "tinyalu_err_driver", parent = null);
        super.new(name, parent);
    endfunction //new()

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(tinyalu_config)::get(this, "", "CFG", alu_cfg))
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
            if (s_item.op_stable_err) begin
        
                // ===== 1: drive values =====
                @(tinyalu_vif.cb);
                tinyalu_vif.A      <= s_item.A;
                tinyalu_vif.B      <= s_item.B;
                tinyalu_vif.opcode <= s_item.op;
                tinyalu_vif.start  <= s_item.start;
                tinyalu_vif.reset_n<= s_item.reset_n;

                // ===== 2: change only the opcode =====
                @(tinyalu_vif.cb);
                tinyalu_vif.A      <= s_item.A;      // stable
                tinyalu_vif.B      <= s_item.B;      // stable
                tinyalu_vif.opcode <= s_item.op_new; // ERROR INJECTION
                tinyalu_vif.start  <= s_item.start;
                tinyalu_vif.reset_n<= s_item.reset_n;

            end else if (s_item.operands_stable_err) begin
                    
                // ===== 1: drive values =====
                @(tinyalu_vif.cb);
                tinyalu_vif.A      <= s_item.A;
                tinyalu_vif.B      <= s_item.B;
                tinyalu_vif.opcode <= s_item.op;
                tinyalu_vif.start  <= s_item.start;
                tinyalu_vif.reset_n<= s_item.reset_n;

                // ===== 2: change A & B only =====
                @(tinyalu_vif.cb);
                tinyalu_vif.A      <= s_item.A;      // ERROR INJECTION
                tinyalu_vif.B      <= s_item.B;      // ERROR INJECTION
                tinyalu_vif.opcode <= s_item.op_new; // stable
                tinyalu_vif.start  <= s_item.start;
                tinyalu_vif.reset_n<= s_item.reset_n;

            end else if (s_item.invalid_opcode) begin
                    
                @(posedge tinyalu_vif.clk);
                tinyalu_vif.A      <= s_item.A;
                tinyalu_vif.B      <= s_item.B;
                tinyalu_vif.opcode <= s_item.op_new; // invalid opcode

            end
            seq_item_port.item_done();
        end
    endtask
endclass //tinyalu_err_driver extends uvm_driver

`endif 



