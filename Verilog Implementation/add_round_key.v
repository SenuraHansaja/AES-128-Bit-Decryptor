`timescale 1ns / 1ps


module add_round_key(
    // input wire clk,
    // input wire reset,
    input [0:127] round_key,
    input [0:127] text,
    output [0:127] outText
	);
	

	// always @(posedge clk or negedge reset)
	// begin
    	//Add Round Key
        assign outText = round_key[0:127] ^ text[0:127];
 
	// end
	
endmodule

module addRoundKey_tb();
	// reg clk, reset;
	reg [0:127] round_key;
	reg [0:127] text;
	wire [0:127] outText;
	
    add_round_key ark(
        // .clk(clk),
        // .reset(reset),
	    .round_key(round_key),
	    .text(text),
	    .outText(outText));

//    initial 
//   begin
//     reset = 1;
//     #5 reset = 0;
//    // #10 reset = 1;
//   end
  
//   initial 
//   begin
//     clk = 0;
//     forever clk = #5 ~clk;
//   end
    initial
    begin

    // round_key = 128'h0105090d02060a0e03070b0f04080c10; #10;
    
    // text = 128'h216242c6db17a2abe6388d1dfa3c6260; #10;

	    round_key = 128'h0102030405060708090a0b0c0d0e0f10;
    	text = 128'h21dbe6fa6217383c42a28d62c6ab1d60;
	end
    	initial begin $monitor ("%t: in_key=%h,in_text=%h,out_text=%h ", $time, round_key, text, outText);
	//key = 128'h2b28ab097eaef7cf15d2154f16a6883c;
	//data= 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    end
endmodule
