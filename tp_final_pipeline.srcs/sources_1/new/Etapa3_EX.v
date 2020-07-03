`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2019 01:49:02
// Design Name: 
// Module Name: Etapa3_EX
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


module Etapa3_EX(   //Inputs 12
                    input [3:0]		Ex_FLAGS,// {RegDst, ALUSrc, ALUOp1, ALUOp0} //ex [7:0]		Ex_FLAGS, // {JR , JALR, Jmp, JAL, RegDst, ALUSrc, ALUOp1, ALUOp0}
                    input [31:0] 	Latch_ID_Ex_Adder_Out, Latch_ID_Ex_ReadDataA, Latch_ID_Ex_ReadDataB,
                    input [31:0] 	Latch_ID_Ex_SignExtendOut, 
                    input [4:0]		Latch_ID_Ex_InstrOut_20_16_Rt, Latch_ID_Ex_InstrOut_15_11_Rd,
                    input [25:0]    Latch_ID_Ex_InstrOut_25_0_instr_index,
                    input [2:0]		Latch_ID_Ex_InmCtrl,
                    input [31:0]	Latch_Ex_MEM_ALUOut,	//Wire externo!! (del Latch "EX/MEM")
                    input [31:0]	Mux_WB,					//Wire externo!! (del Mux WB de la Etapa 5 "WB")
                    input [1:0]		ForwardA,				//Wire externo!! (de la Unidad de Cortocircuito)
                    input [1:0]		ForwardB,				//Wire externo!! (de la Unidad de Cortocircuito)
                    //Outputs 5
                    output [31:0] 	E3_Adder_Out, 
                    output [31:0]   E3_ALUOut,
                    output 			E3_ALU_Zero,
                    output [4:0] 	E3_MuxOut,
                    output [31:0] 	MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB
//                    output [31:0]   E3_pc_jmp_jal, //nuevo
//                    output 			E3_JR_or_JALR_flag,//nuevo
//                    output          E3_J_or_JAL_flag //nuevo
                );
                
//Variables
localparam ALUScr = 2;
localparam RegDst = 3;
//localparam JAL = 4;
//localparam Jmp = 5;
//localparam JALR = 6;
//localparam JR = 7;


//Variables para modulos JUMP
//reg [31:0] InputB_Adder=4;
//reg [4:0] reg_link = 31;

//Cables de Interconexion
wire [5:0]  ALUControl_to_ALU;
wire [31:0] MUX_to_ALU;
wire [31:0] Shift_to_Add;
wire [31:0] E3_WriteDataB;
wire [4:0]  Shift_Ctrl_ALU;
wire [5:0]  InmCtrlOut_ALU;
wire [31:0] Mux_CortoA_Out_to_ALU_DataA;
wire [31:0] Mux_CortoB_Out_to_ALU_DataB;

//Cables de Interconexion para modulos JUMP 
//wire [31:0] E3_ALUOut;
//wire [31:0] E3_AddOut;
//wire JALR_or_JAL_Flag;
//wire [31:0] sub_PC;
//wire [4:0] 	E3_MuxOut;

Adder adder_EX( //Inputs
                .InputA(Latch_ID_Ex_Adder_Out), 
                .InputB(Shift_to_Add), 
                //Output
                .Out(E3_Adder_Out)
            );

Shift_Left Shift(   //Input
                    .Latch_ID_Ex_SignExtendOut(Latch_ID_Ex_SignExtendOut), 
                    //Output
                    .Shift_Left_Out(Shift_to_Add)
                 );

MUX Mux_AluSrc( //Inputs 
                .InputA(MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB), 
                .InputB(Latch_ID_Ex_SignExtendOut),
                .SEL(Ex_FLAGS[ALUScr]), 
                //Output
                .Out(MUX_to_ALU)
                );

ALU_Control E3_ALU_Control( //Inputs     
                            .Ex_FLAGS_ALUOp(Ex_FLAGS[1:0]), 
                            .Func(Latch_ID_Ex_SignExtendOut[5:0]),
                            .ShiftIn(Latch_ID_Ex_SignExtendOut[10:6]), 
                            .InmCtrl(Latch_ID_Ex_InmCtrl),
                            //Output
                            .Shift(Shift_Ctrl_ALU), 
                            .ALU_Control_Out(ALUControl_to_ALU)                                
                          ); 
ALU E3_ALU( //Inputs
            .ALU_DataA(Mux_CortoA_Out_to_ALU_DataA), 
            .ALU_DataB(MUX_to_ALU), 
            .ALU_Control_Out(ALUControl_to_ALU),
            .Shift(Shift_Ctrl_ALU),
            //Outputs
            .ALU_Out(E3_ALUOut), 
            .Zero(E3_ALU_Zero)
            );

MUX #(.LEN(5)) Mux_RegDst(  //Inputs
                            .InputA(Latch_ID_Ex_InstrOut_20_16_Rt), 
                            .InputB(Latch_ID_Ex_InstrOut_15_11_Rd),
                            .SEL(Ex_FLAGS[RegDst]),
                            //Outputs
                            .Out(E3_MuxOut)
                         );
                             
Triple_MUX #(.LEN(32)) Mux_CortoA(   //Inputs
                                    .InputA(Latch_ID_Ex_ReadDataA),
                                    .InputB(Latch_Ex_MEM_ALUOut),           //Wire externo!! (del Latch "EX/MEM")
                                    .InputC(Mux_WB),                        //Wire externo!! (del Mux WB de la Etapa 5 "WB")
                                    .SEL(ForwardA),                         //Wire externo!! (de la Unidad de Cortocircuito)
                                    //Output
                                    .Out(Mux_CortoA_Out_to_ALU_DataA)                                            
                                );

Triple_MUX #(.LEN(32)) Mux_CortoB(   //Inputs
                                    .InputA(Latch_ID_Ex_ReadDataB),
                                    .InputB(Latch_Ex_MEM_ALUOut),               //Wire externo!! (del Latch "EX/MEM")
                                    .InputC(Mux_WB),                            //Wire externo!! (del Mux WB de la Etapa 5 "WB")
                                    .SEL(ForwardB),                             //Wire externo!! (de la Unidad de Cortocircuito)
                                    //Output
                                    .Out(MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB)                                            
                                );

//---------------------------------    Modulos para JUMP   --------------------------------------------------
//Suma (PC+4)+4 para las instrucciones JALR y JAL (TOTAL PC+8)
//Adder #(.LEN(32)) adder_ex( .InputA(Latch_ID_Ex_Adder_Out), 
//                            .InputB(InputB_Adder), 
//                            .Out(E3_AddOut));

//JALR or JAL
//assign JALR_or_JAL_Flag = Ex_FLAGS[JAL] | Ex_FLAGS[JALR];

//Flags 
//assign JR_or_JALR_flag = Ex_FLAGS[JR] | Ex_FLAGS[JALR];
//assign J_or_JAL_flag = Ex_FLAGS[Jmp] | Ex_FLAGS[JAL];

// Si es una instruccion JALR o JAL se deja pasar la direccion de PC+8 para que se grabe en algun registro 
//MUX #(.LEN(32)) Mux_JAL_JALR(  //Inputs
//                            .InputA(E3_ALUOut),//0
//                            .InputB(E3_AddOut),//1 
//                            .SEL(JALR_or_JAL_Flag),
//                            //Outputs
//                            .Out(E3_Mux_JAL_JALR_Out)
//                         );

// Si es una instruccion JAL se elije para grabrar la direccion de retorno en el registro R31 
//MUX #(.LEN(5)) Mux_JAL(     //Inputs
//                            .InputA(E3_MuxOut),//0
//                            .InputB(reg_link),//1 
//                            .SEL(Ex_FLAGS[JAL]),
//                            //Outputs
//                            .Out(E3_Mux_JAL_Out)
//                         );

//Se obtiene el PC actual de la instruccion J o JAL para posteriomente calcular la direccion de salto con instr_index
//assign sub_PC = Latch_ID_Ex_Adder_Out - 4;

// Modulo que se encarga de concatenar los 4 bits mas significativos del PC con los bits del 25 a 0 (instr_index)
// de una instruccion J o JAL y finalmente los ultimos dos bits menos significativos con 0.
// Todo esto forma el PC a donde debe saltar la instruccion
//pc_jump PC_JUMP_EX(  //input
//                     .pc_31_28(Latch_ID_Ex_Adder_Out[31:28]), 
//                     .instr_index(Latch_ID_Ex_InstrOut_25_0_instr_index),
//                     //output
//                     .pc_jmp_jal(pc_jmp_jal) 
//                  );
                  
          
endmodule
