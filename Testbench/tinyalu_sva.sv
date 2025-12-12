module tinyalu_sva (
  input clk,           
  input [7:0] A, B,
  input [2:0] op,
  input reset_n, start, done,
  input [15:0] result
) ;
 RST_A : assert property (@(posedge clk) (reset_n==0) |=> (done == 0 && result == 0 ));
 RST_C : cover property (@(posedge clk) (reset_n==0) |=> (done == 0 && result == 0 ));

OP000_DONE_A :assert property (@(posedge clk) disable iff (!start) (op==3'b000 |=> (done == 0 )));
OP000_DONE_C :cover property (@(posedge clk) disable iff (!start) (op==3'b000 |=> (done == 0 )));

ADD_A :assert property (@(posedge clk) disable iff (!reset_n || op==4) (op==1 && start==1 ) |=> (done == 1 && result== $past(A) + $past(B)));
ADD_C :cover property (@(posedge clk) disable iff (!reset_n || op==4) (op==1 && start==1 ) |=> (done == 1 && result== $past(A) + $past(B)));

AND_A :assert property (@(posedge clk) disable iff (!reset_n || op==4) (op==2 && start==1 ) |=> (done == 1 && result== $past(A) & $past(B)));
AND_C :cover property (@(posedge clk) disable iff (!reset_n || op==4) (op==2 && start==1 ) |=> (done == 1 && result== $past(A) & $past(B)));

XOR_A :assert property (@(posedge clk) disable iff (!reset_n || op==4) (op==3 && start==1 ) |=> (done == 1 && result== $past(A) ^ $past(B)));
XOR_C :cover property (@(posedge clk) disable iff (!reset_n || op==4) (op==3 && start==1 ) |=> (done == 1 && result== $past(A) ^ $past(B)));

SINGLE_END_A: assert property (@(posedge clk) disable iff (!reset_n) (op[2]==0 && op[1:0]!=2'b00 && start==1 ) |-> ##1 (start==0 && done==0));
SINGLE_END_C :cover property (@(posedge clk) disable iff (!reset_n) (op[2]==0 && op[1:0]!=2'b00 && start==1 ) |-> ##1 (start==0 && done==0 ));

MULT_A :assert property (@(posedge clk) disable iff (!reset_n || op!=4) (op==3'b100 && start==1 ) |-> ##3 (done==1 && result==$past(A,4)*$past(B,4)) ##1 (done==0 && start==0));
MULT_C :cover property (@(posedge clk) disable iff (!reset_n || op!=4) (op==3'b100 && start==1 ) |-> ##3 (done==1 && result==$past(A,4)*$past(B,4)) ##1 (done==0 && start==0));

MULT_STABLE_A: assert property ( @(posedge clk) disable iff (!reset_n || op!=4) (op == 3'b100 && start == 1) |=> ($stable(A) && $stable(B) && $stable(op)) [*3]);
MULT_STABLE_C: cover property ( @(posedge clk) disable iff (!reset_n || op!=4) (op == 3'b100 && start == 1) |=> ($stable(A) && $stable(B) && $stable(op)) [*3]);


endmodule 