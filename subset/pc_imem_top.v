`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 12:33:06
// Design Name: 
// Module Name: pc_imem_top
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


module pc_imem_top(
    input clk,
    input rst,
    output [31:0] pc,
    output [31:0] instr
    );
    
    pc u_pc (
        .clk (clk),
        .rst (rst),
        .taken_br (1'b0),
        .br_tgt_pc (32'b0),
        .pc (pc)
        );
    
    imem u_imem (
        .addr (pc),
        .instr (instr)
        );
endmodule
