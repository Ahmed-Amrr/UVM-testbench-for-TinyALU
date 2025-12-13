module tinyalu_sva (
  input clk,           
  input [7:0] A, B,
  input [2:0] op,
  input reset_n, start, done,
  input [15:0] result
) ;
 RST_A : assert property (@(posedge clk) (reset_n==0) |=> (done == 0 && result == 0 ));
 RST_C : cover property (@(posedge clk) (reset_n==0) |=> (done == 0 && result == 0 ));

OP000_DONE_A :assert property (@(posedge clk) (op==3'b000 || start==0) |=> (done == 0 ));
OP000_DONE_C :cover property (@(posedge clk) (op==3'b000 || start==0) |=> (done == 0 ));
//avoid last cycle , if next operation is mult result is not stable
ADD_A :assert property (@(posedge clk) disable iff (!reset_n ) (op==1 && start==1 ) [*2] |-> (done == 1 && (result== ($past(A) + $past(B)))));
ADD_C :cover property (@(posedge clk) disable iff (!reset_n ) (op==1 && start==1 ) [*2] |-> (done == 1 && (result== ($past(A) + $past(B)))));

AND_A :assert property (@(posedge clk) disable iff (!reset_n ) (op==2 && start==1 ) [*2] |-> (done == 1 && (result== ($past(A) & $past(B)))));
AND_C :cover property (@(posedge clk) disable iff (!reset_n ) (op==2 && start==1 ) [*2] |-> (done == 1 && (result== ($past(A) & $past(B)))));

XOR_A :assert property (@(posedge clk) disable iff (!reset_n ) (op==3 && start==1 )[*2] |-> (done == 1 && (result== ($past(A) ^ $past(B)))));
XOR_C :cover property (@(posedge clk) disable iff (!reset_n ) (op==3 && start==1 ) [*2] |-> (done == 1 && (result== ($past(A) ^ $past(B)))));
//avoid last cycle , if next op==0 result is not stable
SINGLE_END_A: assert property (@(posedge clk) disable iff (!reset_n || op[2]!=0 || !start) (op[1:0]!=2'b00 )[*2] |-> (done==1));
SINGLE_END_C :cover property (@(posedge clk) disable iff (!reset_n || op[2]!=0 || !start) (op[1:0]!=2'b00 )[*2] |-> (done==1 ));

MULT_A :assert property (@(posedge clk) disable iff (!reset_n ) (op==3'b100 && start==1 )[*4] ##1 done==1 |-> result==$past(A,4)*$past(B,4) ##1 (done==0 ) );
MULT_C :cover property (@(posedge clk) disable iff (!reset_n ) (op==3'b100 && start==1 )[*4] ##1 done==1  |-> result==$past(A,4)*$past(B,4) ##1 (done==0 ) ) ;


endmodule 