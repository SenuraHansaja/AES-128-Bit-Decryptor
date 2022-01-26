`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module main(
    input wire clk,
    input wire reset,
    input wire [0:127] inText,
    input wire [0:127] key,
    output reg [0:127] outText);


    wire [0:127] s_key0,s_key1,s_key2,s_key3,s_key4,s_key5,s_key6,s_key7,s_key8,s_key9;
    wire [0:127] sh_key0,sh_key1,sh_key2,sh_key3,sh_key4,sh_key5,sh_key6,sh_key7,sh_key8,sh_key9;
    wire [0:127] mx_key0,mx_key1,mx_key2,mx_key3,mx_key4,mx_key5,mx_key6,mx_key7,mx_key8;
    wire [0:127] round_key0,round_key1,round_key2,round_key3,round_key4,round_key5,round_key6,round_key7,round_key8,round_key9,round_key10;
    wire [0:1407] keyOut; // 11-Key


    //pre round operation


    inv_key_gen ikg0(
        // .clk(clk),
        // .reset(reset),
        .inKey(key),
        .keyOut(keyOut)
    );

    //rounds begin
    add_round_key ark0(keyOut[1280:1407],inText,round_key0);

    //*****************************round1*****************************************

    //shift row
    inv_shift_row sh0(round_key0,sh_key0);

    //sub bytes operation
    inv_sub_byte s0(sh_key0,s_key0);

    //add round key operation
    add_round_key ark1(keyOut[1152:1279],s_key0,round_key1);

    //mix column
    mix_col_cp m0(round_key1,mx_key0);

    //*****************************round2*****************************************

    //shift row
    inv_shift_row sh1(mx_key0,sh_key1);

    //sub bytes operation
    inv_sub_byte s1(sh_key1,s_key1);

    //add round key operation
    add_round_key ark2(keyOut[1024:1151],s_key1,round_key2);

    //mix column
    mix_col_cp  m1(round_key2,mx_key1);

    //*****************************round3*****************************************

    //shift row
    inv_shift_row sh2(mx_key1,sh_key2);

    //sub bytes operation
    inv_sub_byte s2(sh_key2,s_key2);

    //add round key operation
    add_round_key ark3(keyOut[896:1023],s_key2,round_key3);

    //mix column
    mix_col_cp  m2(round_key3,mx_key2);

    //*****************************round4*****************************************

    //shift row
    inv_shift_row sh3(mx_key2,sh_key3);

    //sub bytes operation
    inv_sub_byte s3(sh_key3,s_key3);

    //add round key operation
    add_round_key ark4(keyOut[768:895],s_key3,round_key4);

    //mix column
    mix_col_cp  m3(round_key4,mx_key3);

    //*****************************round5*****************************************

    //shift row
    inv_shift_row sh4(mx_key3,sh_key4);

    //sub bytes operation
    inv_sub_byte s4(sh_key4,s_key4);

    //add round key operation
    add_round_key ark5(keyOut[640:767],s_key4,round_key5);

    //mix column
    mix_col_cp  m4(round_key5,mx_key4);

    //*****************************round6*****************************************

    //shift row
    inv_shift_row sh5(mx_key4,sh_key5);

    //sub bytes operation
    inv_sub_byte s5(sh_key5,s_key5);

    //add round key operation
    add_round_key ark6(keyOut[512:639],s_key5,round_key6);

    //mix column
    mix_col_cp  m5(round_key6,mx_key5);

    //*****************************round7*****************************************

    //shift row
    inv_shift_row sh6(mx_key5,sh_key6);

    //sub bytes operation
    inv_sub_byte s6(sh_key6,s_key6);

    //add round key operation
    add_round_key ark7(keyOut[384:511],s_key6,round_key7);

    //mix column
    mix_col_cp  m6(round_key7,mx_key6);

    //*****************************round8*****************************************

    //shift row
    inv_shift_row sh7(mx_key6,sh_key7);

    //sub bytes operation
    inv_sub_byte s7(sh_key7,s_key7);

    //add round key operation
    add_round_key ark8(keyOut[256:383],s_key7,round_key8);

    //mix column
    mix_col_cp  m7(round_key8,mx_key7);

    //*****************************round9*****************************************

    //shift row
    inv_shift_row sh8(mx_key7,sh_key8);

    //sub bytes operation
    inv_sub_byte s8(sh_key8,s_key8);

    //add round key operation
    add_round_key ark9(keyOut[128:255],s_key8,round_key9);

    //mix column
    mix_col_cp m8(round_key9,mx_key8);


    //********************************FINAL ROUND**********************************

    //shift row

    inv_shift_row sh9(mx_key8,sh_key9);

    //sub bytes operation

    inv_sub_byte s9(sh_key9,s_key9);

    //no mix column

    //add round key operation

    add_round_key ark10(keyOut[0:127],s_key9,round_key10);

	always @(posedge clk)
	begin
        outText = {round_key10};
 
	end

endmodule
