`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:54:22 07/20/2026
// Design Name:   Traffic_controller
// Module Name:   /home/ise/Traffic_light/tb_traffic_controller.v
// Project Name:  Traffic_light
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Traffic_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_traffic_controller;

	// Inputs
	reg clk;
	reg rst;
	reg emergency_A;
	reg emergency_B;
	reg emergency_C;

	// Outputs
	wire A_red;
	wire A_yellow;
	wire A_green;
	
	wire B_red;
	wire B_yellow;
	wire B_green;
	
	wire C_red;
	wire C_yellow;
	wire C_green;

	// Instantiate the Unit Under Test (UUT)
	Traffic_controller uut (
		.clk(clk), 
		.rst(rst), 
		.emergency_A(emergency_A), 
		.emergency_B(emergency_B), 
		.emergency_C(emergency_C), 
		.A_red(A_red), 
		.A_yellow(A_yellow), 
		.A_green(A_green), 
		.B_red(B_red), 
		.B_yellow(B_yellow), 
		.B_green(B_green), 
		.C_red(C_red), 
		.C_yellow(C_yellow), 
		.C_green(C_green)
	);

	always 
	begin
		#5 clk=~clk;
	end
	
	initial begin
		// Initialize Inputs 
		
		clk = 0;
		rst = 1;  //(initially reset for default functioning)
		emergency_A = 0;
		emergency_B = 0;
		emergency_C = 0;
		
		//Test-1 : reset
		#20;
		rst=0;
		
		//Test-2 : Normal traffic (default)
		#140;
		
		//Test-3 : Emergency on A
		emergency_A=1;
		#80;
		emergency_A=0;
		#50;
		
		//Test-4 : Emergency on C
		emergency_C=1;
		#80;
		emergency_C=0;
		#50;
    
		//Test-5 : Emergency on A and B
		emergency_A=1;
		emergency_B=1;
		#80;
		emergency_A=0;
		emergency_B=0;
		#50;
		
		
	$stop;
	
	 end
      
endmodule


