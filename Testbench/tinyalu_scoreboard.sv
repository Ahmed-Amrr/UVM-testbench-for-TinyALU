`ifndef TinyALU_SCOREBOARD
`define TinyALU_SCOREBOARD

class tinyalu_scoreboard extends uvm_scoreboard;

    // register component in factory 
    `uvm_component_utils(tinyalu_scoreboard)

    // create a TLM Analysis Port to receive data objects
    uvm_analysis_export #(tinyalu_seq_item) sb_imp;
    uvm_tlm_analysis_fifo #(tinyalu_seq_item) sb_fifo;
    tinyalu_seq_item seq_item_sb;
    virtual tinyalu_if tinyalu_vif;

    logic [15:0] result_exp;
    logic done_exp;

    // create error and correct counters
    int error_count = 0;
    int correct_count = 0;
    int cycle = 0;


    function new(string name = "tinyalu_scoreboard", uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    // build phase of scoreboard
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sb_fifo = new("sb_fifo", this);
        sb_imp = new("sb_imp", this);
    endfunction

    // run phase of scoreboard
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        forever begin
            sb_fifo.get(seq_item_sb);
            ref_model(seq_item_sb);
            if (((seq_item_sb.op == 4 && cycle == 4) || seq_item_sb.op != 4) && seq_item_sb.start && seq_item_sb.op != 0) begin
                if (result_exp == seq_item_sb.result && done_exp == seq_item_sb.done) begin
                    correct_count++;
                end
                else begin
                    error_count++;
                end
            end
        end
    endtask 

    // golden model
    task ref_model(tinyalu_seq_item seq_item_ref);
        if (~seq_item_ref.reset_n) begin
            result_exp = 1'b0;
            cycle = 0;
            done_exp = 0;
        end
        else if(~seq_item_ref.op[2] && seq_item_ref.start)begin
            cycle = 0;
            done_exp = 1;
            case (seq_item_ref.op)
                3'b001: result_exp = seq_item_ref.A + seq_item_ref.B;
                3'b010: result_exp = seq_item_ref.A & seq_item_ref.B;
                3'b011: result_exp = seq_item_ref.A ^ seq_item_ref.B;
                default: done_exp = 0;
            endcase
        end
        else if(seq_item_ref.op == 3'b100 && seq_item_ref.start) begin
            if (cycle == 3) begin
                result_exp = seq_item_ref.A * seq_item_ref.B;
                done_exp = 1;
                cycle++;
            end
            else if (cycle != 4)begin
                cycle++;
            end
            else if (cycle==4) begin
            cycle=0;
            done_exp = 0;
            end
        end
    endtask 

    // connenct phase of scoreboard
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sb_imp.connect(sb_fifo.analysis_export);
    endfunction

    // report phase of scoreboard
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("TINY_ALU_SCOREBOARD REPORT", $sformatf("total successful: %0d", correct_count), UVM_MEDIUM)
        `uvm_info("TINY_ALU_SCOREBOARD REPORT", $sformatf("total errors: %0d", error_count), UVM_MEDIUM)
    endfunction
endclass //tiny_alu_scoreboard extends uvm_scoreboard

`endif