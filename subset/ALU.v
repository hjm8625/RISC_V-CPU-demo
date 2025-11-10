`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 00:59:12
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] src1_value,
    input [31:0] src2_value,
    input [31:0] imm, 
    input is_addi,
    input is_add,
    input is_load,
    input is_s_instr,
    output [31:0] result
    );
    
    assign result = 
            (is_addi) ? (src1_value + imm) :
            (is_add) ? (src1_value + src2_value) :
            (is_load) ? (src1_value + imm) :
            (is_s_instr) ? (src1_value + imm) :
                            32'b0;
            
            
endmodule
