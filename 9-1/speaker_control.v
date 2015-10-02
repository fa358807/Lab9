`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:23:44 09/18/2015 
// Design Name: 
// Module Name:    speaker_control 
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
module speaker_control(
clk, // clock from the crystal
rst_n, // active low reset
audio_in_left, // left channel audio data input
audio_in_right, // right channel audio data input
audio_appsel, // playing mode selection
audio_sysclk, // control clock for DAC (from crystal)
audio_bck, // bit clock of audio data (5MHz)
audio_ws, // left/right parallel to serial control
audio_data // serial output audio data
    );
	 
input clk,rst_n;
input [15:0] audio_in_left, audio_in_right;

output audio_appsel; // playing mode selection
output audio_sysclk; // control clock for DAC (from crystal)
output audio_bck; // bit clock of audio data (5MHz)
output audio_ws; // left/right parallel to serial control
output audio_data; // serial output audio data

reg clk_out; // divided clock output (in the always block)
reg [1:0] clk_ctl; // divided clock for seven-segment display scan (in the always block)
reg [14:0] cnt_l; // temperatory buffer
reg [6:0] cnt_h; // temperatory buffer
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input node to flip flops

reg audio_data;

assign audio_appsel = 1;
assign audio_sysclk = clk;
assign audio_bck = cnt_l[2];
assign audio_ws = cnt_l[7];

// Combinational block 
always @(clk_out or cnt_h or cnt_l or clk_ctl)
  cnt_tmp = {clk_out,cnt_h,clk_ctl,cnt_l} + 1'b1;
  
// Sequential block 
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    {clk_out,cnt_h,clk_ctl,cnt_l} <= `FREQ_DIV_BIT'b0;
  else
    {clk_out,cnt_h,clk_ctl,cnt_l} <= cnt_tmp;

always @*
begin
	case (cnt_l[7:3])
	5'd0: audio_data = audio_in_right[15];
	5'd1: audio_data = audio_in_right[14];
	5'd2: audio_data = audio_in_right[13];
	5'd3: audio_data = audio_in_right[12];
	5'd4: audio_data = audio_in_right[11];
	5'd5: audio_data = audio_in_right[10];
	5'd6: audio_data = audio_in_right[9];
	5'd7: audio_data = audio_in_right[8];
	5'd8: audio_data = audio_in_right[7];
	5'd9: audio_data = audio_in_right[6];
	5'd10: audio_data = audio_in_right[5];
	5'd11: audio_data = audio_in_right[4];
	5'd12: audio_data = audio_in_right[3];
	5'd13: audio_data = audio_in_right[2];
	5'd14: audio_data = audio_in_right[1];
	5'd15: audio_data = audio_in_right[0];
	5'd16: audio_data = audio_in_left[15];
	5'd17: audio_data = audio_in_left[14];
	5'd18: audio_data = audio_in_left[13];
	5'd19: audio_data = audio_in_left[12];
	5'd20: audio_data = audio_in_left[11];
	5'd21: audio_data = audio_in_left[10];
	5'd22: audio_data = audio_in_left[9];
	5'd23: audio_data = audio_in_left[8];
	5'd24: audio_data = audio_in_left[7];
	5'd25: audio_data = audio_in_left[6];
	5'd26: audio_data = audio_in_left[5];
	5'd27: audio_data = audio_in_left[4];
	5'd28: audio_data = audio_in_left[3];
	5'd29: audio_data = audio_in_left[2];
	5'd30: audio_data = audio_in_left[1];
	5'd31: audio_data = audio_in_left[0];
	endcase
end


endmodule
