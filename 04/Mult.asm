// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.


// reset output
@R2
M=0

// i = value of R0
@R0
D=M

@i
M=D

@MULTIPLICATION_LOOP
D;JGT // if i > 0, start multiplication loop
@END
D;JEQ // if i == 0, END -> 0 times X is always 0
@R1
D=M
@END
D;JEQ // if R1 == 0, END -> X times 0 is always 0

// i < 0 so inverse + 1
// TODO try -M instead
@i
M=-M

// while i >= 0
(MULTIPLICATION_LOOP)
    @R1
    D=M
    @R2
    M=D+M

    @i
    M=M-1
    D=M
    @POST_LOGIC_R0
    D;JEQ
    @MULTIPLICATION_LOOP
    D;JGT

(INVERSE_OUTCOME)
@R2
M=-M
@END
0;JMP

// if R0 < 0 || R0 < 0 && R1 < 0 inverse outcome
(POST_LOGIC_R0)
@R0
D=M
@INVERSE_OUTCOME
D;JLT

// infinite loop as end
(END)
    @END
    0;JMP
