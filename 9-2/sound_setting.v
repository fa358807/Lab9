`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:13:27 09/19/2015 
// Design Name: 
// Module Name:    sound_setting 
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
module sound_setting(
clk,
rst_n,
loud_press,
quit_press,
vol_data,
vol_level
    );
input clk;
input rst_n;
input loud_press;
input quit_press;
output reg [4:0] vol_level;
output reg [31:0] vol_data;
reg [31:0] vol_data_next;
reg [4:0] vol_level_next;

// Volume Control
	always @*
	begin
		if (~loud_press)
		begin
			vol_level_next = vol_level + 1'd1;
			vol_data_next[31:16] = vol_data[31:16] + 16'h400;
			vol_data_next[15:0] = vol_data[15:0] - 16'h400;
		end
		else if (~quit_press)
		begin
			vol_level_next = vol_level - 1'd1;
			vol_data_next[31:16] = vol_data[31:16] - 16'h400;
			vol_data_next[15:0] = vol_data[15:0] + 16'h400;
		end
		else
		begin
			vol_level_next = vol_level;
			vol_data_next = vol_data;
		end
	end

	always @(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
		begin
			vol_level <= 4'd0;
			vol_data <= {16'h0000, 16'h0000};
		end
		else
		begin
			vol_level <= vol_level_next;
			vol_data <= vol_data_next;
		end
	end

endmodule
