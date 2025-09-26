`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2025 08:28:54 PM
// Design Name: 
// Module Name: Bin2BCD
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Bin2BCD(bin, clk, ones, tens, hundreds, thousands);

input [11:0] bin;
input clk;

output reg[3:0] ones;
output reg[3:0] tens;
output reg[3:0] hundreds;
output reg[3:0] thousands;

integer i;
reg [27:0] shift_reg;
always @* begin
    shift_reg=28'd0;
    shift_reg[11:0] = bin;
	for (i=0; i<12; i=i+1) begin
	   if (shift_reg[15:12] >= 5)//ones
	   shift_reg[15:12] = shift_reg[15:12]+3;
	   if (shift_reg[19:16] >= 5)//tens
	   shift_reg[19:16] = shift_reg[19:16]+3;
	   if (shift_reg[23:20] >= 5)//hundreds
	   shift_reg[23:20] = shift_reg[23:20]+3;
	   if (shift_reg[27:24] >= 5)//thousands
	   shift_reg[27:24] = shift_reg[27:24]+3;
	   shift_reg=shift_reg<<1; //shift left 
	end
ones= shift_reg[27:24];
tens= shift_reg[23:20];
hundreds= shift_reg[19:16];
thousands= shift_reg[15:12];
end
