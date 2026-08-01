`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:29 07/20/2026 
// Design Name: 
// Module Name:    Traffic_controller 
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
module Traffic_controller(
    input clk,
    input rst,
    input emergency_A,
    input emergency_B,
    input emergency_C,
	 
	 output reg A_red,
	 output reg A_yellow,
	 output reg A_green,
	 
	 output reg B_red,
	 output reg B_yellow,
	 output reg B_green,
	 
	 output reg C_red,
	 output reg C_yellow,
	 output reg C_green	 
    );

parameter 

A_g=4'd0,
A_y=4'd1,

B_g=4'd2,
B_y=4'd3,

C_g=4'd4,
C_y=4'd5,

Em_A=4'd6,
Em_B=4'd7,
Em_C=4'd8;

parameter green_time=10;
parameter yellow_time=3;
parameter emergency_time=8; 

reg[3:0] current_state;
reg[3:0] next_state;
reg[4:0] timer;

always@(posedge clk or posedge rst)
begin
	if(rst)
		begin
			current_state=A_g;
			next_state=A_g;
			timer=0;
		end
	else
		begin
			case(current_state)
			
			A_g:
				begin
				if(emergency_A)
							next_state=Em_A;
				else if(emergency_B || emergency_C || timer==green_time)
							next_state=A_y;
					else
							next_state=A_g;
				end
			
			A_y:
				begin
					if(timer==yellow_time)
						begin
							if(emergency_B)
								next_state=Em_B;
							else if(emergency_C)
								next_state=Em_C;
							else
								next_state=B_g;
						end
					else
						next_state=A_y;
				end
			
			B_g:
				begin
				if(emergency_B)
							next_state=Em_B;
				else if(emergency_C || emergency_A || timer==green_time)
							next_state=B_y;
					else
							next_state=B_g;
				end
			
			B_y:
				begin
					if(timer==yellow_time)
						begin
							if(emergency_C)
								next_state=Em_C;
							else if(emergency_A)
								next_state=Em_A;
							else
								next_state=C_g;
						end
					else
						next_state=B_y;
				end
			
			C_g:
				begin
				if(emergency_C)
							next_state=Em_C;
				else if(emergency_B || emergency_A || timer==green_time)
							next_state=C_y;
					else
							next_state=C_g;
				end
			
			C_y:
				begin
					if(timer==yellow_time)
						begin
							if(emergency_A)
								next_state=Em_A;
							else if(emergency_B)
								next_state=Em_B;
							else
								next_state=A_g;
						end
					else
						next_state=C_y;
				end
				
			Em_A:
				begin
					if(timer==emergency_time && !emergency_A)
						next_state=A_y;
					else
						next_state=Em_A;
				end
			
			Em_B:
				begin
					if(timer==emergency_time && !emergency_B)
						next_state=B_y;
					else
						next_state=Em_B;
				end
			
			Em_C:
				begin
					if(timer==emergency_time && !emergency_C)
						next_state=C_y;
					else
						next_state=Em_C;
				end
			
			
		endcase 
		current_state=next_state;
		
		if(current_state!=next_state)
			timer=0;
		else
			timer=timer+1;
	end	
end

always@(*)
	begin
			A_red=0;
			A_yellow=0;
			A_green=0;
			B_red=0;
			B_yellow=0;
			B_green=0;
			C_red=0;
			C_yellow=0;
			C_green=0;
				
				case(current_state)
				
					A_g,Em_A:
						begin
							A_green=1;
							B_red=1;
							C_red=1;
						end
					A_y:
						begin
							A_yellow=1;
							B_red=1;
							C_red=1;
						end
					
					B_g,Em_B:
						begin
							B_green=1;
							A_red=1;
							C_red=1;
						end
					B_y:
						begin
							B_yellow=1;
							A_red=1;
							C_red=1;
						end
					
					C_g,Em_C:
						begin
							C_green=1;
							A_red=1;
							B_red=1;
						end
					C_y:
						begin
							C_yellow=1;
							A_red=1;
							B_red=1;
						end
				endcase					
	end

endmodule

