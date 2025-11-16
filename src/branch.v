`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 23:12:59
// Design Name: 
// Module Name: branch
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


module branch(
    input [31:0] pc,
    input [31:0] src1_value,
    input [31:0] src2_value,
    input [31:0] imm,
    input is_beq,
    input is_bne,
    input is_blt,
    input is_bge,
    input is_bltu,
    input is_bgeu,
    input is_jal,
    input is_jalr,
    output taken_br,
    output [31:0] jalr_tgt_pc,
    output [31:0] br_tgt_pc    
);
    assign taken_br = 
               ((src1_value == src2_value) && is_beq) || 
               ((src1_value != src2_value) && is_bne) || 
               (((src1_value < src2_value) ^ (src1_value[31] != src2_value[31])) && is_blt) || 
               (((src1_value >= src2_value) ^ (src1_value[31] != src2_value[31])) && is_bge) || 
               ((src1_value < src2_value) && is_bltu) || 
               ((src1_value >= src2_value) && is_bgeu);
               
    assign br_tgt_pc = pc + imm; 
    assign jalr_tgt_pc[31:0] = src1_value + imm;
endmodule
