# RISC_V-CPU-demo

edx building a RISC_V core의 강의는 makerchip을 이용한 TL-verilog를 사용했는데, 이를 vivado systemverilog에서 구현해 보는 것을 목표로 하였다.
최종목표는 32bit risc v cpu를 만드는 것이다.

진행상황
1. makerchip에서 구현 (O)
2. vivado에서 모든 블록 완성 (dmem 제외)
3. 시뮬레이션 상황 (addi, add 작동 확인)
<img width="926" height="227" alt="Image" src="https://github.com/user-attachments/assets/2c872368-6e07-431f-a70c-51caf110c221" />
4. branch 작동 확인
5. 예시 코드 만들어 동작 확인

reference: LinuxFoundationX • LFD111x (Building a RISC-V CPU Core)
