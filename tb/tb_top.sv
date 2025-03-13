/* run command
vcs -sverilog -timescale=1ns/1ns -full64 -f filelist.f -ntb_opts -uvm   -o   simv ;     ./simv -f run.f;
*/
module top  ;

import uvm_pkg::*;
`include "uvm_macros.svh"

import yapp_pkg::*;
import channel_pkg::*;
import hbus_pkg::*;
import clock_and_reset_pkg::*;



`include "../sv/router_scoreboard.sv"
`include "../sv/router_mcsequencer.sv"
`include "../sv/router_mcseqs_lib.sv"
`include "router_tb.sv"
`include "router_test_lib.sv"



//yapp_packet tr;

initial begin
yapp_vif_config::set(null , "*uvc0*" , "vif" , hw_top.in0);
hbus_vif_config::set(null , "*hbus*" , "vif" , hw_top.h_if);
clock_and_reset_vif_config::set(null , "*clk_rst*" , "vif" , hw_top.cr_if);
channel_vif_config::set(null , "*ch0*" , "vif" , hw_top.ch0_if);
channel_vif_config::set(null , "*ch1*" , "vif" , hw_top.ch1_if);
channel_vif_config::set(null , "*ch2*" , "vif" , hw_top.ch2_if);


run_test("mc_test");
end


initial begin

$dumpfile("dump.vcd");
$dumpvars;

end


endmodule