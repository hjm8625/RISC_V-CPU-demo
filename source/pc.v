`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/07 22:39:08
// Design Name: 
// Module Name: pc
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


module pc(
    input clk,
    input rst,
    //
    input taken_br,
    input [31:0] br_tgt_pc,
    // reg
    output reg[31:0] pc 
);
    reg [31:0] next_pc;
    
    always @* begin // always begin
        if (rst) 
            next_pc = 32'b0;
        else if (taken_br)
            next_pc = br_tgt_pc;
        else     
            next_pc = pc + 32'd4;
    end
    
    always @(posedge clk) begin // posedge
        pc <= next_pc; // in edge, use <=
    end    
    
endmodule
