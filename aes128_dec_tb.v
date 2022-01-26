`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module aes128_dec_tb();
    reg clk, reset; 
	reg [0:127] key;
	reg [0:127] inText;
	wire [0:127] outText;
	
  integer infileText, infileKey, outfile1;

  main aes128_dec(
    .clk(clk),
    .reset(reset),
    .key(key),
    .inText(inText),
    .outText(outText));

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

  initial begin
    infileText = $fopen("C:/intelFPGA/17.1/128AES/128-Bit-AES-Decryption/text.txt", "r");
    infileKey = $fopen("C:/intelFPGA/17.1/128AES/128-Bit-AES-Decryption/key.txt", "r");
    outfile1 = $fopen("C:/intelFPGA/17.1/128AES/128-Bit-AES-Decryption/plain_text.txt", "w");

    while (! ($feof(infileText) && $feof(infileKey))) begin
      $fscanf(infileText, "%b\n",inText);
      $fscanf(infileKey, "%b\n", key);

      $fdisplay(outfile1, "%h", outText);

      #10;
    end

    $fclose(infileText);
    $fclose(infileKey);
    $fclose(outfile1);
    #100
    $stop;
  end


  //    initial
  //    begin

	// key = 128'h0102030405060708090a0b0c0d0e0f10;
  //   inText = 128'h21dbe6fa6217383c42a28d62c6ab1d60;
  //   	key = 128'h0105090d02060a0e03070b0f04080c10; 
	// inText = 128'h216242c6db17a2abe6388d1dfa3c6260;

 	// end

    	initial begin $monitor ("%t: inText=%h, key=%h, outText=%h", $time, inText, key, outText);
	//key = 128'h2b28ab097eaef7cf15d2154f16a6883c;
	//data= 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    end
endmodule

