`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2019 22:22:17
// Design Name: 
// Module Name: test_pipeline
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


module test_pipeline;

    // Inputs
    reg Clk;
    reg Latch_Reset;
    reg Latch_enable;
    //Etapa IF
    reg Etapa_IF_Reset;
    reg Etapa_IF_enable_pc;
    reg Etapa_IF_enable_sel;
    reg [31:0] Etapa_IF_Instr_in;
    reg Etapa_IF_enable_mem;
    reg [3:0] Etapa_IF_write_enable;
    reg [31:0] Etapa_IF_Addr_Instr;
    reg Etapa_IF_Addr_Src;
    reg Etapa_IF_pc_reset;
    //Etapa ID
    reg Etapa_ID_Reset;
    reg [4:0] Etapa_ID_posReg; // address para leer registros en modo debug
    reg Etapa_ID_posSel; // selecion de address para Register
    //Etapa MEM
    reg Etapa_MEM_Reset;
    reg [31:0] dirMem;                 //Addr a Mux; luego a DataMem
    reg memDebug;
	// Outputs
    wire [31:0] E1_AddOut;
    wire [31:0] E1_InstrOut;
    wire [31:0] PC_Out;
    //Etapa ID
    wire [31:0] E2_ReadDataA;    
    wire [31:0] E2_ReadDataB;
    wire [8:0]  ControlFLAGS;      
    wire [31:0] SignExtendOut;
    wire [2:0]  E2_InmCtrl;
    //Etapa EX
    wire [31:0] E3_Adder_Out;
    wire        E3_ALU_Zero;
    wire [31:0] E3_ALUOut;
    wire [4:0]  E3_MuxOut;
    wire [31:0] MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB;
    //Etapa MEM
    wire [31:0] E4_DataOut_to_Latch_MEM_WB;
    wire        PCScr;
    //Etapa WB
    wire [31:0] Mux_WB;
    //Outputs de la Unidad de Cortocircuito
    wire [1:0] ForwardA, ForwardB;
    //Outputs de la Unidad de Deteccion de Riesgos
    wire Stall;
    
    // Instantiate the Unit Under Test (UUT)
    pipeline uut (
        .Clk(Clk), 
        .Latch_Reset(Latch_Reset),
        .Latch_enable(Latch_enable),
        .Etapa_IF_Reset(Etapa_IF_Reset),
        .Etapa_IF_enable_pc(Etapa_IF_enable_pc),
        .Etapa_IF_enable_sel(Etapa_IF_enable_sel),
        .Etapa_IF_Instr_in(Etapa_IF_Instr_in),
        .Etapa_IF_enable_mem(Etapa_IF_enable_mem),
        .Etapa_IF_write_enable(Etapa_IF_write_enable),
        .Etapa_IF_Addr_Instr(Etapa_IF_Addr_Instr),
        .Etapa_IF_Addr_Src(Etapa_IF_Addr_Src),
        .Etapa_IF_pc_reset(Etapa_IF_pc_reset),
        .Etapa_ID_Reset(Etapa_ID_Reset),
        .Etapa_ID_posReg(Etapa_ID_posReg), 
        .Etapa_ID_posSel(Etapa_ID_posSel), 
        .Etapa_MEM_Reset(Etapa_MEM_Reset),
        .dirMem(dirMem),                 
        .memDebug(memDebug), 
        .E1_AddOut(E1_AddOut),
        .E1_InstrOut(E1_InstrOut),
        .PC_Out(PC_Out),
        .E2_ReadDataA(E2_ReadDataA),    
        .E2_ReadDataB(E2_ReadDataB),
        .ControlFLAGS(ControlFLAGS),      
        .SignExtendOut(SignExtendOut),
        .E2_InmCtrl(E2_InmCtrl),
        .E3_Adder_Out(E3_Adder_Out),
        .E3_ALU_Zero(E3_ALU_Zero),
        .E3_ALUOut(E3_ALUOut),
        .E3_MuxOut(E3_MuxOut),
        .MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB(MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB),
        .E4_DataOut_to_Latch_MEM_WB(E4_DataOut_to_Latch_MEM_WB),
        .PCScr(PCScr),
        .Mux_WB(Mux_WB),
        .ForwardA(ForwardA), 
        .ForwardB(ForwardB),
        .Stall(Stall)
    );
    
    initial begin
        // Initialize Inputs
        Clk = 1;
        Latch_Reset = 1; // se reinicia todos los latch
        Latch_enable = 0; // se deshabilita los latch
        //Etapa IF
        Etapa_IF_Reset = 0; // no se reinicia la memoria de programa!! (programa ya cargado en coefile)
        Etapa_IF_enable_pc = 0; //program counter deshabilitado
        Etapa_IF_enable_sel = 0; //no esta en modo debug
        Etapa_IF_Instr_in = 32'h00000000; // puede ser x porque no se ingresan instrucciones
        Etapa_IF_enable_mem = 0; // puede ser x porque no esta en modo debug
        Etapa_IF_write_enable = 4'b0000; // se deja en 0 porque no se van a ingresar instrucciones
        Etapa_IF_Addr_Instr = 32'h00000000; // puede ser x porque no se van a ingresar instrucciones
        Etapa_IF_Addr_Src = 0; //se deja en 0 porque no se van a ingresar instrucciones
        Etapa_IF_pc_reset = 1; // se renicia el program counter
        //Etapa ID
        Etapa_ID_Reset = 1; // se reinician todos los registros 
        Etapa_ID_posReg = 5'b0000; // no esta en modo debug
        Etapa_ID_posSel = 0; // no esta en modo debug
        //Etapa MEM
        Etapa_MEM_Reset = 1; // se reinician los registros
        dirMem = 32'h00000000; // puede ser x porque no se van a leer los registros      
        memDebug = 0; //no esta en modo debug
                    
    end
    
    always begin //clock de la placa 50Mhz
        #10 Clk=~Clk;
    end 
    
endmodule
