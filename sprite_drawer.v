// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module sprite_drawer(
		 input wire [9:0]  x,
		 input wire [9:0]  y,
		 input wire 	   reset, //asynchronous reset
		 input wire [19:0] invaders_array,
		 input wire [3:0]  invaders_line,
		 input wire [4:0]  ship_x,
		 input wire [4:0]  bullet_x,
		 input wire [3:0]  bullet_y,
		 input wire 	   bullet_flying,
		 input wire [1:0]  gameplay,
		 output reg [2:0]  rgb 
		 );   

   
   reg [31 : 0] 		   invader [31 : 0];
   reg [31 : 0] 		   ship [31 : 0];
   reg [31:0] 			   bullet [0:31];
   reg [31:0] 			   smiley [0:31];
   reg [31:0] 			   sad [0:31];


   
   parameter PLAYING = 2'b00;
   parameter YOU_WIN = 2'b01;
   parameter GAME_OVER = 2'b10;

   initial begin
      rgb <= 3'b000;
      
      invader[0]  <= 32'b00000000000000000000000000000000;
      invader[1]  <= 32'b00000000000000000000000000000000;
      invader[2]  <= 32'b00000000000000000000000000000000;
      invader[3]  <= 32'b00000000000000000000000000000000;
      invader[4]  <= 32'b00000000000000000000000000000000;
      invader[5]  <= 32'b00000000000000000000000000000000;
      invader[6]  <= 32'b00000000000000000000000000000000;
      invader[7]  <= 32'b00000000000000000000000000000000;
      invader[8]  <= 32'b00000000011000000000011000000000;
      invader[9]  <= 32'b00000000011000000000011000000000;
      invader[10] <= 32'b00000000000110000001100000000000;
      invader[11] <= 32'b00000000000110000001100000000000;
      invader[12] <= 32'b00000000011111111111111000000000;
      invader[13] <= 32'b00000000011111111111111000000000;
      invader[14] <= 32'b00000001111001111110011110000000;
      invader[15] <= 32'b00000001111001111110011110000000;
      invader[16] <= 32'b00000111111111111111111111100000;
      invader[17] <= 32'b00000111111111111111111111100000;
      invader[18] <= 32'b00000110011111111111111001100000;
      invader[19] <= 32'b00000110011111111111111001100000;
      invader[20] <= 32'b00000110011000000000011001100000;
      invader[21] <= 32'b00000110011000000000011001100000;
      invader[22] <= 32'b00000000000111100111100000000000;
      invader[23] <= 32'b00000000000111100111100000000000;
      invader[24] <= 32'b00000000000000000000000000000000;
      invader[25] <= 32'b00000000000000000000000000000000;
      invader[26] <= 32'b00000000000000000000000000000000;
      invader[27] <= 32'b00000000000000000000000000000000;
      invader[28] <= 32'b00000000000000000000000000000000;
      invader[29] <= 32'b00000000000000000000000000000000;
      invader[30] <= 32'b00000000000000000000000000000000;
      invader[31] <= 32'b00000000000000000000000000000000;
      
      ship[0]     <= 32'b00000000000000011000000000000000;
      ship[1]     <= 32'b00000000000000011000000000000000;
      ship[2]     <= 32'b00000000000000011000000000000000;
      ship[3]     <= 32'b00000000000000011000000000000000;
      ship[4]     <= 32'b00000000000001111110000000000000;
      ship[5]     <= 32'b00000000000001111110000000000000;
      ship[6]     <= 32'b00000000000001111110000000000000;
      ship[7]     <= 32'b00000000000001111110000000000000;
      ship[8]     <= 32'b00000001100001111110000110000000;
      ship[9]     <= 32'b00000001100001111110000110000000;
      ship[10]    <= 32'b00000001100001111110000110000000;
      ship[11]    <= 32'b00000001100001111110000110000000;
      ship[12]    <= 32'b00000001100111111111100110000000;
      ship[13]    <= 32'b00000001100111111111100110000000;
      ship[14]    <= 32'b00000001111111100111111110000000;
      ship[15]    <= 32'b00000001111111100111111110000000;
      ship[16]    <= 32'b01100001111110000001111110000110;
      ship[17]    <= 32'b01100001111110000001111110000110;
      ship[18]    <= 32'b01100001111110000001111110000110;
      ship[19]    <= 32'b01100001111110000001111110000110;
      ship[20]    <= 32'b01100001111111111111111110000110;
      ship[21]    <= 32'b01100001111111111111111110000110;
      ship[22]    <= 32'b01100111111111111111111111100110;
      ship[23]    <= 32'b01100111111111111111111111100110;
      ship[24]    <= 32'b01111111111111111111111111111110;
      ship[25]    <= 32'b01111111111111111111111111111110;
      ship[26]    <= 32'b01111110011111111111111001111110;
      ship[27]    <= 32'b01111110011111111111111001111110;
      ship[28]    <= 32'b01111000011110011001111000011110;
      ship[29]    <= 32'b01111000011110011001111000011110;
      ship[30]    <= 32'b01100000000000011000000000000110;
      ship[31]    <= 32'b01100000000000011000000000000110;
            
      bullet[0]   <= 32'b00000000000000111100000000000000;
      bullet[1]   <= 32'b00000000000001011110000000000000;
      bullet[2]   <= 32'b00000000000010101111000000000000;
      bullet[3]   <= 32'b00000000000110001111100000000000;
      bullet[4]   <= 32'b00000000001111111111110000000000;
      bullet[5]   <= 32'b00000000001111110011110000000000;
      bullet[6]   <= 32'b00000000011111110001111000000000;
      bullet[7]   <= 32'b00000000011111100001111000000000;
      bullet[8]   <= 32'b00000000011111110001111000000000;
      bullet[9]   <= 32'b00000000011111100001111000000000;
      bullet[10]  <= 32'b00000000011111100011111000000000;
      bullet[11]  <= 32'b00000000011111110011111000000000;
      bullet[12]  <= 32'b00000000011111111111111000000000;
      bullet[13]  <= 32'b00000000000000000000000000000000;
      bullet[14]  <= 32'b00000000010111111111111000000000;
      bullet[15]  <= 32'b00000000010111111111111000000000;
      bullet[16]  <= 32'b00000000000000000000000000000000;
      bullet[17]  <= 32'b00000000000000000000000000000000;
      bullet[18]  <= 32'b00000000000000000000000000000000;
      bullet[19]  <= 32'b00000000000000000000000000000000;
      bullet[20]  <= 32'b00000000000000000000000000000000;
      bullet[21]  <= 32'b00000000000000000000000000000000;
      bullet[22]  <= 32'b00000000000000000000000000000000;
      bullet[23]  <= 32'b00000000000000000000000000000000;
      bullet[24]  <= 32'b00000000000000000000000000000000;
      bullet[25]  <= 32'b00000000000000000000000000000000;
      bullet[26]  <= 32'b00000000000000000000000000000000;
      bullet[27]  <= 32'b00000000000000000000000000000000;
      bullet[28]  <= 32'b00000000000000000000000000000000;
      bullet[29]  <= 32'b00000000000000000000000000000000;
      bullet[30]  <= 32'b00000000000000000000000000000000;
      bullet[31]  <= 32'b00000000000000000000000000000000;

      smiley[0]   <= 32'b11111111111111111111111111111111;
      smiley[1]   <= 32'b11111111111111111111111111111111;
      smiley[2]   <= 32'b11111000000000000000000000011111;
      smiley[3]   <= 32'b11100000000000000000000000000111;
      smiley[4]   <= 32'b10000000000000000000000000000001;
      smiley[5]   <= 32'b10000000000000000000000000000001;
      smiley[6]   <= 32'b10000000000000000000000000000001;
      smiley[7]   <= 32'b10000000000000000000000000000001;
      smiley[8]   <= 32'b10000001111000000000011110000001;
      smiley[9]   <= 32'b10000001111000000000011110000001;
      smiley[10]  <= 32'b10000001111000000000011110000001;
      smiley[11]  <= 32'b10000001111000000000011110000001;
      smiley[12]  <= 32'b10000000000000000000000000000001;
      smiley[13]  <= 32'b10000000000000000000000000000001;
      smiley[14]  <= 32'b10000000000000000000000000000001;
      smiley[15]  <= 32'b10000000000000000000000000000001;
      smiley[16]  <= 32'b10000000000000000000000000000001;
      smiley[17]  <= 32'b10000000000000000000000000000001;
      smiley[18]  <= 32'b10000000000000000000000000000001;
      smiley[19]  <= 32'b10000110000000000000000001100001;
      smiley[20]  <= 32'b10000011000000000000000011000001;
      smiley[21]  <= 32'b10000001100000000000000110000001;
      smiley[22]  <= 32'b10000000110000000000001100000001;
      smiley[23]  <= 32'b10000000011000000000011000000001;
      smiley[24]  <= 32'b10000000000111111111110000000001;
      smiley[25]  <= 32'b10000000000000000000000000000001;
      smiley[26]  <= 32'b10000000000000000000000000000001;
      smiley[27]  <= 32'b10000000000000000000000000000001;
      smiley[28]  <= 32'b11100000000000000000000000000111;
      smiley[29]  <= 32'b11111000000000000000000000011111;
      smiley[30]  <= 32'b11111111111111111111111111111111;
      smiley[31]  <= 32'b11111111111111111111111111111111;

      sad[0]   <= 32'b11111111111111111111111111111111;
      sad[1]   <= 32'b11111111111111111111111111111111;
      sad[2]   <= 32'b11111000000000000000000000011111;
      sad[3]   <= 32'b11100000000000000000000000000111;
      sad[4]   <= 32'b10000000000000000000000000000001;
      sad[5]   <= 32'b10000000000000000000000000000001;
      sad[6]   <= 32'b10000000000000000000000000000001;
      sad[7]   <= 32'b10000000000000000000000000000001;
      sad[8]   <= 32'b10000001111000000000011110000001;
      sad[9]   <= 32'b10000001111000000000011110000001;
      sad[10]  <= 32'b10000001111000000000011110000001;
      sad[11]  <= 32'b10000001111000000000011110000001;
      sad[12]  <= 32'b10000000000000000000000000000001;
      sad[13]  <= 32'b10000000000000000000000000000001;
      sad[14]  <= 32'b10000000000000000000000000000001;
      sad[15]  <= 32'b10000000000000000000000000000001;
      sad[16]  <= 32'b10000000000000000000000000000001;
      sad[17]  <= 32'b10000000000000000000000000000001;
      sad[18]  <= 32'b10000000000000000000000000000001;
      sad[19]  <= 32'b10000000000000000000000000000001;
      sad[20]  <= 32'b10000000000111111111110000000001;
      sad[21]  <= 32'b10000000001100000000011000000001;
      sad[22]  <= 32'b10000000011000000000001100000001;
      sad[23]  <= 32'b10000000110000000000000110000001;
      sad[24]  <= 32'b10000001100000000000000011000001;
      sad[25]  <= 32'b10000011000000000000000001100001;
      sad[26]  <= 32'b10000000000000000000000000000001;
      sad[27]  <= 32'b10000000000000000000000000000001;
      sad[28]  <= 32'b11100000000000000000000000000111;
      sad[29]  <= 32'b11111000000000000000000000011111;
      sad[30]  <= 32'b11111111111111111111111111111111;
      sad[31]  <= 32'b11111111111111111111111111111111;
      
   end
   
   parameter [2:0] 	   BLACK = 3'b000;
   parameter [2:0] 	   BLUE = 3'b001;
   parameter [2:0] 	   GREEN = 3'b010;
   parameter [2:0] 	   CYAN = 3'b011;
   parameter [2:0] 	   RED = 3'b100;
   parameter [2:0] 	   MAGENTA = 3'b101;
   parameter [2:0] 	   YELLOW = 3'b110;
   parameter [2:0] 	   WHITE = 3'b111;
   
   wire [4:0] 			   sprite_x = x[9:5];
   wire [3:0] 			   sprite_y = y[8:5];
   wire [4:0] 			   index_x = x[4:0];
   wire [4:0] 			   index_y = y[4:0];
   
   always @(*) begin
      if (reset == 1) begin
	 if (gameplay == YOU_WIN) begin
	    if (smiley[index_y][index_x] == 1)
	      rgb <= BLACK;
	    else
	      rgb <= YELLOW;
	 end
	 else if (gameplay == GAME_OVER) begin
	    if (sad[index_y][index_x] == 1)
	      rgb <= BLACK;
	    else
	      rgb <= RED;
	 end
	 else if (gameplay == PLAYING) begin
	    // drawing bullet
	    if (bullet_flying == 1 && (sprite_x == bullet_x) && (sprite_y == bullet_y)) begin
	       if (bullet[index_y][index_x] == 1)
		 rgb <= YELLOW;
	       else
		 rgb <= BLACK;
	    end
	    // drawing ship (it is always in row 13)
	    else if (sprite_x == ship_x && sprite_y == 13) begin
	       if (ship[index_y][index_x] == 1)
		 rgb <= RED;
	       else
		 rgb <= BLACK;
	    end
	    // drawing invader
	    else if (sprite_y == invaders_line && invaders_array[sprite_x] == 1) begin
	       if (invader[index_y][index_x] == 1)
		 rgb <= MAGENTA;
	       else
		 rgb <= BLACK;
	    end
	    //background
	    else
	      rgb <= BLACK;
	 end // if (gameplay == PLAYING)
      end // if (reset == 1)   
      else begin
	 //Black and white chessboard
	 if (sprite_x[0] ^ sprite_y[0] == 1)
	   rgb <= WHITE;
	 else rgb <= BLACK;
      end
   end // always @ (*)
  
   //end
endmodule
