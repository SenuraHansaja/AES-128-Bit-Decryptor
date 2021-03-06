`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mix_col_cp(
    // input wire clk,
    // input wire reset,
    input [0:127] i_shift,
    output [0:127] i_mix);

//1
assign i_mix[0:7] = x14(i_shift[0:7]) ^ x11(i_shift[8:15]) ^ x13(i_shift[16:23]) ^ x9(i_shift[24:31]);
assign i_mix[8:15] = x9(i_shift[0:7]) ^ x14(i_shift[8:15]) ^ x11(i_shift[16:23]) ^ x13(i_shift[24:31]);
assign i_mix[16:23] = x13(i_shift[0:7]) ^ x9(i_shift[8:15]) ^ x14(i_shift[16:23]) ^ x11(i_shift[24:31]);
assign i_mix[24:31] = x11(i_shift[0:7]) ^ x13(i_shift[8:15]) ^ x9(i_shift[16:23]) ^ x14(i_shift[24:31]);

//2
assign i_mix[32:39] = x14(i_shift[32:39]) ^ x11(i_shift[40:47]) ^ x13(i_shift[48:55]) ^ x9(i_shift[56:63]);
assign i_mix[40:47] = x9(i_shift[32:39]) ^ x14(i_shift[40:47]) ^ x11(i_shift[48:55]) ^ x13(i_shift[56:63]);
assign i_mix[48:55] = x13(i_shift[32:39]) ^ x9(i_shift[40:47]) ^ x14(i_shift[48:55]) ^ x11(i_shift[56:63]);
assign i_mix[56:63] = x11(i_shift[32:39]) ^ x13(i_shift[40:47]) ^ x9(i_shift[48:55]) ^ x14(i_shift[56:63]);

//3
assign i_mix[64:71] = x14(i_shift[64:71]) ^ x11(i_shift[72:79]) ^ x13(i_shift[80:87]) ^ x9(i_shift[88:95]);
assign i_mix[72:79] = x9(i_shift[64:71]) ^ x14(i_shift[72:79]) ^ x11(i_shift[80:87]) ^ x13(i_shift[88:95]);
assign i_mix[80:87] = x13(i_shift[64:71]) ^ x9(i_shift[72:79]) ^ x14(i_shift[80:87]) ^ x11(i_shift[88:95]);
assign i_mix[88:95] = x11(i_shift[64:71]) ^ x13(i_shift[72:79]) ^ x9(i_shift[80:87]) ^ x14(i_shift[88:95]);

//4
assign i_mix[96:103] = x14(i_shift[96:103]) ^ x11(i_shift[104:111]) ^ x13(i_shift[112:119]) ^ x9(i_shift[120:127]);
assign i_mix[104:111] = x9(i_shift[96:103]) ^ x14(i_shift[104:111]) ^ x11(i_shift[112:119]) ^ x13(i_shift[120:127]);
assign i_mix[112:119] = x13(i_shift[96:103]) ^ x9(i_shift[104:111]) ^ x14(i_shift[112:119]) ^ x11(i_shift[120:127]);
assign i_mix[120:127] = x11(i_shift[96:103]) ^ x13(i_shift[104:111]) ^ x9(i_shift[112:119]) ^ x14(i_shift[120:127]);

	// always @(posedge clk or negedge reset)
	// begin
        // assign i_mix = i_mix;
	// end
function [0:7] xtime;
input [0:7]i;
begin
if(i[0] ==0)
xtime = {i[1:7],1'b0};
else
xtime = {i[1:7],1'b0}^8'h1b;
end
endfunction

function [0:7] x14;
input [0:7]i;
begin
x14 = xtime(i) ^ xtime(xtime(i)) ^ xtime(xtime(xtime(i)));
end
endfunction

function [0:7] x13;
input [0:7]i;
begin
x13 = i ^ xtime(xtime(i)) ^ xtime(xtime(xtime(i)));
end
endfunction

function [0:7] x11;
input [0:7]i;
begin
x11 = i ^ xtime(i) ^ xtime(xtime(xtime(i)));
end
endfunction

function [0:7] x9;
input [0:7]i;
begin
x9 = i ^ xtime(xtime(xtime(i)));
end
endfunction


endmodule


module mix_tb_cp();
	// reg clk, reset;
	reg [0:127] inText;
	wire [0:127] outText;
	
    mix_col_cp mixTest(
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

