`timescale 1ns / 1ps

`define TRUE 1'b1
`define FALSE 1'b0
`define RED 2'd0
`define YELLOW 2'd1
`define GREEN 2'd2

// State definition
`define S0 3'd0
`define S1 3'd1
`define S2 3'd2
`define S3 3'd3
`define S4 3'd4

// Delays
`define Y2RDELAY 3
`define R2GDELAY 2
module sig_control(hwy, cntry, X, clock, clear);
input X;
input clock, clear;
output reg [1:0] hwy, cntry;
reg [2:0] PS;
reg [2:0] NS;
initial
begin
PS = `S0;
NS = `S0;
hwy = `GREEN;
cntry = `RED;
end
always @(posedge clock)
PS = NS;
always @(PS)
begin
case(PS)
`S0: begin
       hwy = `GREEN;
       cntry = `RED;
     end
`S1: begin
       hwy = `YELLOW;
       cntry = `RED;
     end
`S2: begin
       hwy = `RED;
       cntry = `RED;
       end
`S3: begin
       hwy = `RED;
       cntry = `GREEN;
       end
`S4: begin
       hwy = `RED;
       cntry = `YELLOW;
       end
endcase
end
// State machine using case statements
always @(PS or clear or X)
begin
if(clear)
NS = `S0;
else
case(PS)
`S0: if(X)
      NS = `S1;
      else
      NS = `S0;
`S1:begin
    repeat(`Y2RDELAY) @(posedge clock);
    NS = `S2;
    end
`S2:begin
    repeat(`R2GDELAY) @(posedge clock);
    NS = `S3;
    end   
`S3: if(X)
      NS = `S3;
      else
      NS = `S4;
`S4:begin
    repeat(`Y2RDELAY) @(posedge clock);
    NS = `S0;
    end
default: NS = `S0;
endcase
end
endmodule
