interface tinyalu_if (input clk);
  logic [7:0] A, B;
  logic [2:0] op;
  logic reset_n,start,done;
  logic [15:0] result;
  clocking cb ( @posedge clk)
  default input #1ns output #2ns; // inputs sampled 1ns before pos edge of clk
  //outputs driven 2ns after pos clk edge
  output A, B, op, reset_n, start;
  input done, result;
  endclocking
endinterface 