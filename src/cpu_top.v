`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 22:09:45
// Design Name: 
// Module Name: cpu_top_not_branch
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

module cpu_top (
    input  logic clk,
    input  logic rst,
    output logic [31:0] pc,
    output logic [31:0] instr
);
    // pc
    logic taken_br;
    logic is_jal;
    logic is_jalr;
    logic [31:0] br_tgt_pc;

    pc u_pc (
        .clk (clk),
        .rst (rst),
        .taken_br (taken_br),
        .is_jal (is_jal),
        .is_jalr (is_jalr),
        .br_tgt_pc (br_tgt_pc),
        .pc (pc)
    );
    // imm
    imem u_imem (
        .addr (pc),
        .instr (instr)
    );

    // decode
    logic [2:0] funct3;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;                
    logic [6:0] opcode;            
    logic [31:0] imm;

    logic is_u_instr, is_i_instr, is_s_instr, is_r_instr, is_b_instr, is_j_instr; // ★ is_s_instr 포함
    logic rs2_valid, imm_valid, rs1_valid, funct3_valid, rd_valid, wr_en;
    logic is_beq, is_bne, is_blt, is_bge, is_bltu, is_bgeu; // not yet
    logic is_add, is_addi;
    logic is_load;

    decode u_decode (
        .instr (instr),
        .funct3 (funct3),
        .rs1 (rs1),
        .rs2 (rs2),
        .rd (rd),
        .opcode (opcode),
        .imm (imm),
        .is_u_instr (is_u_instr),
        .is_i_instr (is_i_instr),
        .is_s_instr (is_s_instr),
        .is_r_instr (is_r_instr),
        .is_b_instr (is_b_instr),
        .is_j_instr (is_j_instr),
        .rs2_valid (rs2_valid),
        .imm_valid (imm_valid),
        .rs1_valid (rs1_valid),
        .funct3_valid (funct3_valid),
        .rd_valid (rd_valid),
        .wr_en (wr_en),
        .is_beq (is_beq),
        .is_bne (is_bne),
        .is_blt (is_blt),
        .is_bge (is_bge),
        .is_bltu (is_bltu),
        .is_bgeu (is_bgeu),
        .is_add (is_add),
        .is_addi (is_addi),
        .is_jal (is_jal),
        .is_jalr (is_jalr),
        .is_load (is_load)
    );

    // rf
    logic [31:0] src1_value, src2_value;
    logic [31:0] ld_data  = 32'b0;
    logic [31:0] result;                

    register_file_read #(
        .width (32),
        .numregs (32)
    ) u_register_file_read (
        .clk (clk),
        .reset (rst),
        .wr_en (wr_en),
        .rd (rd),
        .result (result),           
        .ld_data (ld_data),
        .is_load (is_load),
        .rs1_valid (rs1_valid),
        .rs1 (rs1),
        .src1_value (src1_value),
        .rs2_valid (rs2_valid),
        .rs2 (rs2),
        .src2_value (src2_value)
    );

    // -ALU
    ALU u_ALU (
        .src1_value (src1_value),
        .src2_value (src2_value),
        .imm (imm),
        .is_addi (is_addi),
        .is_add (is_add),
        .is_load (is_load),
        .is_s_instr (is_s_instr),
        .result (result)
    );

    // branch
    branch u_branch (
        .pc (pc),
        .src1_value (src1_value),
        .src2_value (src2_value),
        .imm (imm),
        .is_beq (is_beq),
        .is_bne (is_bne),
        .is_blt (is_blt),
        .is_bge (is_bge),
        .is_bltu (is_bltu),
        .is_bgeu (is_bgeu),
        .is_jal (is_jal),
        .is_jalr (is_jalr),
        .taken_br (taken_br),
        .br_tgt_pc (br_tgt_pc)
    );
    
    //dmem
    dmem #(
        .width(32),
        .length(256)
    ) u_dmem (
        .clk (clk),
        .reset (rst),
        .addr (result),
        .is_s_instr (is_s_instr),
        .is_load (is_load),
        .src2_value (src2_value),
        .ld_data (ld_data)
    );

endmodule

