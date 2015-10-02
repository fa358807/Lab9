`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:24 03/07/2012 
// Design Name: 
// Module Name:    freqdiv24 
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
`define FREQ_DIV_BIT 25 // If old board set to 24, new board 25
module freqdiv24(
  clk_out, //divided clock output
  clk_ctl, // divided clock for 14-segment display scan
  clk, // clock from the 40MHz oscillator
  rst_n // low active reset
);

output clk_out; //divided clock output
output [1:0] clk_ctl; // divided clock for 14-segment display scan
input clk; // clock from the 40MHz oscillator
input rst_n; //low active reset

reg clk_out; // divided clock output (in the always block)
reg [1:0] clk_ctl; // divided clock for seven-segment display scan (in the always block)
reg [14:0] cnt_l; // temperatory buffer
reg [6:0] cnt_h; // temperatory buffer
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input node to flip flops

// Combinational block 
always @(clk_out or cnt_h or cnt_l or clk_ctl)
  cnt_tmp = {clk_out,cnt_h,clk_ctl,cnt_l} + 1'b1;
  
// Sequential block 
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    {clk_out,cnt_h,clk_ctl,cnt_l} <= `FREQ_DIV_BIT'b0;
  else
    {clk_out,cnt_h,clk_ctl,cnt_l} <= cnt_tmp;

endmodule
