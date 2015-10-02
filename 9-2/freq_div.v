`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:12:25 04/05/2009 
// Design Name: 
// Module Name:    freq_div 
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
`include "global.v"
module freq_div(
  clk_out, // divided clock output
  clk_ctl, // divided clock for seven-segment display scan
  clk_debounce,
  clk, // clock from the crystal
  rst_n // low active reset
);

output clk_out; // divided clock output
output [`FTSD_SCAN_CTL_BIT_WIDTH-1:0] clk_ctl; // divided clock for seven-segment display scan
output clk_debounce;
input clk; // clock from the crystal
input rst_n; // low active reset

reg clk_debounce;
reg clk_out; // divided clock output (in the always block)
reg [`FTSD_SCAN_CTL_BIT_WIDTH-1:0] clk_ctl; // divided clock for seven-segment display scan (in the always block)
reg [14:0] cnt_l; // temperatory buffer
reg [6:0] cnt_h; // temperatory buffer
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input node to flip flops

always@*
clk_debounce=cnt_l[5];

// Combinational block : increase by 1 neglecting overflow
always @(clk_out or cnt_h or cnt_l or clk_ctl)
  cnt_tmp = {clk_out,cnt_h,clk_ctl,cnt_l} + `INCREMENT;

// Sequential block 
always @(posedge clk or negedge rst_n) 
  if (~rst_n) 
	 {clk_out,cnt_h,clk_ctl,cnt_l} <= `FREQ_DIV_BIT'b0; 
  else 
	 {clk_out,cnt_h,clk_ctl,cnt_l} <= cnt_tmp;

endmodule
