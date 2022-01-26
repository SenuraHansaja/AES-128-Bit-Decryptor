`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mix_col(
    // input wire clk,
    // input wire reset,
    input [0:127] i_shift,
    output [0:127] i_mix);

    wire [0:128] i_mix_temp;
//1
assign i_mix_temp[0:7] = 8'hff & (Multiply(i_shift[0:7], 8'h0e) ^ Multiply(i_shift[8:15], 8'h0b) ^ Multiply(i_shift[16:23], 8'h0d) ^ Multiply(i_shift[24:31], 8'h09));
assign i_mix_temp[8:15] = 8'hff & (Multiply(i_shift[0:7], 8'h09) ^ Multiply(i_shift[8:15], 8'h0e) ^ Multiply(i_shift[16:23], 8'h0b) ^ Multiply(i_shift[24:31], 8'h0d));
assign i_mix_temp[16:23] = 8'hff & (Multiply(i_shift[0:7], 8'h0d) ^ Multiply(i_shift[8:15], 8'h09) ^ Multiply(i_shift[16:23], 8'h0e) ^ Multiply(i_shift[24:31], 8'h0b));
assign i_mix_temp[24:31] = 8'hff & (Multiply(i_shift[0:7], 8'h0b) ^ Multiply(i_shift[8:15], 8'h0d) ^ Multiply(i_shift[16:23], 8'h09) ^ Multiply(i_shift[24:31], 8'h0e));

//2
assign i_mix_temp[32:39] = 8'hff & (Multiply(i_shift[32:39], 8'h0e) ^ Multiply(i_shift[40:47], 8'h0b) ^ Multiply(i_shift[48:55], 8'h0d) ^ Multiply(i_shift[56:63], 8'h09));
assign i_mix_temp[40:47] = 8'hff & (Multiply(i_shift[32:39], 8'h09) ^ Multiply(i_shift[40:47], 8'h0e) ^ Multiply(i_shift[48:55], 8'h0b) ^ Multiply(i_shift[56:63], 8'h0d));
assign i_mix_temp[48:55] = 8'hff & (Multiply(i_shift[32:39], 8'h0d) ^ Multiply(i_shift[40:47], 8'h09) ^ Multiply(i_shift[48:55], 8'h0e) ^ Multiply(i_shift[56:63], 8'h0b));
assign i_mix_temp[56:63] = 8'hff & (Multiply(i_shift[32:39], 8'h0b) ^ Multiply(i_shift[40:47], 8'h0d) ^ Multiply(i_shift[48:55], 8'h09) ^ Multiply(i_shift[56:63], 8'h0e));

//3
assign i_mix_temp[64:71] = 8'hff & (Multiply(i_shift[64:71], 8'h0e) ^ Multiply(i_shift[72:79], 8'h0b) ^ Multiply(i_shift[80:87], 8'h0d) ^ Multiply(i_shift[88:95], 8'h09));
assign i_mix_temp[72:79] = 8'hff & (Multiply(i_shift[64:71], 8'h09) ^ Multiply(i_shift[72:79], 8'h0e) ^ Multiply(i_shift[80:87], 8'h0b) ^ Multiply(i_shift[88:95], 8'h0d));
assign i_mix_temp[80:87] = 8'hff & (Multiply(i_shift[64:71], 8'h0d) ^ Multiply(i_shift[72:79], 8'h09) ^ Multiply(i_shift[80:87], 8'h0e) ^ Multiply(i_shift[88:95], 8'h0b));
assign i_mix_temp[88:95] = 8'hff & (Multiply(i_shift[64:71], 8'h0b) ^ Multiply(i_shift[72:79], 8'h0d) ^ Multiply(i_shift[80:87], 8'h09) ^ Multiply(i_shift[88:95], 8'h0e));

//4
assign i_mix_temp[96:103] = 8'hff & (Multiply(i_shift[96:103], 8'h0e) ^ Multiply(i_shift[104:111], 8'h0b) ^ Multiply(i_shift[112:119], 8'h0d) ^ Multiply(i_shift[120:127], 8'h09));
assign i_mix_temp[104:111] = 8'hff & (Multiply(i_shift[96:103], 8'h09) ^ Multiply(i_shift[104:111], 8'h0e) ^ Multiply(i_shift[112:119], 8'h0b) ^ Multiply(i_shift[120:127], 8'h0d));
assign i_mix_temp[112:119] = 8'hff & (Multiply(i_shift[96:103], 8'h0d) ^ Multiply(i_shift[104:111], 8'h09) ^ Multiply(i_shift[112:119], 8'h0e) ^ Multiply(i_shift[120:127], 8'h0b));
assign i_mix_temp[120:127] = 8'hff & (Multiply(i_shift[96:103], 8'h0b) ^ Multiply(i_shift[104:111], 8'h0d) ^ Multiply(i_shift[112:119], 8'h09) ^ Multiply(i_shift[120:127], 8'h0e));

	// always @(posedge clk or negedge reset)
	// begin
        assign i_mix = i_mix_temp;
	// end

function [0:7]xtime1;
input [0:7]x;
    xtime1 = ((x << 1) ^ (((x >> 7) & 1) * 8'h1b));
endfunction

function [0:7]Multiply;
input [0:7] x;
input [0:7] y;
    Multiply = ((y & 1) * x) ^ ((y >> 1 & 1) * xtime1(x)) 
             ^ ((y >> 2 & 1) * xtime1(xtime1(x)))
             ^ ((y >> 3 & 1) * xtime1(xtime1(xtime1(x)))) 
             ^ ((y >> 4 & 1) * xtime1(xtime1(xtime1(xtime1(x)))));
endfunction
endmodule

module mix_tb();
	// reg clk, reset;
	reg [0:127] inText;
	wire [0:127] outText;
	
    mix_col mixTest(
        // .clk(clk),
        // .reset(reset),
	    .i_shift(inText),
	    .i_mix(outText));

// initial 
//   begin
//     reset = 1;
//     #5 reset = 0;
//     #10 reset = 1;
//   end
  
//   initial 
//   begin
//     clk = 0;
//     forever clk = #5 ~clk;
//   end
    initial
    begin

    //key = 128'h0105090d02060a0e03070b0f04080c10; #10;
    
    //inText = 128'h216242c6db17a2abe6388d1dfa3c6260; #10;

	   // key = 128'h0102030405060708090a0b0c0d0e0f10;
    	inText = 128'h21dbe6fa6217383c42a28d62c6ab1d60;
	end
    	initial begin $monitor ("%t: in_key=%h,out_key=%h", $time, inText, outText);
	//key = 128'h2b28ab097eaef7cf15d2154f16a6883c;
	//data= 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    end
endmodule

