# RISC_V-CPU-demo

edx building a RISC_V core의 강의는 makerchip을 이용한 TL-verilog를 사용했는데, 이를 vivado systemverilog에서 구현해 보는 것을 목표로 하였다.
최종목표는 32bit risc v cpu를 만드는 것이다.

진행상황
1. makerchip에서 구현 (O)
2. vivado에서 모든 블록 완성 (O)
pc - imem - decode - register_file_read - ALU - branch - dmem
4. 시뮬레이션 상황
a = 1  
while a !=5 :  
  a = a+1  
a를 data memory에 저장 후 불러오기  
mem[0] = 32'h00100093; // ADDI x1,x0,1  
mem[1] = 32'h00500113; // ADDI x2,x0,5  
mem[2] = 32'h00208663; // BEQ x1,x2,8  
mem[3] = 32'h00108093; // ADDI x1,x1,1  
mem[4] = 32'hFF9FF06F; // JAL x0,-8  
mem[5] = 32'h00102223; // SW x1,x4  
mem[6] = 32'h00402203; // LW x4,x1
  
<img width="726" height="457" alt="Image" src="https://github.com/user-attachments/assets/71c21464-8708-41ef-bf4d-dddfc23f9c68" />



reference: LinuxFoundationX • LFD111x (Building a RISC-V CPU Core)
