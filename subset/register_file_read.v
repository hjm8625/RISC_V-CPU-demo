`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/08 22:12:52
// Design Name: 
// Module Name: register_file_read
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


module register_file_read #(
    parameter int width   = 32,
    parameter int numregs = 32
)(
    input  logic                 clk,
    input  logic                 reset,

    // write port
    input  logic                 wr_en,
    input  logic [4:0]           rd,
    input  logic [width-1:0]     result,
    input  logic [width-1:0]     ld_data,
    input  logic                 is_load,

    // read port 1
    input  logic                 rs1_valid,
    input  logic [4:0]           rs1,
    output logic [width-1:0]     src1_value,

    // read port 2
    input  logic                 rs2_valid,
    input  logic [4:0]           rs2,
    output logic [width-1:0]     src2_value
);

    (* keep *)  //......?
    logic [width-1:0] regs [0:numregs-1];

    // 
    initial begin
        for (int k = 0; k < numregs; k++) regs[k] = '0;
    end

    // 동기 write + reset
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < numregs; i++) regs[i] <= '0;
        end
        else if (wr_en && (rd != 5'd0)) begin
            regs[rd] <= is_load ? ld_data : result;  // non-blocking
        end
    end

    // 조합 read (X 전파 방지를 위해 2-상태 비교 사용)
    assign src1_value = (rs1_valid === 1'b1) ? regs[rs1] : '0;
    assign src2_value = (rs2_valid === 1'b1) ? regs[rs2] : '0;

endmodule
