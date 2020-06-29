`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2019 22:57:58
// Design Name: 
// Module Name: latch_EX_MEM
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

module Latch_EX_MEM(	//Inputs 14
                        input Clk, Reset,
                        input [1:0] 	WriteBack_FLAGS_In, 	// {MemtoReg, RegWrite}
                        input [3:0]		Mem_FLAGS_In, 			// {MemRead, MemWrite, BranchEQ, BranchNE}
                        input [31:0]	E3_Adder_Out,
                        input			E3_ALU_Zero,
                        input [31:0]	E3_ALUOut, 
                        input [31:0]	Latch_ID_Ex_ReadDataA,
                        input [31:0]	Latch_ID_Ex_ReadDataB,
                        input [4:0]		E3_MuxOut, 
                        input [31:0]    E3_pc_jmp_jal, //nuevo
                        input           E3_JR_or_JALR_flag,//nuevo
                        input           E3_J_or_JAL_flag, //nuevo
                        input			enable,

                        //Outputs 11
                        output reg 	[1:0] 	WriteBack_FLAGS_Out, 		// {MemtoReg, RegWrite}
                        output reg	[3:0]	Mem_FLAGS_Out, 				// {MemRead, MemWrite, BranchEQ, BranchNE}
                        output reg	[31:0]	Latch_Ex_MEM_E3_Adder_Out,
                        output reg			Latch_Ex_MEM_Zero,
                        output reg	[31:0]	Latch_Ex_MEM_E3_ALUOut, 	//Addr a DataMem 
                        output reg	[31:0] 	Latch_Ex_MEM_ReadDataA,     //PC de JR o JALR
                        output reg	[31:0] 	Latch_Ex_MEM_ReadDataB,		//DataIn a DataMem
                        output reg	[4:0]	Latch_Ex_MEM_Mux,           
                        output reg  [31:0]  Latch_Ex_MEM_pc_jmp_jal, //nuevo
                        output reg          Latch_Ex_MEM_JR_or_JALR_flag,//nuevo
                        output reg          Latch_Ex_MEM_J_or_JAL_flag //nuevo
                     );
 					 

always@(negedge Clk) begin
	if(Reset) begin
		WriteBack_FLAGS_Out			    <= 0;
		Mem_FLAGS_Out				    <= 0;
		Latch_Ex_MEM_E3_Adder_Out	    <= 0;
		Latch_Ex_MEM_Zero			    <= 0;
		Latch_Ex_MEM_E3_ALUOut	        <= 0;
		Latch_Ex_MEM_ReadDataA          <= 0;
		Latch_Ex_MEM_ReadDataB		    <= 0;
		Latch_Ex_MEM_Mux		        <= 0;
		Latch_Ex_MEM_pc_jmp_jal         <= 0;//nuevo
        Latch_Ex_MEM_JR_or_JALR_flag    <= 0;//nuevo
        Latch_Ex_MEM_J_or_JAL_flag      <= 0;//nuevo
	end
	else if(enable) begin
		WriteBack_FLAGS_Out			    <= WriteBack_FLAGS_In;
		Mem_FLAGS_Out				    <= Mem_FLAGS_In;
		Latch_Ex_MEM_E3_Adder_Out	    <= E3_Adder_Out;
		Latch_Ex_MEM_Zero			    <= E3_ALU_Zero; 
		Latch_Ex_MEM_E3_ALUOut	        <= E3_ALUOut; //Addr a DataMem 
		Latch_Ex_MEM_ReadDataA          <= Latch_ID_Ex_ReadDataA;
		Latch_Ex_MEM_ReadDataB		    <= Latch_ID_Ex_ReadDataB;
		Latch_Ex_MEM_Mux	            <= E3_MuxOut;  
        Latch_Ex_MEM_pc_jmp_jal         <= E3_pc_jmp_jal;//nuevo
        Latch_Ex_MEM_JR_or_JALR_flag    <= E3_JR_or_JALR_flag;//nuevo
        Latch_Ex_MEM_J_or_JAL_flag      <= E3_J_or_JAL_flag;//nuevo
	end
end

endmodule
