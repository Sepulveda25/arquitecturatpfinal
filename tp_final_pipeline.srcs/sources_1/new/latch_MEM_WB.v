`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2019 23:06:10
// Design Name: 
// Module Name: latch_MEM_WB
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


module Latch_MEM_WB(	//Inputs
                        input Clk, Reset,
                        input [1:0] 	WriteBack_FLAGS_In, 	// {RegWrite, MemtoReg}
                        input [31:0]	E4_DataOut,
                        input [31:0]	Latch_Ex_MEM_ALUOut,
                        input [4:0]		Latch_Ex_MEM_Mux,
                        input			enable,
                        //Outputs
                        output reg	[31:0]  Latch_MEM_WB_DataOut,
                        output reg	[31:0]	Latch_MEM_WB_ALUOut,  
                        output reg	[4:0]	Latch_MEM_WB_Mux, 
                        output reg	[1:0]	WriteBack_FLAGS_Out	// {RegWrite, MemtoReg}
                     );

always@(negedge Clk) begin
	if(Reset) begin
		WriteBack_FLAGS_Out 	         <= 0;
		Latch_MEM_WB_DataOut	         <= 0;
		Latch_MEM_WB_ALUOut	             <= 0;
		Latch_MEM_WB_Mux		         <= 0;
	end
	else if (enable) begin
		WriteBack_FLAGS_Out 	         <= WriteBack_FLAGS_In;
		Latch_MEM_WB_DataOut	         <= E4_DataOut;
		Latch_MEM_WB_ALUOut	             <= Latch_Ex_MEM_ALUOut;
		Latch_MEM_WB_Mux		         <= Latch_Ex_MEM_Mux;
	end
end


endmodule
