`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/09 22:30:15
// Design Name: 
// Module Name: tb_cpu_top
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
module tb_cpu_top;
  logic        clk;
  logic        rst;
  logic [31:0] pc;
  logic [31:0] instr;
  logic [31:0] result;
  logic [31:0] imm;
  logic [4:0] rs1;
  logic [4:0] rs2;
  logic [4:0] rd;
  logic [6:0] opcode;

  cpu_top_not_branch dut (
    .clk   (clk),
    .rst   (rst),
    .pc    (pc),
    .instr (instr)
  );

  // 100 MHz clock - just look easy
  initial begin
    clk = 0;
    forever #(5) clk = ~clk;
  end

  // reset + run for some cycles
  initial begin
    rst = 1;
    repeat (1) @(posedge clk);
    rst = 0;
    repeat (10) @(posedge clk);
    $finish;
  end

  // 매 사이클마다 상태 표시
always @(posedge clk) if (!rst) begin
  $display("%t PC=%h instr=%h | wr_en=%0b rd=%0d is_addi=%0b is_add=%0b | result=%h | x1=%0d x2=%0d x3=%0d",
           $time, pc, instr,
           dut.wr_en, dut.rd, dut.is_addi, dut.is_add,
           dut.result,
           dut.u_register_file_read.regs[1],
           dut.u_register_file_read.regs[2],
           dut.u_register_file_read.regs[3]);
end
endmodule

