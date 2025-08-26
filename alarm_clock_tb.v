`timescale 1ns / 1ps


module alarm_clock_tb;  

    reg clk;  
    reg reset;  
    reg set_alarm;  
    reg [5:0] alarm_hh;  
    reg [5:0] alarm_mm;  
    reg [5:0] alarm_ss;  
    wire [5:0] current_hh;  
    wire [5:0] current_mm;  
    wire [5:0] current_ss;  
    wire alarm;  

    // Instantiate the alarm clock module  
    alarm_clock ac (  
        .clk(clk),  
        .reset(reset),  
        .set_alarm(set_alarm),  
        .alarm_hh(alarm_hh),  
        .alarm_mm(alarm_mm),  
        .alarm_ss(alarm_ss),  
        .current_hh(current_hh),  
        .current_mm(current_mm),  
        .current_ss(current_ss),  
        .alarm(alarm)  
    );  

    initial begin  
        // Initialize signals  
        clk = 0;  
        reset = 1;  
        set_alarm = 0;  
        alarm_hh = 6'd0; // Set alarm for 00:00:05  
        alarm_mm = 6'd0;  
        alarm_ss = 6'd5;  

        // Release reset  
        #10 reset = 0;  

        // Run clock for some time  
        #100;  
        
        // Set alarm  
        set_alarm = 1;  
        
        // Wait for alarm to trigger  
        #1000;  

        // Deassert set_alarm  
        set_alarm = 0;  

        // Wait and observe state  
        #5000;  

        $finish;  
    end  

    // Clock generation  
    always #5 clk = ~clk; // 100MHz clock  

    initial begin  
        $monitor("Time = %02d:%02d:%02d, Alarm = %b", current_hh, current_mm, current_ss, alarm);  
    end  

endmodule  
