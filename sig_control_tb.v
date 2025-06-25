`timescale 1ns / 1ps

module sig_control_tb();
reg CAR_ON_CNTRY_RD; //X
reg CLOCK, CLEAR;
wire [1:0] MAIN_SIG, CNTRY_SIG; // hwy, cntry

sig_control SC (MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD, CLOCK, CLEAR);
initial
$monitor($time, "Main Sig = %b Country Sig = %b Car_on_cntry = %b",MAIN_SIG,CNTRY_SIG,CAR_ON_CNTRY_RD);
initial
begin
CLOCK = `FALSE;
forever #5 CLOCK = ~CLOCK;
end
initial
begin
CLEAR = `TRUE;
repeat(5) @(negedge CLOCK);
CLEAR = `FALSE;
end

// Apply stimulus
initial
begin
CAR_ON_CNTRY_RD = `FALSE;
#200 CAR_ON_CNTRY_RD = `TRUE;
#100 CAR_ON_CNTRY_RD = `FALSE;

#200 CAR_ON_CNTRY_RD = `TRUE;
#100 CAR_ON_CNTRY_RD = `FALSE;

#200 CAR_ON_CNTRY_RD = `TRUE;
#100 CAR_ON_CNTRY_RD = `FALSE;

#100 $stop;
end
endmodule
