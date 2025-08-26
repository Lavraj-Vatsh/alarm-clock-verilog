`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module alarm_clock (  
    input wire clk,               // Main clock signal  
    input wire reset,             // Asynchronous reset, active high  
    input wire set_alarm,         // Signal to set the alarm  
    input wire [5:0] alarm_hh,    // Alarm hour input (0-23)  
    input wire [5:0] alarm_mm,    // Alarm minute input (0-59)  
    input wire [5:0] alarm_ss,    // Alarm second input (0-59)  
    output reg [5:0] current_hh,  // Current hour  
    output reg [5:0] current_mm,  // Current minute  
    output reg [5:0] current_ss,  // Current second  
    output reg alarm              // Alarm signal  
);  

// Parameters  
parameter MAX_HOURS = 6'd23;  
parameter MAX_MINUTES = 6'd59;  
parameter MAX_SECONDS = 6'd59;  

// Clock divider (1 Hz) for 1 second time unit  
reg [26:0] clk_divider;  
wire one_second;  

// Generate a 1 Hz clock from the input clock (assuming a high-frequency clock input)  
always @(posedge clk or posedge reset) begin  
    if (reset)  
        clk_divider <= 0;  
    else  
        clk_divider <= clk_divider + 1;  
end  

// 1 Hz clock signal  
assign one_second = clk_divider[26]; // Assuming clk is 50MHz  

// Timekeeping  
always @(posedge one_second or posedge reset) begin  
    if (reset) begin  
        current_hh <= 0;  
        current_mm <= 0;  
        current_ss <= 0;  
        alarm <= 0;  
    end else begin  
        // Incrementing seconds  
        if (current_ss < MAX_SECONDS) begin  
            current_ss <= current_ss + 1;  
        end else begin  
            current_ss <= 0;  
            if (current_mm < MAX_MINUTES) begin  
                current_mm <= current_mm + 1;  
            end else begin  
                current_mm <= 0;  
                if (current_hh < MAX_HOURS) begin  
                    current_hh <= current_hh + 1;  
                end else begin  
                    current_hh <= 0; // Reset to 00 after 23:59:59  
                end  
            end  
        end  
    end  
end  

// Alarm setting and checking  
always @(posedge one_second or posedge reset) begin  
    if (reset) begin  
        alarm <= 0; // Clear alarm  
    end else if (set_alarm) begin  
        if (current_hh == alarm_hh && current_mm == alarm_mm && current_ss == alarm_ss) begin  
            alarm <= 1; // Trigger alarm if time matches  
        end else begin  
            alarm <= 0; // Reset alarm if time does not match  
        end  
    end  
end  

endmodule  
