`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:11:16 09/18/2015 
// Design Name: 
// Module Name:    buzzer_control 
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
module buzzer_control(
clk, // clock from crystal
rst_n, // active low reset
vol_data,
Do,
Re,
Me,
//LED,
loud_press,
quit_press,
audio_left, // left sound audio
audio_right // right sound audio
);
// I/O declaration
input clk; // clock from crystal
input rst_n; // active low reset
input [31:0] vol_data;
//input [19:0] note_div; // div for note generation
input Do,Re,Me;
input loud_press,quit_press;
output [15:0] audio_left; // left sound audio
output [15:0] audio_right; // right sound audio
// Declare internal signals
reg [19:0] clk_cnt_next, clk_cnt;
reg b_clk, b_clk_next;
reg [19:0] note_div; // div for note generation
//reg [15:0] loud,loud_t;
//reg [15:0] LED_t, LED; 


// Note frequency generation
always @(posedge clk or negedge rst_n)
	if (~rst_n)
	begin
		clk_cnt <= 20'd0;
		b_clk <= 1'b0;
		//loud <= 16'd0;
		//LED <= 16'd0;
	end
	else
	begin
		clk_cnt <= clk_cnt_next;
		b_clk <= b_clk_next;
		//loud <= loud_t;
		//LED <= LED_t;
	end
always @*
	if (clk_cnt == note_div)
	begin
		clk_cnt_next = 20'd0;
		b_clk_next = ~b_clk;
	end
	else
	begin
		clk_cnt_next = clk_cnt + 1'b1;
		b_clk_next = b_clk;
	end
// Assign the amplitude of the note
assign audio_left  = (b_clk == 1'b0) ? vol_data[15:0] : vol_data[31:16];
assign audio_right = (b_clk == 1'b0) ? vol_data[15:0] : vol_data[31:16];

always@(*)
begin
	if(~Do)
		note_div = 20'd153256;
	else if(~Re)
		note_div = 20'd136518;
	else if(~Me)
		note_div = 20'd121212;
	else
		note_div = 20'd0;
end

/*always@*
begin
	if(~loud_press &&(~LED==16'hFFFF))
	begin
		loud_t = loud - 16'h0600;
		LED_t = {1'b1,LED[15:1]};
	end
	else if(~quit_press &&(~LED==16'h8000))
	begin
		loud_t = loud + 16'h0600;
		LED_t = {LED[14:0],1'b0};
	end
	else
	begin
		loud_t = loud;
		LED_t =LED;
	end
end*/


	


endmodule
