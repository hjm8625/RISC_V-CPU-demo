`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/11 22:44:05
// Design Name: 
// Module Name: dmem
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


module dmem #(
    parameter int width = 32,
    parameter int length = 256
)(
    input logic clk,
    input logic reset,
    
    // byte address
    input logic [31:0] addr,
    
    // using store and load
    input logic is_s_instr, //(store)
    input logic is_load, // (load)
    //data
    input logic [31:0] src2_value,
    output logic [31:0] ld_data   
    );
    // mem
    logic [31:0] mem [0:255];
    
    //byte address with addr
    wire [4:0] index = addr[6:2]; // shift for x4 , use wire!
    
    // initial condition
    initial begin
        for (int i = 0; i<256;, i++)
            mem[i] = '0;
    end
    //store
    always_ff @(posedge clk) begin
        if (reset) begin    
            for (int i = 0; i < 256; i++)
                mem[i] <= '0;
        end else if (is_s_instr == 1'b1) begin
            mem[index] <= src2_value;
        end
    end
    
    //read
    always_comb begin
        if (is_load == 1'b1) 
            ld_data = mem[index];
        else
            ld_data = '0;
    end

    //
endmodule
