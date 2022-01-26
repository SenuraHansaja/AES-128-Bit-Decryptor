`timescale 1ns / 1ps

module inv_key_gen(
// input wire clk,
// input wire reset,
input [0:127] inKey,
output [0:1407] keyOut);

wire [0:1407] outKey;
wire [0:127] outKey1,outKey2,outKey3,outKey4,outKey5,outKey6,outKey7,outKey8,outKey9,outKey10;

// always @(posedge clk or negedge reset)
// 	begin
//pre round
assign outKey[0:127] = inKey[0:127];
//round 1
assign outKey[128:255] = outKey1[0:127];
//round 2
assign outKey[256:383] = outKey2[0:127];
//round 3
assign outKey[384:511] = outKey3[0:127];
//round 4
assign outKey[512:639] = outKey4[0:127];
//round 5
assign outKey[640:767] = outKey5[0:127];
//round 6
assign outKey[768:895] = outKey6[0:127];
//round 7
assign outKey[896:1023] = outKey7[0:127];
//round 8
assign outKey[1024:1151] = outKey8[0:127];
//round 9
assign outKey[1152:1279] = outKey9[0:127];
//final round
assign outKey[1280:1407] = outKey10[0:127];

assign keyOut[0:1407] = {inKey,outKey1,outKey2,
                  outKey3,outKey4,outKey5,outKey6,
                  outKey7,outKey8,outKey9,outKey10};

  // end

key_gen g1(inKey, 32'h01000000, outKey1);
key_gen g2(outKey1, 32'h02000000, outKey2);
key_gen g3(outKey2, 32'h04000000, outKey3);
key_gen g4(outKey3, 32'h08000000, outKey4);
key_gen g5(outKey4, 32'h10000000, outKey5);
key_gen g6(outKey5, 32'h20000000, outKey6);

key_gen g7(outKey6, 32'h40000000, outKey7);
key_gen g8(outKey7, 32'h80000000, outKey8);
key_gen g9(outKey8, 32'h1b000000, outKey9);
key_gen g10(outKey9, 32'h36000000, outKey10);

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module tb_key();
	// reg clk, reset;
	reg [0:127] key;
	wire [0:1407] keyOut;
	
    inv_key_gen keyTest(
        // .clk(clk),
        // .reset(reset),
	    .inKey(key),
	    .keyOut(keyOut));

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

    key = 128'h0105090d02060a0e03070b0f04080c10; #10;
    
    //data = 128'h216242c6db17a2abe6388d1dfa3c6260;

	    key = 128'h0102030405060708090a0b0c0d0e0f10;
    	//in_key = 128'h21dbe6fa6217383c42a28d62c6ab1d60;
	end
    	initial begin $monitor ("%t: in_key=%h,out_key=%h", $time, key, keyOut);
	//key = 128'h2b28ab097eaef7cf15d2154f16a6883c;
	//data= 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    end
endmodule

