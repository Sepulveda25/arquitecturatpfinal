`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2019 21:55:59
// Design Name: 
// Module Name: Sign_Extend
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


module Sign_Extend(input [15:0] Latch_IF_ID_InstrOut, 
                   output [31:0] SignExtendOut
                    );
//Variable auxiliar con signo
reg signed [31:0] aux;

always@* begin
    aux[31:16] = Latch_IF_ID_InstrOut; 
end

//shiftea 16 manteniendo signo
assign SignExtendOut = aux >>> 16; 

endmodule
