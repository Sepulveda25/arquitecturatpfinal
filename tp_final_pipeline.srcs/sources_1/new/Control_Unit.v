`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2019 20:14:23
// Design Name: 
// Module Name: Control_Unit
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
//Inputs:			R-Format		LW		SW		BEQ		             Jmp         Ime            
//			- Op5 		0 			1 		1 		0					 0             0
//			- Op4 		0 			0 		0 		0					 0             0
//			- Op3 		0 			0 		1 		0					 0             1
//			- Op2 		0 			0 		0 		1					 0             0
//			- Op1 		0 			1	 	1 		0					 1             0
//			- Op0 		0 			1 		1 		0					 0	           0
//Outputs:
//			- RegDst 	1 			0 		X 		X					 0             0
//			- ALUSrc 	0 			1 		1 		0					 0             1
//			- MemtoReg 	0 			1 		X 		X					 0             0
//			- RegWrite 	1 			1		0 		0					 0             1
//			- MemRead 	0 			1 		0 		0					 0             0
//			- MemWrite 	0 			0 		1 		0					 0             0
//			- Branch 	0 			0 		0 		1					 0             0
//			- ALUOp1 	1 			0 		0 		0					 0             1
//			- ALUOp0 	0 			0 		0 		1					 0             1
//
//			- InmCtrl	0			0		0		OpCode[2:0]		     0             OpCode[2:0];
//			
//
//////////////////////////////////////////////////////////////////////////////////


module Control_Unit(        input 		[5:0] OpCode, 
							output 		[8:0] ControlFLAGS,
							output reg	[2:0] InmCtrl
                    );

reg RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0;

always@* begin
	case(OpCode)
		//R-Format
		6'b000000: 	begin
							RegDst 		<=	1;
							ALUSrc 		<=	0;
							MemtoReg 	<=	0;
							RegWrite 	<=	1;
							MemRead 	<=	0;
							MemWrite 	<=	0;
							Branch 		<=	0;
							ALUOp1 		<=	1;
							ALUOp0 		<=  0; 
							InmCtrl		<=	0;
					 end
		//LoadW
		6'b100011: 	begin
							RegDst 		<=	0;
							ALUSrc 		<=	1;
							MemtoReg 	<=	1;
							RegWrite 	<=	1;
							MemRead 	<=	1;
							MemWrite 	<=	0;
							Branch 		<=	0;
							ALUOp1 		<=	0;
							ALUOp0 		<=  0; 
							InmCtrl		<=	0;
					end
		//StoreW
		6'b101011: 	begin
							RegDst 		<=	0; // Es X (indistinto)
							ALUSrc 		<=	1;
							MemtoReg 	<=	1; // Es X (indistinto)
							RegWrite 	<=	0;
							MemRead 	<=	0;
							MemWrite 	<=	1;
							Branch 		<=	0;
							ALUOp1 		<=	0;
							ALUOp0 		<=  0; 
							InmCtrl		<=	0;
					end
		//BranchEQ 
		6'b000100: 	begin
							RegDst 		<=	0; // Es X (indistinto)
							ALUSrc 		<=	0;
							MemtoReg 	<=	0; // Es X (indistinto)
							RegWrite 	<=	0;
							MemRead 	<=	0;
							MemWrite 	<=	0;
							Branch 		<=	1;
							ALUOp1 		<=	0;
							ALUOp0 		<=  1; 
							InmCtrl 	<=  OpCode[2:0]; 
						end
		//Jump 
		6'b000010: 	begin
							RegDst 		<=	0;	
							ALUSrc 		<=	0;
							MemtoReg 	<=	0;
							RegWrite 	<=	0;
							MemRead 	<=	0;
							MemWrite 	<=	0;
							Branch 		<=	0;
							ALUOp1 		<=	0;
							ALUOp0 		<=  0; 
							InmCtrl 	<=  0;
					end
		//Immediate Operations
		default: 	begin
							if(OpCode[5:3] == 3'b 001) begin
								RegDst 		<=	0; // Es X (indistinto)
								ALUSrc 		<=	1;
								MemtoReg 	<=	0; // Es X (indistinto)
								RegWrite 	<=	1;
								MemRead 	<=	0;
								MemWrite 	<=	0;
								Branch 		<=	0;
								ALUOp1 		<=	1;
								ALUOp0 		<=  1;
								InmCtrl 	<=  OpCode[2:0]; 
							end
							else begin
								RegDst 		<=	0;
								ALUSrc 		<=	0;
								MemtoReg 	<=	0; 
								RegWrite 	<=	0;
								MemRead 	<=	0;
								MemWrite 	<=	0;
								Branch 		<=	0;
								ALUOp1 		<=	0;
								ALUOp0 		<=  0; 
						end
				end
		endcase
end

assign ControlFLAGS = {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0}; //Se arma la salida
                   
                    
endmodule
