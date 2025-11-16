`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/07 23:21:24
// Design Name: 
// Module Name: decode
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


module decode(
    input  [31:0] instr,
    // 
    output [2:0] funct3,
    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd,
    output [6:0] opcode,
    output [31:0] imm,
    //
    output is_u_instr,
    output is_i_instr,
    output is_s_instr,
    output is_r_instr,
    output is_b_instr,
    output is_j_instr,
    //
    output rs2_valid,
    output imm_valid,
    output rs1_valid,
    output funct3_valid,
    output rd_valid, 
    output wr_en,   
    //
    output is_beq,
    output is_bne,
    output is_blt,
    output is_bge,
    output is_bltu,
    output is_bgeu,
    output is_add,
    output is_addi,
    output is_jal,
    output is_jalr,
    //
    output is_load,
    // 
    logic [4:0] op5,
    logic [10:0] dec_bits
);
        
    assign funct3 = instr[14:12];
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign rd = instr[11:7];
    assign opcode = instr[6:0];
    // in RV32I, instr[1:0] is always 11
    assign op5 = instr[6:2];
    
    // decide type of instr
    assign is_u_instr = (op5 ==? 5'b0x101);
    assign is_i_instr = (op5 ==? 5'b0000x) || (op5 ==? 5'b001x0);
    assign is_s_instr = (op5 ==? 5'b0100x);
    assign is_r_instr = (op5 == 5'b01011) || (op5 ==? 5'b011x0) ||
                        (op5 == 5'b10100);
    assign is_b_instr = (op5 == 5'b11000);
    assign is_j_instr = (op5 == 5'b11011);
    
    // making immediate constant
    assign imm = (is_i_instr) ? {{20{instr[31]}}, instr[31:20]} :
                 (is_s_instr) ? {{20{instr[31]}}, instr[31:25], instr[11:7]} :
                 (is_b_instr) ? {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0} :
                 (is_u_instr) ? {instr[31:12], 12'b0} :
                 (is_j_instr) ? {{11{instr[31]}}, instr[31], instr[19:12], instr[20] ,instr[30:21], 1'b0} :
                                32'b0;
    // check vaild
    assign rs2_valid = (is_r_instr) || (is_s_instr) || (is_b_instr);
    assign imm_valid = (is_u_instr) || (is_s_instr) || (is_b_instr) ||
                       (is_i_instr) || (is_j_instr);
    assign rs1_valid = (is_r_instr) || (is_s_instr) || (is_b_instr) ||
                       (is_i_instr);
    assign funct3_valid = (is_r_instr) || (is_s_instr) || (is_b_instr) ||
                       (is_i_instr); 
    assign rd_valid = (is_r_instr) || (is_u_instr) || (is_j_instr) ||
                       (is_i_instr);  
    assign wr_en = (rd_valid && (rd != 0));
    // decide branch situation
    assign dec_bits = {instr[30], funct3, opcode};
    assign is_beq = (dec_bits ==? 11'bx_000_1100011);
    assign is_bne = (dec_bits ==? 11'bx_001_1100011);
    assign is_blt = (dec_bits ==? 11'bx_100_1100011);
    assign is_bge = (dec_bits ==? 11'bx_101_1100011);
    assign is_bltu = (dec_bits ==? 11'bx_110_1100011);
    assign is_bgeu = (dec_bits ==? 11'bx_111_1100011);
    assign is_addi = (dec_bits ==? 11'bx_000_0010011);
    assign is_add = (dec_bits ==? 11'bx_000_0110011);
    assign is_jal = (dec_bits ==? 11'bx_xxx_1101111);
    assign is_jalr = (dec_bits ==? 11'bx_000_1100111);
    //
    assign is_load = (opcode == 7'b0000011);
endmodule

