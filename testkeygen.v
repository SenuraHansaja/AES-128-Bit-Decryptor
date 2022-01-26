`timescale 1ns / 1ps

module key_gen(in_key,rcon,out_key);

input [0:127] in_key;
input [0:31] rcon;
output [0:127] out_key;
wire [0:127] out_key;

//shifting operation

wire [0:127] key,key2;

assign key[96:103] = in_key[104:111];
assign key[104:111] = in_key[112:119];
assign key[112:119] = in_key[120:127];
assign key[120:127] = in_key[96:103];

assign key[0:95] = in_key[0:95];

//sub_bytes operation

sbox s1(key[96:99],key[100:103],key2[96:103]);
sbox s2(key[104:107],key[108:111],key2[104:111]);
sbox s3(key[112:115],key[116:119],key2[112:119]);
sbox s4(key[120:123],key[124:127],key2[120:127]);

//multiplication with rcon values
//xor with different columns
//out_key is also numbered column wise

//column1
assign out_key[0:7]  = in_key[0:7] ^ key2[96:103] ^ rcon[0:7]; 
assign out_key[8:15]  = in_key[8:15] ^ key2[104:111] ^ rcon[8:15]; 
assign out_key[16:23]  = in_key[16:23] ^ key2[112:119] ^ rcon[16:23]; 
assign out_key[24:31]  = in_key[24:31] ^ key2[120:127] ^ rcon[24:31]; 

//column2
assign out_key[32:39] = in_key[32:39] ^ out_key[0:7];
assign out_key[40:47] = in_key[40:47] ^ out_key[8:15];
assign out_key[48:55] = in_key[48:55] ^ out_key[16:23];
assign out_key[56:63] = in_key[56:63] ^ out_key[24:31];

//column3
assign out_key[64:71] = in_key[64:71] ^ out_key[32:39];
assign out_key[72:79] = in_key[72:79] ^ out_key[40:47];
assign out_key[80:87] = in_key[80:87] ^ out_key[48:55];
assign out_key[88:95] = in_key[88:95] ^ out_key[56:63];

//column4
assign out_key[96:103] = in_key[96:103] ^ out_key[64:71];
assign out_key[104:111] = in_key[104:111] ^ out_key[72:79];
assign out_key[112:119] = in_key[112:119] ^ out_key[80:87];
assign out_key[120:127] = in_key[120:127] ^ out_key[88:95];

endmodule
