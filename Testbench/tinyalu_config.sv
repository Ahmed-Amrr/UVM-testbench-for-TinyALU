`ifndef TinyALU_CONFIG
`define TinyALU_CONFIG

class tinyalu_config extends uvm_object;
    `uvm_object_utils (tinyalu_config)

     virtual tinyalu_if tinyalu_vif;
     
     function new (string name ="tinyalu_config");
      super.new(name);
     endfunction
endclass

`endif