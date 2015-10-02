`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:52 09/19/2015 
// Design Name: 
// Module Name:    pushbutton 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pushbutton(
input clk,rst_n,pb_in,
output out_pulse
    );
wire pb_debounced;

debounce_circuit debounce(
  .clk(clk), // clock control
  .rst_n(rst_n), // reset
  .pb_in(pb_in), //push button input
  .pb_debounced(pb_debounced) // debounced push button output
);

one_pulse one_pulse(
.clk(clk), // clock input
.rst_n(rst_n), //active low reset
.in_trig(pb_debounced), // input trigger
.out_pulse(out_pulse) // output one pulse
);

endmodule
