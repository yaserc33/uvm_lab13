/*-----------------------------------------------------------------
File name     : hw_top_dut.sv
Developers    : Kathleen Meade, Brian Dickinson
Created       : 01/04/11
Description   : lab06_vif hardware top module for acceleration
              : instantiates clock generator, interfaces and DUT
Notes         : From the Cadence "SystemVerilog Accelerated Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module hw_top;

  // Clock and reset signals
  logic [31:0]  clock_period;
  logic         run_clock;
  logic         clock;
  logic         reset;

  // YAPP Interface to the DUT
  yapp_if in0(clock, reset);


  //interfaces

clock_and_reset_if cr_if (
              .clock(clock),
              .reset(reset),
              .run_clock(run_clock), 
              .clock_period(clock_period));



 hbus_if h_if ( clock,  reset);




channel_if ch0_if (clock,reset);
channel_if ch1_if (clock,reset);
channel_if ch2_if (clock,reset);






  // CLKGEN module generates clock
  clkgen clkgen (
    .clock(clock ),
    .run_clock(run_clock),
    .clock_period(clock_period)
  );


  yapp_router dut(
    .reset(reset),
    .clock(clock),
    .error(),
    // YAPP interface signals connection
    .in_data(in0.in_data),
    .in_data_vld(in0.in_data_vld),
    .in_suspend(in0.in_suspend),
    // Output Channels
    //Channel 0   
    .data_0(ch0_if.data),
    .data_vld_0(ch0_if.data_vld),
    .suspend_0(ch0_if.suspend),
    //Channel 1   
    .data_1(ch1_if.data),
    .data_vld_1(ch1_if.data_vld),
    .suspend_1(ch1_if.suspend),
    //Channel 2   
    .data_2(ch2_if.data),  
    .data_vld_2(ch2_if.data_vld),
    .suspend_2(ch2_if.suspend),
    // Host Interface Signals
    .haddr(h_if.haddr),
    .hdata(h_if.hdata_w),
    .hen(h_if.hen),
    .hwr_rd(h_if.hwr_rd));



endmodule
