`timescale 1ns / 1ps

module Datapath_tb;

    // Inputs
    reg clk;
    reg rst;

    // Instantiate the Unit Under Test (UUT)
    Datapath uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock Generation: 10ns period -> 100MHz clock
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;

        // Apply Reset Pulse
        #10 rst = 0;  // Keeping reset high for 20ns to ensure proper initialization
        // Run simulation for a sufficient duration to allow the datapath to execute
        #2000 $finish;  // Adjust as necessary
    end

    // Monitor key signals in the Datapath
    initial begin
        // Monitor key signals to help visualize them in the waveform viewer
        $monitor("Time: %0d ns, PC: %h, Instruction: %h, RegWrite: %b, ALU Result: %h, Zero: %b, ReadRegData1: %h, ReadRegData2: %h, Immediate: %h, MemRead: %b, MemWrite: %b", 
            $time, uut.InstructionCountOut, uut.ReadInstruction, uut.RegWrite, uut.ALU_Out, uut.zero, uut.ReadRegData1, uut.ReadRegData2, uut.Immediate, uut.MemRead, uut.MemWrite);
    end

    // Waveform dump
    initial begin
        $dumpfile("Datapath_tb.vcd");
        $dumpvars(0, Datapath_tb);
    end

endmodule



