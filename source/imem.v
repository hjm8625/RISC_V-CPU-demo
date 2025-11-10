`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/07 22:51:58
// Design Name: 
// Module Name: imem
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


module imem( // ROM module
    input [31:0] addr,
    output [31:0] instr
);
    reg [31:0] mem [0:255]; // 256-word ROM
    // program
    initial begin
        mem[0] = 32'h00100093; // ADDI x1, x0 ,1
        mem[1] = 32'h00300113; // ADDI x2, x0, 3
        mem[2] = 32'h002081b3; // ADD x3, x1, x2
    end    
    // PC : byte -> real index : pc/4
    assign instr = mem[addr[9:2]];
    
    // 
endmodule
