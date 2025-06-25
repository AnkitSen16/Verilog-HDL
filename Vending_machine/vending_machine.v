`timescale 1ns / 1ps

module vending_machine(
input clk,
input rst,
input [1:0] in, // 01 = 5rs, 10 = 10rs
output reg out,
output reg[1:0] change,
output reg [1:0] c_state, n_state
);
parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;

always@(posedge clk)
begin
if(rst == 1)
begin
c_state = 0;
n_state = 0;
change = 2'b00;
end
else
c_state = n_state;

case(c_state)
s0: //state 0 : 0 rs
if(in == 0)
begin
n_state = s0;
out = 0;
change = 2'b00;
end
else if(in == 2'b01)
begin
n_state = s1;
out = 0;
change = 2'b00;
end
else if(in == 2'b10)
begin
n_state = s2;
out = 0;
change = 2'b00;
end
s1: // state 1: 5 rs
if(in == 0)
begin
n_state = s0;
out = 0;
change = 2'b01; // change returned: 5 rs
end
else if(in == 2'b01)
begin
n_state = s2;
out = 0;
change = 2'b00;
end
else if(in == 2'b10)
begin
n_state = s0;
out = 1;
change = 2'b00;
end

s2: // state 2: 10 rs
if(in == 0)
begin
n_state = s0;
out = 0;
change = 2'b10; // change returned: 10 rs
end
else if(in == 2'b01)
begin
n_state = s0;
out = 1;
change = 2'b00;
end
else if(in == 2'b10)
begin
n_state = s0;
out = 1;
change = 2'b01; // change returned: 5 rs
end
endcase
end
endmodule
