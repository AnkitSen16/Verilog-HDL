`timescale 1ns / 1ps

module vending_machine_tb();
//inputs
reg clk;
reg[1:0] in;
reg rst;
// output
wire out;
wire[1:0] change;
wire[1:0] c_state,n_state;
vending_machine uut(
.clk(clk),
.rst(rst),
.in(in),
.out(out),
.c_state(c_state),
.n_state(n_state),
.change(change)
);
initial begin
$dumpfile("vending_machine.vcd");
$dumpvars(0,vending_machine_tb);
rst = 1;
clk = 0;
#6 rst = 0;
// 5,5,5
//in = 1;
//#11 in = 1;
//#16 in = 1;
// 5,10
//in = 1;
//#19 in = 2;
// 10,10
in = 2;
#19 in = 2;
#25 $finish;
end
always #5 clk = ~clk;

endmodule
