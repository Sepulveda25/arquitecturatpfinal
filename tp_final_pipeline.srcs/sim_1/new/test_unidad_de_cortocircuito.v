`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2019 18:09:11
// Design Name: 
// Module Name: test_unidad_de_cortocircuito
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
module test_unidad_de_cortocircuito;

	// Inputs
	reg [4:0] Latch_ID_EX_RS;
    reg [4:0] Latch_ID_EX_RT;
    reg [4:0] Latch_EX_MEM_MUX;
    reg [4:0] Latch_MEM_WB_MUX;
    reg Latch_Ex_MEM_WriteBack_FLAGS_Out;
    reg Latch_MEM_WB_WriteBack_FLAGS_Out;
	// Outputs
	wire [1:0] ForwardA;
    wire [1:0] ForwardB;

	// Instantiate the Unit Under Test (UUT)
	unidad_de_cortocircuito uut (
		.Latch_ID_EX_RS(Latch_ID_EX_RS), 
		.Latch_ID_EX_RT(Latch_ID_EX_RT), 
		.Latch_EX_MEM_MUX(Latch_EX_MEM_MUX),
		.Latch_MEM_WB_MUX(Latch_MEM_WB_MUX),
		.Latch_Ex_MEM_WriteBack_FLAGS_Out(Latch_Ex_MEM_WriteBack_FLAGS_Out),
		.Latch_MEM_WB_WriteBack_FLAGS_Out(Latch_MEM_WB_WriteBack_FLAGS_Out),
		.ForwardA(ForwardA), 
		.ForwardB(ForwardB)
	);

	initial begin
        Latch_ID_EX_RS=5'b00000;
        Latch_ID_EX_RT=5'b00000;
        Latch_EX_MEM_MUX=5'b00000;
        Latch_MEM_WB_MUX=5'b00000;
        Latch_Ex_MEM_WriteBack_FLAGS_Out=0;
        Latch_MEM_WB_WriteBack_FLAGS_Out=0;
        #10;
        Latch_ID_EX_RS=5'b00000;
        Latch_ID_EX_RT=5'b00000;
        Latch_EX_MEM_MUX=5'b00000;
        Latch_MEM_WB_MUX=5'b00000;
        Latch_Ex_MEM_WriteBack_FLAGS_Out=1;
        Latch_MEM_WB_WriteBack_FLAGS_Out=1;
	end
	
	
endmodule   

