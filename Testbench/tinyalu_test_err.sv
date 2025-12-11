`ifndef TinyALU_TEST_ERR
`define TinyALU_TEST_ERR

class tinyalu_test_err extends tinyalu_test_base;
    `uvm_component_utils(tinyalu_test_err)

    function new(string name = "tinyalu_test_err", uvm_component parent = null);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        set_type_override_by_type(tinyalu_main_seq::get_type(), tinyalu_err_seq::get_type());
        set_type_override_by_type(tinyalu_driver::get_type(), tinyalu_err_driver::get_type());
        set_type_override_by_type(tinyalu_seq_item::get_type(), tinyalu_err_seq_item::get_type());
    endfunction

endclass //tinyalu_test_err extends test_base

`endif 
