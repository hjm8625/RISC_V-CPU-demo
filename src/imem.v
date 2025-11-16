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
        mem[0] = 32'h00100093; // ADDI x1,x0,1
        mem[1] = 32'h00500113; // ADDI x2,x0,5
        mem[2] = 32'h00208663; // BEQ x1,x2,8
        mem[3] = 32'h00108093; // ADDI x1,x1,1
        mem[4] = 32'hFF9FF06F; // JAL x0,-8
        mem[5] = 32'h00102223; // SW x1,x4
        mem[6] = 32'h00402203; // LW x4,x1
    end    
    // PC : byte -> real index : pc/4
    assign instr = mem[addr[9:2]];
    
    // 
endmodule
