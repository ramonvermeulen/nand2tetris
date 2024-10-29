// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

// if there is no key pressed sets all pixels to "white" 0x0000
// if three is any key pressed sets all pixels to "black" 0xFFFF

@KBD
D=A
@kbd_address
M=D

(RESET_SCREEN_ADDRESS)
    @SCREEN
    D=A
    @screen_address
    M=D

// if RAM[@KBD] != 0:
//     screen black
// else:
//     screen white
(KEYBOARD_LOOP)
    @target_color
    M=-1 // "black" 0xFFFF
    @KBD
    D=M
    @PIXEL_LOOP
    D;JNE
    @target_color
    M=0 // "white" 0x0000
    @PIXEL_LOOP
    D;JEQ


// for screen_address < kbd_address:
//     pixel = target_color
//     screen_address += 1
(PIXEL_LOOP)
    // if screen_address < kbd_address: break loop
    @screen_address
    D=M
    @kbd_address
    D=D-M
    @RESET_SCREEN_ADDRESS
    D;JGE

    // body
    @target_color
    D=M // D = 0 (white) or 1 (black)
    @screen_address
    A=M // A = value of screen_address (current pixel block in loop)
    M=D // set pixel block to target_color

    // screen_address += 1
    @screen_address
    M=M+1

    // continue loop
    @PIXEL_LOOP
    0;JMP


(END)
    @END
    A;JGT
