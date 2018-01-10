//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    Timer
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: timer 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module timer_1us(
				input wire clk_12MHz,
				input wire reset, //synchronous reset
				input wire en,
				output reg q	       
				);

   parameter PERIOD = 1;
   localparam CLK_FREQ = 12; //12 MHz clock
   localparam MAX = (PERIOD * CLK_FREQ) - 1;
   reg [20:0] 				   count;

   initial begin
      q <= 0;
      count <= 0;
   end
   
   always @(posedge clk_12MHz)
     begin
	if (reset == 1)
	  count <= 0;
	else
	  count <= count + 1;   
	if (count == MAX)
	  q <= 1;
	else
	  q <= 0;
     end // always @ (posedge clk_12MHz)
endmodule
