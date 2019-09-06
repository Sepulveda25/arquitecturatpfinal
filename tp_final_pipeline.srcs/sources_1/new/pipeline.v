`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2019 18:49:31
// Design Name: 
// Module Name: pipeline
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


module pipeline(

    );
    
//-----------------------     Cables de Interconexion     ---------------------------------------------------------------
    
// Outputs de Etapa 1, y entran en los inputs del Latch "IF/ID"
wire [31:0] E1_AddOut;
wire [31:0] E1_InstrOut;
wire [31:0] PC_Out;
//Outputs del Latch "IF/ID"
wire [31:0] Latch_IF_ID_Adder_Out;
wire [31:0] Latch_IF_ID_InstrOut;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//---------------------------------   	Etapa 1 "IF" + Latch IF/ID   --------------------------------------------------

Etapa1_IF E1_IF(	.Clk(Clk), 
                    .Reset(Reset), 
                    .InputB_MUX(Latch_Ex_MEM_E3_Adder_Out), 
                    .PCScr(PCScr), 
                    .Stall(Stall),
					.enable(enable), 
					.E1_AddOut(E1_AddOut), 
					.E1_InstrOut(E1_InstrOut), 
					.PC_Out(PC_Out)
					);	

Latch_IF_ID IF_ID(	.Clk(Clk), .Reset(Reset), .Adder_Out(E1_AddOut), .Instruction_In(E1_InstrOut), .Stall(Stall),
							.enable(enable), .Latch_IF_ID_Adder_Out(Latch_IF_ID_Adder_Out), .Latch_IF_ID_InstrOut(Latch_IF_ID_InstrOut)
						);

endmodule
