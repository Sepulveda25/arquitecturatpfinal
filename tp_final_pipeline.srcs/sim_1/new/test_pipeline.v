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
// El test es la siguiente ejecucion de instrucciones
// ADDI r1, r1, 0x3 ; en etapa WB => Hex: 0x20210003
// ADDI r2, r2, 0x7 ; en etapa MEM => Hex: 0x20420007
// ADD r3, r1, r2 ; en etapa EX => Hex: 0x00221820
// SUB r5,r3,r1; en etapa IF => Hex: 0x00612822
// HALT ; proximo en memoria
//////////////////////////////////////////////////////////////////////////////////


module test_pipeline;

    // Inputs
    reg Clk;
    reg Latch_Reset;
    reg Latch_enable;
    //Etapa IF
    reg Etapa_IF_Reset;
    reg Etapa_IF_PCScr;
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
	//Etapa IF
    wire [31:0] E1_AddOut;
    wire [31:0] E1_InstrOut;
    wire [31:0] PC_Out;
    //Outputs del Latch "IF/ID"
    wire [31:0] Latch_IF_ID_Adder_Out;
    wire [31:0] Latch_IF_ID_InstrOut;
    //Etapa ID
    wire [31:0] E2_ReadDataA;    
    wire [31:0] E2_ReadDataB;
    wire [8:0]  ControlFLAGS;      
    wire [31:0] SignExtendOut;
    wire [2:0]  E2_InmCtrl;
    //Outputs del Latch "ID/EX"
    wire [1:0]   Latch_ID_Ex_WriteBack_FLAGS;
    wire [2:0]   Latch_ID_Ex_Mem_FLAGS;
    wire [3:0]    Latch_ID_Ex_FLAGS;
    wire [31:0]    Latch_ID_Ex_Adder_Out;
    wire [31:0]    Latch_ID_Ex_ReadDataA, Latch_ID_Ex_ReadDataB;
    wire [31:0]    Latch_ID_Ex_SignExtendOut; 
    wire [4:0]    Latch_ID_Ex_InstrOut_25_21_Rs, Latch_ID_Ex_InstrOut_20_16_Rt, Latch_ID_Ex_InstrOut_15_11_Rd;    
    wire [2:0]    Latch_ID_Ex_InmCtrl;
    //Etapa EX
    wire [31:0] E3_Adder_Out;
    wire        E3_ALU_Zero;
    wire [31:0] E3_ALUOut;
    wire [4:0]  E3_MuxOut;
    wire [31:0] MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB;
    //Output del Latch "Ex/MEM"
    wire [2:0]     Latch_Ex_MEM_Mem_FLAGS_Out;
    wire [31:0]    Latch_Ex_MEM_ReadDataB;
    wire [31:0]    Latch_Ex_MEM_E3_Adder_Out;
    wire        Latch_Ex_MEM_Zero;
    wire [1:0]    Latch_Ex_MEM_WriteBack_FLAGS_Out;
    wire [4:0]    Latch_Ex_MEM_Mux;
    wire [31:0]    Latch_Ex_MEM_E3_ALUOut;
    //Etapa MEM
    wire [31:0] E4_DataOut_to_Latch_MEM_WB;
    //Outputs del Latch MEM/WB
    wire [31:0]	Latch_MEM_WB_DataOut;
    wire [31:0] Latch_MEM_WB_ALUOut;
    wire [4:0]  Latch_MEM_WB_Mux;
    wire [1:0]  Latch_MEM_WB_WriteBack_FLAGS_Out;
    //Etapa WB
    wire [31:0] Mux_WB;
    //Outputs de la Unidad de Cortocircuito
    wire [1:0] ForwardA, ForwardB;
    //Outputs de la Unidad de Deteccion de Riesgos
    wire Stall;
    
    // Instantiate the Unit Under Test (UUT)
    pipeline uut (
        //Inputs
        .Clk(Clk), 
        .Latch_Reset(Latch_Reset),
        .Latch_enable(Latch_enable),
        //Etapa IF
        .Etapa_IF_Reset(Etapa_IF_Reset),
        .Etapa_IF_PCScr(Etapa_IF_PCScr),
        .Etapa_IF_enable_pc(Etapa_IF_enable_pc),
        .Etapa_IF_enable_sel(Etapa_IF_enable_sel),
        .Etapa_IF_Instr_in(Etapa_IF_Instr_in),
        .Etapa_IF_enable_mem(Etapa_IF_enable_mem),
        .Etapa_IF_write_enable(Etapa_IF_write_enable),
        .Etapa_IF_Addr_Instr(Etapa_IF_Addr_Instr),
        .Etapa_IF_Addr_Src(Etapa_IF_Addr_Src),
        .Etapa_IF_pc_reset(Etapa_IF_pc_reset),
        //Etapa ID
        .Etapa_ID_Reset(Etapa_ID_Reset),
        .Etapa_ID_posReg(Etapa_ID_posReg), 
        .Etapa_ID_posSel(Etapa_ID_posSel),
         //Etapa MEM 
        .Etapa_MEM_Reset(Etapa_MEM_Reset),
        .dirMem(dirMem),                 
        .memDebug(memDebug),
        //Outputs
        //Etapa IF 
        .E1_AddOut(E1_AddOut),
        .E1_InstrOut(E1_InstrOut),
        .PC_Out(PC_Out),
        //Outputs del Latch "IF/ID"
        .Latch_IF_ID_Adder_Out(Latch_IF_ID_Adder_Out),
        .Latch_IF_ID_InstrOut(Latch_IF_ID_InstrOut),
        //Etapa ID
        .E2_ReadDataA(E2_ReadDataA),    
        .E2_ReadDataB(E2_ReadDataB),
        .ControlFLAGS(ControlFLAGS),      
        .SignExtendOut(SignExtendOut),
        .E2_InmCtrl(E2_InmCtrl),
        //Outputs del Latch "ID/EX"
        .Latch_ID_Ex_WriteBack_FLAGS(Latch_ID_Ex_WriteBack_FLAGS),
        .Latch_ID_Ex_Mem_FLAGS(Latch_ID_Ex_Mem_FLAGS),
        .Latch_ID_Ex_FLAGS(Latch_ID_Ex_FLAGS),
        .Latch_ID_Ex_Adder_Out(Latch_ID_Ex_Adder_Out),
        .Latch_ID_Ex_ReadDataA(Latch_ID_Ex_ReadDataA), 
        .Latch_ID_Ex_ReadDataB(Latch_ID_Ex_ReadDataB),
        .Latch_ID_Ex_SignExtendOut(Latch_ID_Ex_SignExtendOut),
        .Latch_ID_Ex_InstrOut_25_21_Rs(Latch_ID_Ex_InstrOut_25_21_Rs), 
        .Latch_ID_Ex_InstrOut_20_16_Rt(Latch_ID_Ex_InstrOut_20_16_Rt),
        .Latch_ID_Ex_InstrOut_15_11_Rd(Latch_ID_Ex_InstrOut_15_11_Rd),   
        .Latch_ID_Ex_InmCtrl(Latch_ID_Ex_InmCtrl),
        //Etapa EX
        .E3_Adder_Out(E3_Adder_Out),
        .E3_ALU_Zero(E3_ALU_Zero),
        .E3_ALUOut(E3_ALUOut),
        .E3_MuxOut(E3_MuxOut),
        .MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB(MuxCortoB_to_MuxAULScr_Latch_EX_MEM_DataB),
        //Output del Latch "Ex/MEM"
        .Latch_Ex_MEM_Mem_FLAGS_Out(Latch_Ex_MEM_Mem_FLAGS_Out),
        .Latch_Ex_MEM_ReadDataB(Latch_Ex_MEM_ReadDataB),
        .Latch_Ex_MEM_E3_Adder_Out(Latch_Ex_MEM_E3_Adder_Out),
        .Latch_Ex_MEM_Zero(Latch_Ex_MEM_Zero),
        .Latch_Ex_MEM_WriteBack_FLAGS_Out(Latch_Ex_MEM_WriteBack_FLAGS_Out),
        .Latch_Ex_MEM_Mux(Latch_Ex_MEM_Mux),
        .Latch_Ex_MEM_E3_ALUOut(Latch_Ex_MEM_E3_ALUOut),
        //Etapa MEM
        .E4_DataOut_to_Latch_MEM_WB(E4_DataOut_to_Latch_MEM_WB),
        //Outputs del Latch MEM/WB
        .Latch_MEM_WB_DataOut(Latch_MEM_WB_DataOut),
        .Latch_MEM_WB_ALUOut(Latch_MEM_WB_ALUOut),
        .Latch_MEM_WB_Mux(Latch_MEM_WB_Mux),
        .Latch_MEM_WB_WriteBack_FLAGS_Out(Latch_MEM_WB_WriteBack_FLAGS_Out),
        //Etapa WB
        .Mux_WB(Mux_WB),
        //Outputs de la Unidad de Cortocircuito
        .ForwardA(ForwardA), 
        .ForwardB(ForwardB),
        //Output de la Unidad de Deteccion de Riesgos
        .Stall(Stall)
    );
    
    initial begin
        // Initialize Inputs
        Clk = 1;
        // Puesta a punto inicial 
        Latch_Reset = 1; // se reinicia todos los latch
        Latch_enable = 0; // se deshabilita los latch
        //Etapa IF
        Etapa_IF_Reset = 0; // no se reinicia la memoria de programa!! (programa ya cargado en coefile)
        Etapa_IF_PCScr = 0; //POR AHORA NO HAY SALTOS
        Etapa_IF_enable_pc = 0; //program counter deshabilitado
        Etapa_IF_enable_sel = 0; //no esta en modo debug
        Etapa_IF_Instr_in = 32'h00000000; // puede ser x porque no se ingresan instrucciones
        Etapa_IF_enable_mem = 0; // se deshabilita la memoria de Instrucciones 
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
     
        #20;// arranca la ejecucion
        Latch_Reset = 0; //  no se reinicia todos los latch
        Latch_enable = 1; // se habilita los latch
        //Etapa IF
        Etapa_IF_Reset = 0; // no se reinicia la memoria de programa!! (programa ya cargado en coefile)
        Etapa_IF_enable_pc = 1; //program counter habilitado
        Etapa_IF_enable_sel = 0; //no esta en modo debug
        Etapa_IF_Instr_in = 32'h00000000; // puede ser x porque no se ingresan instrucciones
        Etapa_IF_enable_mem = 1; // se habilita la memoria de Instrucciones
        Etapa_IF_write_enable = 4'b0000; // se deja en 0 porque no se van a ingresar instrucciones
        Etapa_IF_Addr_Instr = 32'h00000000; // puede ser x porque no se van a ingresar instrucciones
        Etapa_IF_Addr_Src = 0; //se deja en 0 porque no se van a ingresar instrucciones
        Etapa_IF_pc_reset = 0; // no se renicia el program counter
        //Etapa ID
        Etapa_ID_Reset = 0; // no se reinician todos los registros 
        Etapa_ID_posReg = 5'b0000; // no esta en modo debug
        Etapa_ID_posSel = 0; // no esta en modo debug
        //Etapa MEM
        Etapa_MEM_Reset = 0; // no se reinician los registros
        dirMem = 32'h00000000; // puede ser x porque no se van a leer los registros      
        memDebug = 0; //no esta en modo debug
                    
    end
    
    always begin //clock de la placa 50Mhz
        #10 Clk=~Clk;
    end 
    
endmodule
