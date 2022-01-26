`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module sub_byte(
	input wire clk,
    	input wire reset,
	input wire [0:127] in_key,
	output reg [0:127] out_key);
	
	wire [0:127] outKey_temp;

sbox sb5(in_key[0:3],in_key[4:7],outKey_temp[0:7]);
sbox sb6(in_key[32:35],in_key[36:39],outKey_temp[32:39]);
sbox sb7(in_key[64:67],in_key[68:71],outKey_temp[64:71]);
sbox sb8(in_key[96:99],in_key[100:103],outKey_temp[96:103]);

sbox sb9(in_key[8:11],in_key[12:15],outKey_temp[8:15]);
sbox sb10(in_key[40:43],in_key[44:47],outKey_temp[40:47]);
sbox sb11(in_key[72:75],in_key[76:79],outKey_temp[72:79]);
sbox sb12(in_key[104:107],in_key[108:111],outKey_temp[104:111]);

sbox sb13(in_key[16:19],in_key[20:23],outKey_temp[16:23]);
sbox sb14(in_key[48:51],in_key[52:55],outKey_temp[48:55]);
sbox sb15(in_key[80:83],in_key[84:87],outKey_temp[80:87]);
sbox sb16(in_key[112:115],in_key[116:119],outKey_temp[112:119]);

sbox sb17(in_key[24:27],in_key[28:31],outKey_temp[24:31]);
sbox sb18(in_key[56:59],in_key[60:63],outKey_temp[56:63]);
sbox sb19(in_key[88:91],in_key[92:95],outKey_temp[88:95]);
sbox sb20(in_key[120:123],in_key[124:127],outKey_temp[120:127]);

always @(posedge clk or negedge reset)
	begin
	out_key <= outKey_temp[0:127];

end

endmodule

module tb_subbyte();
	reg clk, reset;
	reg [0:127] in_key;
	wire [0:127] out_key;
	
    sub_byte sbTest(
	.clk(clk),
	.reset(reset),
	    .in_key(in_key),
	    .out_key(out_key));
 
  
  initial 
  begin
    reset = 1;
    #5 reset = 0;
    #10 reset = 1;
  end
  
  initial 
  begin
    clk = 0;
    forever clk = #5 ~clk;
  end
    initial
    begin

    in_key = 128'h0105090d02060a0e03070b0f04080c10; #10;
    
    //data = 128'h216242c6db17a2abe6388d1dfa3c6260;

	    // key = 128'h0102030405060708090a0b0c0d0e0f10;
    	in_key = 128'h21dbe6fa6217383c42a28d62c6ab1d60;
	end
    	initial begin $monitor ("%t: in_key=%h,out_key=%h", $time, in_key, out_key);
	//key = 128'h2b28ab097eaef7cf15d2154f16a6883c;
	//data= 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    end
endmodule
