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


module pipeline(    //Inputs
                    input Clk,
                    input Latch_Reset,
                    input Latch_enable,
                    //Etapa IF
                    input Etapa_IF_Reset,
                    input Etapa_IF_enable_pc,
                    input Etapa_IF_enable_sel,
                    input [31:0] Etapa_IF_Instr_in,
                    input Etapa_IF_enable_mem,
                    input [3:0] Etapa_IF_write_enable,
                    input [31:0] Etapa_IF_Addr_Instr,
                    input Etapa_IF_Addr_Src,
                    input Etapa_IF_pc_reset,
                    //Etapa ID
                    input Etapa_ID_Reset,
                    input [4:0] Etapa_ID_posReg, // address para leer registros en modo debug
                    input Etapa_ID_posSel, // selecion de address para Register
                    //Etapa MEM
                    input Etapa_MEM_Reset,
                    input [31:0] dirMem, 			    //Addr a Mux, luego a DataMem
                    input memDebug,                //Selector de los 3 Mux
                    //Outputs
                    //Etapa IF
                    output [31:0] E1_AddOut,
                    output [31:0] E1_InstrOut,
                    output [31:0] PC_Out,
                    //Outputs del Latch "IF/ID"
                    output [31:0] Latch_IF_ID_Adder_Out,
                    output [31:0] Latch_IF_ID_InstrOut,
                    //Etapa ID
                    output [31:0] E2_ReadDataA,	
                    output [31:0] E2_ReadDataB,
                    output [8:0]  ControlFLAGS,      
                    output [31:0] SignExtendOut,
                    output [2:0]  E2_InmCtrl,
                    //Outputs del Latch "ID/EX"
                    output [1:0]     Latch_ID_Ex_WriteBack_FLAGS,
                    output [2:0]     Latch_ID_Ex_Mem_FLAGS,
                    output [3:0]    Latch_ID_Ex_FLAGS,
                    output [31:0]    Latch_ID_Ex_Adder_Out,
                    output [31:0]    Latch_ID_Ex_ReadDataA, Latch_ID_Ex_ReadDataB,
                    output [31:0]    Latch_ID_Ex_SignExtendOut,
                    output [4:0]    Latch_ID_Ex_InstrOut_25_21_Rs, Latch_ID_Ex_InstrOut_20_16_Rt, Latch_ID_Ex_InstrOut_15_11_Rd,   
                    output [2:0]    Latch_ID_Ex_InmCtrl,
                    //Etapa EX
                    output [31:0] E3_Adder_Out,
                    output        E3_ALU_Zero,
                    output [31:0] E3_ALUOut,
                    output [4:0]  E3_MuxOut,
                    output [31:0] MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB,
                    //Output del Latch "Ex/MEM"
                    output [2:0]     Latch_Ex_MEM_Mem_FLAGS_Out,
                    output [31:0]    Latch_Ex_MEM_ReadDataB,
                    output [31:0]    Latch_Ex_MEM_E3_Adder_Out,
                    output        Latch_Ex_MEM_Zero,
                    output [1:0]    Latch_Ex_MEM_WriteBack_FLAGS_Out,
                    output [4:0]    Latch_Ex_MEM_Mux,
                    output [31:0]    Latch_Ex_MEM_E3_ALUOut,
                    //Etapa MEM
                    output [31:0] E4_DataOut_to_Latch_MEM_WB,
                    output        PCScr,
                    //Outputs del Latch MEM/WB
                    output [31:0]    Latch_MEM_WB_DataOut,
                    output [31:0]    Latch_MEM_WB_ALUOut,
                    output [4:0]    Latch_MEM_WB_Mux,
                    output [1:0]    Latch_MEM_WB_WriteBack_FLAGS_Out,
                    //Etapa WB
                    output [31:0] Mux_WB,
                    //Outputs de la Unidad de Cortocircuito
                    output [1:0] ForwardA, ForwardB,
                    //Output de la Unidad de Deteccion de Riesgos
                    output Stall
                    
    );

//-------------------------------    Variables    -----------------------------------------------------------------------
localparam MemtoReg		= 0;
localparam RegWrite		= 1;
localparam MemRead 		= 2;
    
//-----------------------     Cables de Interconexion     ---------------------------------------------------------------
    
// Outputs de Etapa 1, y entran en los inputs del Latch "IF/ID"
//wire [31:0] E1_AddOut;
//wire [31:0] E1_InstrOut;
//wire [31:0] PC_Out;
//Outputs del Latch "IF/ID"
//wire [31:0] Latch_IF_ID_Adder_Out;
//wire [31:0] Latch_IF_ID_InstrOut;
//-----------------------------------------------------------------

//Outputs de Etapa 2, y entran en los inputs del Latch "ID/Ex"
//wire [31:0] E2_ReadDataA;	
//wire [31:0] E2_ReadDataB;
//wire [8:0] 	ControlFLAGS;	  
//wire [31:0] SignExtendOut;  
//wire [2:0] 	E2_InmCtrl;
////Outputs del Latch "ID/EX"
//wire [1:0] 	Latch_ID_Ex_WriteBack_FLAGS;
//wire [2:0] 	Latch_ID_Ex_Mem_FLAGS;
//wire [3:0]	Latch_ID_Ex_FLAGS;
//wire [31:0]	Latch_ID_Ex_Adder_Out;
//wire [31:0]	Latch_ID_Ex_ReadDataA, Latch_ID_Ex_ReadDataB;
//wire [31:0]	Latch_ID_Ex_SignExtendOut; 
//wire [4:0]	Latch_ID_Ex_InstrOut_25_21_Rs, Latch_ID_Ex_InstrOut_20_16_Rt, Latch_ID_Ex_InstrOut_15_11_Rd;	
//wire [2:0]	Latch_ID_Ex_InmCtrl;
//-----------------------------------------------------------------

//Output de Etapa 3, y que entran en los inputs del Latch "Ex/MEM"
//wire [31:0]	E3_Adder_Out;
//wire 		E3_ALU_Zero;
//wire [31:0]	E3_ALUOut;
//wire [4:0]	E3_MuxOut;
//wire [31:0] MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB;
//Output del Latch "Ex/MEM"
//wire [2:0] 	Latch_Ex_MEM_Mem_FLAGS_Out;
//wire [31:0]	Latch_Ex_MEM_ReadDataB;
//wire [31:0]	Latch_Ex_MEM_E3_Adder_Out;
//wire        Latch_Ex_MEM_Zero;
//wire [1:0]	Latch_Ex_MEM_WriteBack_FLAGS_Out;
//wire [4:0]	Latch_Ex_MEM_Mux;
//wire [31:0]	Latch_Ex_MEM_E3_ALUOut;
//-----------------------------------------------------------------
 
//Outputs de Etapa 4, y que entran en los inputs del Latch "MEM/WB"
//wire [31:0]	E4_DataOut_to_Latch_MEM_WB;
//wire 			PCScr;
//Outputs del Latch MEM/WB
//wire [31:0]	Latch_MEM_WB_DataOut;
//wire [31:0]	Latch_MEM_WB_ALUOut;
//wire [4:0]	Latch_MEM_WB_Mux;
//wire [1:0]	Latch_MEM_WB_WriteBack_FLAGS_Out;
//-----------------------------------------------------------------

//Output de la Etapa 5 "WB"
//wire [31:0] Mux_WB;
//-----------------------------------------------------------------

//Outputs de la Unidad de Cortocircuito
//wire [1:0] ForwardA, ForwardB;
//-----------------------------------------------------------------

//Output de la Unidad de Deteccion de Riesgos
//wire Stall;
//-----------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//---------------------------------   	Etapa 1 "IF" + Latch IF/ID   --------------------------------------------------

Etapa1_IF E1_IF(	//Inputs 13
                    .Clk(Clk), 
                    .Reset(Etapa_IF_Reset), 
                    .InputB_MUX(Latch_Ex_MEM_E3_Adder_Out), 
                    .PCScr(PCScr), 
                    .Stall(Stall),
                    .enable_pc(Etapa_IF_enable_pc),
                    .enable_sel(Etapa_IF_enable_sel),
                    .Instr_in(Etapa_IF_Instr_in),
                    .enable_mem(Etapa_IF_enable_mem),
                    .write_enable(Etapa_IF_write_enable),
                    .Addr_Instr(Etapa_IF_Addr_Instr),
                    .Addr_Src(Etapa_IF_Addr_Src),
                    .pc_reset(Etapa_IF_pc_reset),
                    //Outputs 3
					.E1_AddOut(E1_AddOut), 
					.E1_InstrOut(E1_InstrOut), 
					.PC_Out(PC_Out)
					);	

Latch_IF_ID IF_ID(	.Clk(Clk), 
                    .Reset(Latch_Reset), 
                    .Adder_Out(E1_AddOut), 
                    .Instruction_In(E1_InstrOut), 
                    .Stall(Stall),
					.enable(Latch_enable), 
					.Latch_IF_ID_Adder_Out(Latch_IF_ID_Adder_Out), 
					.Latch_IF_ID_InstrOut(Latch_IF_ID_InstrOut)
                    );
                    
//---------------------------------    Etapa 2 "ID" + Latch ID/Ex	  --------------------------------------------------
                    
Etapa2_ID E2_ID(    //Inputs 9
                    .Clk(Clk), 
                    .Reset(Etapa_ID_Reset), 
                    .Stall(Stall),
                    .Latch_IF_ID_InstrOut(Latch_IF_ID_InstrOut),
                    .posReg(Etapa_ID_posReg), 
                    .posSel(Etapa_ID_posSel),
                    .Latch_MEM_WB_Mux(Latch_MEM_WB_Mux), 
                    .Mux_WB(Mux_WB), 
                    .Latch_MEM_WB_RegWrite(Latch_MEM_WB_WriteBack_FLAGS_Out[RegWrite]),
                    //Outputs 5
                    .E2_ReadDataA(E2_ReadDataA), 
                    .E2_ReadDataB(E2_ReadDataB),
                    .Mux_ControlFLAGS_Out(ControlFLAGS), 
                    .SignExtendOut(SignExtendOut),
                    .E2_InmCtrl(E2_InmCtrl)
                );

Latch_ID_EX ID_EX(  //Inputs 12
                    .Clk(Clk), 
                    .Reset(Latch_Reset), 
                    .Latch_IF_ID_Adder_Out(Latch_IF_ID_Adder_Out), 
                    .ControlFLAGS(ControlFLAGS), 
                    .ReadDataA(E2_ReadDataA), 
                    .ReadDataB(E2_ReadDataB), 
                    .SignExtendOut(SignExtendOut),
                    .Latch_IF_ID_InstrOut_25_21_Rs(Latch_IF_ID_InstrOut[25:21]), 
                    .Latch_IF_ID_InstrOut_20_16_Rt(Latch_IF_ID_InstrOut[20:16]), 
                    .Latch_IF_ID_InstrOut_15_11_Rd(Latch_IF_ID_InstrOut[15:11]), 
                    .E2_InmCtrl(E2_InmCtrl),
                    .enable(Latch_enable),
                    //Outputs 11
                    .WriteBack_FLAGS(Latch_ID_Ex_WriteBack_FLAGS), 
                    .Mem_FLAGS(Latch_ID_Ex_Mem_FLAGS), 
                    .Ex_FLAGS(Latch_ID_Ex_FLAGS), 
                    .Latch_ID_Ex_Adder_Out(Latch_ID_Ex_Adder_Out), 
                    .Latch_ID_Ex_ReadDataA(Latch_ID_Ex_ReadDataA), 
                    .Latch_ID_Ex_ReadDataB(Latch_ID_Ex_ReadDataB), 
                    .Latch_ID_Ex_SignExtendOut(Latch_ID_Ex_SignExtendOut),
                    .Latch_ID_Ex_InstrOut_25_21_Rs(Latch_ID_Ex_InstrOut_25_21_Rs),    //Rs
                    .Latch_ID_Ex_InstrOut_20_16_Rt(Latch_ID_Ex_InstrOut_20_16_Rt), //Rt
                    .Latch_ID_Ex_InstrOut_15_11_Rd(Latch_ID_Ex_InstrOut_15_11_Rd),    //Rd
                    .Latch_ID_Ex_InmCtrl(Latch_ID_Ex_InmCtrl)
                    );  
                    
//---------------------------------  Etapa 3 "EX" + Latch EX/MEM    --------------------------------------------------
                      
Etapa3_EX E3_EX(    //Inputs 12
                    .Ex_FLAGS(Latch_ID_Ex_FLAGS),
                    .Latch_ID_Ex_Adder_Out(Latch_ID_Ex_Adder_Out),
                    .Latch_ID_Ex_ReadDataA(Latch_ID_Ex_ReadDataA),
                    .Latch_ID_Ex_ReadDataB(Latch_ID_Ex_ReadDataB),
                    .Latch_ID_Ex_SignExtendOut(Latch_ID_Ex_SignExtendOut), 
                    .Latch_ID_Ex_InstrOut_20_16_Rt(Latch_ID_Ex_InstrOut_20_16_Rt),
                    .Latch_ID_Ex_InstrOut_15_11_Rd(Latch_ID_Ex_InstrOut_15_11_Rd),
                    .Latch_ID_Ex_InmCtrl(Latch_ID_Ex_InmCtrl),
                    .Latch_Ex_MEM_ALUOut(Latch_Ex_MEM_E3_ALUOut),
                    .Mux_WB(Mux_WB),
                    .ForwardA(ForwardA),
                    .ForwardB(ForwardB),
                    //Outputs 5
                    .E3_Adder_Out(E3_Adder_Out), 
                    .E3_ALUOut(E3_ALUOut), 
                    .E3_ALU_Zero(E3_ALU_Zero),    
                    .E3_MuxOut(E3_MuxOut), 
                    .MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB(MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB)
                );
                    

Latch_EX_MEM EX_MEM(    //Inputs 10
                        .Clk(Clk), 
                        .Reset(Latch_Reset),
                        .WriteBack_FLAGS_In(Latch_ID_Ex_WriteBack_FLAGS),
                        .Mem_FLAGS_In(Latch_ID_Ex_Mem_FLAGS),
                        .E3_Adder_Out(E3_Adder_Out), 
                        .E3_ALU_Zero(E3_ALU_Zero), 
                        .E3_ALUOut(E3_ALUOut),
                        .Latch_ID_Ex_ReadDataB(MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB),
                        .E3_MuxOut(E3_MuxOut),
                        .enable(Latch_enable),
                        //Outputs 7
                        .WriteBack_FLAGS_Out(Latch_Ex_MEM_WriteBack_FLAGS_Out),
                        .Mem_FLAGS_Out(Latch_Ex_MEM_Mem_FLAGS_Out),
                        .Latch_Ex_MEM_E3_Adder_Out(Latch_Ex_MEM_E3_Adder_Out),
                        .Latch_Ex_MEM_Zero(Latch_Ex_MEM_Zero),
                        .Latch_Ex_MEM_ALUOut(Latch_Ex_MEM_E3_ALUOut), //Addr a DataMem 
                        .Latch_Ex_MEM_ReadDataB(Latch_Ex_MEM_ReadDataB), //DataIn a DataMem
                        .Latch_Ex_MEM_Mux(Latch_Ex_MEM_Mux)
                     );
                     
//---------------------------------    Etapa 4 "MEM" + Latch MEM/WB    -----------------------------------------------
                     
Etapa4_MEM E4_MEM(   //Inputs
                     .Clk(Clk), 
                     .Reset(Etapa_MEM_Reset), 
                     .Latch_Ex_MEM_Zero(Latch_Ex_MEM_Zero),
                     .Mem_FLAGS(Latch_Ex_MEM_Mem_FLAGS_Out),
                     .Latch_Ex_MEM_ALUOut(Latch_Ex_MEM_E3_ALUOut),
                     .dirMem(dirMem), 
                     .memDebug(memDebug),
                     .Latch_Ex_MEM_ReadDataB(Latch_Ex_MEM_ReadDataB),
                     //Outputs
                     .E4_DataOut(E4_DataOut_to_Latch_MEM_WB),
                     .PCScr(PCScr)        
                 );
                         
 Latch_MEM_WB MEM_WB(    //Inputs
                         .Clk(Clk), 
                         .Reset(Latch_Reset),
                         .WriteBack_FLAGS_In(Latch_Ex_MEM_WriteBack_FLAGS_Out), 
                         .E4_DataOut(E4_DataOut_to_Latch_MEM_WB),
                         .Latch_Ex_MEM_ALUOut(Latch_Ex_MEM_E3_ALUOut),
                         .Latch_Ex_MEM_Mux(Latch_Ex_MEM_Mux),
                         .enable(Latch_enable),
                         //Outputs
                         .Latch_MEM_WB_DataOut(Latch_MEM_WB_DataOut),
                         .Latch_MEM_WB_ALUOut(Latch_MEM_WB_ALUOut),
                         .Latch_MEM_WB_Mux(Latch_MEM_WB_Mux),
                         .WriteBack_FLAGS_Out(Latch_MEM_WB_WriteBack_FLAGS_Out)
                      );                    

//--------------------------------    Etapa 5 "WB"    ----------------------------------------------------------------

MUX #(.LEN(32)) E5_WB(	//Inputs
                        .InputA(Latch_MEM_WB_ALUOut), 
                        .InputB(Latch_MEM_WB_DataOut), 
                        .SEL(Latch_MEM_WB_WriteBack_FLAGS_Out[MemtoReg]), 
                        //Output
                        .Out(Mux_WB)
                     );

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------------        Unidad de CortoCircuito       ------------------------------------------------------
unidad_de_cortocircuito UnidadCorto(//Inputs
                                    .Latch_ID_EX_RS(Latch_ID_Ex_InstrOut_25_21_Rs),
                                    .Latch_ID_EX_RT(Latch_ID_Ex_InstrOut_20_16_Rt),
                                    .Latch_EX_MEM_MUX(Latch_Ex_MEM_Mux),
                                    .Latch_MEM_WB_MUX(Latch_MEM_WB_Mux),
                                    .Latch_Ex_MEM_WriteBack_FLAGS_Out(Latch_Ex_MEM_WriteBack_FLAGS_Out[RegWrite]),
                                    .Latch_MEM_WB_WriteBack_FLAGS_Out(Latch_MEM_WB_WriteBack_FLAGS_Out[RegWrite]),
                                    //Outputs
                                    .ForwardA(ForwardA),
                                    .ForwardB(ForwardB)
                                    );
												
//----------------------       Unidad de Deteccion de Riesgos     -----------------------------------------------------
unidad_de_deteccion_de_riesgos UnidadRiesgos(	//Inputs
                                                .Latch_ID_Ex_Mem_FLAGS_MemRead(Latch_ID_Ex_Mem_FLAGS[MemRead]),
                                                .Latch_ID_Ex_InstrOut_20_16_Rt(Latch_ID_Ex_InstrOut_20_16_Rt),
                                                .Latch_IF_ID_RS(Latch_IF_ID_InstrOut[25:21]),
                                                .Latch_IF_ID_RT(Latch_IF_ID_InstrOut[20:16]),
                                                //Output
                                                .Stall(Stall)
                                             );
	                                          

endmodule