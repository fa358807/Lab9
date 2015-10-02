`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:27 09/18/2015 
// Design Name: 
// Module Name:    speaker 
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
module speaker(
clk, // clock from crystal
rst_n, // active low reset
Do,
Re,
Me,
vol_level,
loud_press,
quit_press,
loud_out,
quit_out,
audio_appsel, // playing mode selection
audio_sysclk, // control clock for DAC (from crystal)
audio_bck, // bit clock of audio data (5MHz)
audio_ws, // left/right parallel to serial control
audio_data // serial output audio data
);
// I/O declaration
input clk; // clock from the crystal
input rst_n; // active low reset
input Do,Re,Me;
input loud_press,quit_press;
output audio_appsel; // playing mode selection
output audio_sysclk; // control clock for DAC (from crystal)
output audio_bck; // bit clock of audio data (5MHz)
output audio_ws; // left/right parallel to serial control
output audio_data; // serial output audio data
output reg loud_out,quit_out;
output [3:0] vol_level;
// Declare internal nodes
wire [15:0] audio_in_left, audio_in_right;
wire clk_d,clk_debounce;
wire [1:0] ftsd_ctl_en;
wire Do_out,Re_out,Me_out;
wire [31:0] vol_data;

always@*
begin
 loud_out = loud_press;
 quit_out = quit_press;
end

freqdiv freqdiv(
  .clk_40M(clk), // clock from the 40MHz oscillator
  .rst_n(rst_n), // low active reset
  .clk_1(clk_d), // divided clock output
  .clk_debounce(clk_debounce), // clock control for debounce circuit
  .clk_ftsd_scan(ftsd_ctl_en) // divided clock for 14-segment display scan
);

sound_setting sound_set(
.clk(clk_d),
.rst_n(rst_n),
.loud_press(loud_press),
.quit_press(quit_press),
.vol_data(vol_data),
.vol_level(vol_level)
    );

// Note generation
buzzer_control Ubc(
.clk(clk), // clock from crystal
.rst_n(rst_n), // active low reset
.vol_data(vol_data),
.Do(~Do_out),
.Re(~Re_out),
.Me(~Me_out),
//.LED(),
.loud_press(loud_press),
.quit_press(quit_press),
.audio_left(audio_in_left), // left sound audio
.audio_right(audio_in_right) // right sound audio
);

// Speaker controllor
speaker_control Usc(
.clk(clk), // clock from the crystal
.rst_n(rst_n), // active low reset
.audio_in_left(audio_in_left), // left channel audio data input
.audio_in_right(audio_in_right), // right channel audio data input
.audio_appsel(audio_appsel), // playing mode selection
.audio_sysclk(audio_sysclk), // control clock for DAC (from crystal)
.audio_bck(audio_bck), // bit clock of audio data (5MHz)
.audio_ws(audio_ws), // left/right parallel to serial control
.audio_data(audio_data) // serial output audio data
);

/*pushbutton loud(
.clk(clk_debounce),
.rst_n(rst_n),
.pb_in(loud_press),
.out_pulse(loud_out)
    );
pushbutton quit(
.clk(clk_debounce),
.rst_n(rst_n),
.pb_in(quit_press),
.out_pulse(quit_out)
    );*/

debounce_circuit Do_deb(
  .clk(clk_debounce), // clock control
  .rst_n(rst_n), // reset
  .pb_in(Do), //push button input
  .pb_debounced(Do_out) // debounced push button output
);
debounce_circuit Re_deb(
  .clk(clk_debounce), // clock control
  .rst_n(rst_n), // reset
  .pb_in(Re), //push button input
  .pb_debounced(Re_out) // debounced push button output
);
debounce_circuit Me_deb(
  .clk(clk_debounce), // clock control
  .rst_n(rst_n), // reset
  .pb_in(Me), //push button input
  .pb_debounced(Me_out) // debounced push button output
);




endmodule
