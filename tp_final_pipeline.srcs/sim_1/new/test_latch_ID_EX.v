`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2019 17:35:08
// Design Name: 
// Module Name: test_latch_ID_EX
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
module test_Latch_ID_EX;

	// Inputs
    reg Clk;
    reg Reset;
    reg [31:0] Latch_IF_ID_Adder_Out; 
    reg [8:0] ControlFLAGS;
    reg [31:0] ReadDataA; 
    reg [31:0] ReadDataB; 
    reg [31:0] SignExtendOut; 
    reg [4:0] Latch_IF_ID_InstrOut_25_21_Rs;
    reg [4:0] Latch_IF_ID_InstrOut_20_16_Rt;
    reg [4:0] Latch_IF_ID_InstrOut_15_11_Rd; 
    reg [2:0] E2_InmCtrl;
    reg enable;
	// Outputs
    wire [1:0] WriteBack_FLAGS; 
    wire [2:0] Mem_FLAGS; 
    wire [3:0] Ex_FLAGS;
    wire [31:0] Latch_ID_Ex_Adder_Out;
    wire [31:0] Latch_ID_Ex_ReadDataA;
    wire [31:0] Latch_ID_Ex_ReadDataB;
    wire [31:0] Latch_ID_Ex_SignExtendOut; 
    wire [4:0] Latch_ID_Ex_InstrOut_25_21_Rs;
    wire [4:0] Latch_ID_Ex_InstrOut_20_16_Rt;
    wire [4:0] Latch_ID_Ex_InstrOut_15_11_Rd;
    wire [2:0] Latch_ID_Ex_InmCtrl;

	// Instantiate the Unit Under Test (UUT)
	Latch_ID_EX uut (
		.Clk(Clk), 
		.Reset(Reset),
		.Latch_IF_ID_Adder_Out(Latch_IF_ID_Adder_Out), 
        .ControlFLAGS(ControlFLAGS),
        .ReadDataA(ReadDataA), 
        .ReadDataB(ReadDataB), 
        .SignExtendOut(SignExtendOut), 
        .Latch_IF_ID_InstrOut_25_21_Rs(Latch_IF_ID_InstrOut_25_21_Rs),
        .Latch_IF_ID_InstrOut_20_16_Rt(Latch_IF_ID_InstrOut_20_16_Rt),
        .Latch_IF_ID_InstrOut_15_11_Rd(Latch_IF_ID_InstrOut_15_11_Rd), 
        .E2_InmCtrl(E2_InmCtrl),
        .enable(enable),
        .WriteBack_FLAGS(WriteBack_FLAGS), 
        .Mem_FLAGS(Mem_FLAGS), 
        .Ex_FLAGS(Ex_FLAGS),
        .Latch_ID_Ex_Adder_Out(Latch_ID_Ex_Adder_Out),
        .Latch_ID_Ex_ReadDataA(Latch_ID_Ex_ReadDataA),
        .Latch_ID_Ex_ReadDataB(Latch_ID_Ex_ReadDataB),
        .Latch_ID_Ex_SignExtendOut(Latch_ID_Ex_SignExtendOut), 
        .Latch_ID_Ex_InstrOut_25_21_Rs(Latch_ID_Ex_InstrOut_25_21_Rs),
        .Latch_ID_Ex_InstrOut_20_16_Rt(Latch_ID_Ex_InstrOut_20_16_Rt),
        .Latch_ID_Ex_InstrOut_15_11_Rd(Latch_ID_Ex_InstrOut_15_11_Rd),
        .Latch_ID_Ex_InmCtrl(Latch_ID_Ex_InmCtrl)
		
	);

   
	initial begin
		// Initialize Inputs
		Clk = 1;
		Reset=1;
		// add r1 r2 r3
		Latch_IF_ID_Adder_Out=32'h00000000; 
        ControlFLAGS=9'b000000000;
        ReadDataA=32'h00000000; 
        ReadDataB=32'h00000000; 
        SignExtendOut=32'h00000000; 
        Latch_IF_ID_InstrOut_25_21_Rs=5'b00000;
        Latch_IF_ID_InstrOut_20_16_Rt=5'b00000;
        Latch_IF_ID_InstrOut_15_11_Rd=5'b00000; 
        E2_InmCtrl=3'b000;
        enable=0;
		
	end
	
   always begin //clock de la placa 50Mhz
		#10 Clk=~Clk;
	end      
   
endmodule
