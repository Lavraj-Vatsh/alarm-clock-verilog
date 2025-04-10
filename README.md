# alarm-clock-verilog

## Overview  
This project implements a digital alarm clock using Verilog HDL. The alarm clock keeps track of the current time in hours, minutes, and seconds, and allows the user to set an alarm that triggers when the current time matches the set alarm time. The design is suitable for FPGA implementation and serves as a practical example of designing digital systems with Verilog.  

## Features  
- Keeps track of time in hh:mm:ss format.  
- Allows users to set alarm time (hh:mm:ss).  
- Triggers an alarm signal when the current time matches the alarm time.  
- Simple and efficient clock divider to generate a 1 Hz clock from a high-frequency input clock.  

## Design Details  
- Clock Divider: A 27-bit counter generates a 1 Hz clock signal from a 50 MHz input clock.  
- Timekeeping Logic: Time is updated every second based on the 1 Hz clock signal. It handles overflow from seconds to minutes and minutes to hours.  
- Alarm Logic: Checks if the current time matches the set alarm time and triggers an alarm signal.  
