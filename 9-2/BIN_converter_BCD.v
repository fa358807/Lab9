`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:48 09/19/2015 
// Design Name: 
// Module Name:    BIN_converter_BCD 
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
module BIN_converter_BCD(
	in,
	units,
	tens,
	hunds
);

	// Defs
	input [7:0] in;
	output [3:0] units, tens, hunds;
	wire [3:0] c1,c2,c3,c4,c5,c6,c7;
	wire [3:0] d1,d2,d3,d4,d5,d6,d7;
	
	// Converter
	assign d1 = {1'b0,in[7:5]};
	assign d2 = {c1[2:0],in[4]};
	assign d3 = {c2[2:0],in[3]};
	assign d4 = {c3[2:0],in[2]};
	assign d5 = {c4[2:0],in[1]};
	assign d6 = {1'b0,c1[3],c2[3],c3[3]};
	assign d7 = {c6[2:0],c4[3]};
	add3 m1(d1,c1);
	add3 m2(d2,c2);
	add3 m3(d3,c3);
	add3 m4(d4,c4);
	add3 m5(d5,c5);
	add3 m6(d6,c6);
	add3 m7(d7,c7);
	assign units = {c5[2:0],in[0]};
	assign tens = {c7[2:0],c5[3]};
	assign hunds = {c6[3],c7[3]};


endmodule
