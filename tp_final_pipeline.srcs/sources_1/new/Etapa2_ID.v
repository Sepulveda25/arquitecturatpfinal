`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2019 20:11:55
// Design Name: 
// Module Name: Etapa2_ID
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


module Etapa2_ID(   //Inputs
                    input Clk, Reset, Stall, 
                    input [31:0]    Latch_IF_ID_InstrOut, 
                    input [4:0]	    posReg,
                    input			posSel,
                    input [4:0] 	Latch_MEM_WB_Mux,
                    input [31:0] 	Mux_WB, 
                    input 			Latch_MEM_WB_RegWrite, 
                    //Outputs
                    output [31:0] 	E2_ReadDataA, E2_ReadDataB, 
                    output [8:0] 	Mux_ControlFLAGS_Out, 
                    output [31:0] 	SignExtendOut,
                    output [2:0] 	E2_InmCtrl

    );

//Cables de Interconexion
wire [8:0] ControlFLAGS;
wire [4:0] Mux_To_Reg;

//Variables
reg [8:0] Cero=0;


//Multiplexor Address desde RS o desde Debug
MUX #(.LEN(5)) Mux_Mem( .InputA(Latch_IF_ID_InstrOut[25:21]), 
                        .InputB(posReg), 
                        .SEL(posSel), 
                        .Out(Mux_To_Reg));

Registers Regs(	//Inputs
                .Clk(Clk),
                .Reset(Reset),
                .ReadRegisterA(Mux_To_Reg), 
                .ReadRegisterB(Latch_IF_ID_InstrOut[20:16]), 
                .WriteRegister(Latch_MEM_WB_Mux), 
                .WriteData(Mux_WB), 
                .RegWrite(Latch_MEM_WB_RegWrite),
                //Outputs
                .ReadDataA(E2_ReadDataA), 
                .ReadDataB(E2_ReadDataB));
							
Control_Unit Control(   .OpCode(Latch_IF_ID_InstrOut[31:26]), 
                        .ControlFLAGS(ControlFLAGS),
                        .InmCtrl(E2_InmCtrl));

MUX #(.LEN(9)) Stall_mux(   .InputA(ControlFLAGS), 
                            .InputB(Cero), 
                            .SEL(Stall), 
                            .Out(Mux_ControlFLAGS_Out));

Sign_Extend SignExt( .Latch_IF_ID_InstrOut(Latch_IF_ID_InstrOut[15:0]), 
                     .SignExtendOut(SignExtendOut));

    
endmodule
