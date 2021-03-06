`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module inv_shift_row(
    // input wire clk,
    // input wire reset,
    input [0:127] s_state,
    output [0:127] shifted_state);

    wire [0:127] shifted_state_temp;

// 0||4||8||12
// 1||5||9||13
// 2||6||10||14
// 3||7||11||15

    assign shifted_state_temp[0:7]   = s_state[0:7];//0 
    assign shifted_state_temp[8:15]   = s_state[104:111];//0 
    assign shifted_state_temp[16:23]   = s_state[80:87];//0
    assign shifted_state_temp[24:31]   = s_state[56:63];//0  

    assign shifted_state_temp[32:39]   = s_state[32:39];//0 
    assign shifted_state_temp[40:47] = s_state[8:15];//5
    assign shifted_state_temp[48:55] = s_state[112:119];//9
    assign shifted_state_temp[56:63] = s_state[88:95];//13

    //row3
    assign shifted_state_temp[64:71] = s_state[64:71];//2
    assign shifted_state_temp[72:79] = s_state[40:47];//6
    assign shifted_state_temp[80:87] = s_state[16:23];//10
    assign shifted_state_temp[88:95] = s_state[120:127];//14

    //row4
    assign shifted_state_temp[96:103] = s_state[96:103];//3
    assign shifted_state_temp[104:111] = s_state[72:79];//7
    assign shifted_state_temp[112:119] = s_state[48:55];//11
    assign shifted_state_temp[120:127] = s_state[24:31];//15

  //   always @(posedge clk or negedge reset)
	// begin
	assign shifted_state = shifted_state_temp;

    // end
endmodule


module tb_shiftrow();
    // reg clk, reset;
	reg [0:127] inText;
	wire [0:127] outText;
	
    inv_shift_row shTest(
      //   .clk(clk),
	    // .reset(reset),
	    .s_state(inText),
	    .shifted_state(outText));
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

    //in_key = 128'h0105090d02060a0e03070b0f04080c10; #10;
    
    inText = 128'h216242c6db17a2abe6388d1dfa3c6260; #10;

	    // key = 128'h0102030405060708090a0b0c0d0e0f10;
    	inText = 128'h21dbe6fa6217383c42a28d62c6ab1d60;
	end
    	initial begin $monitor ("%t: in_key=%h,out_key=%h", $time, inText, outText);
	//key = 128'h2b28ab097eaef7cf15d2154f16a6883c;
	//data= 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    end
endmodule

