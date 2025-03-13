+incdir+../yapp/sv              # include directory for sv files 
../yapp/sv/yapp_if.sv           # compile top level module 
../yapp/sv/yapp_pkg.sv          # compile YAPP package 

+incdir+../channel/sv 
../channel/sv/channel_if.sv
../channel/sv/channel_pkg.sv

+incdir+../hbus/sv 
../hbus/sv/hbus_pkg.sv
../hbus/sv/hbus_if.sv

+incdir+../clock_and_reset/sv 
../clock_and_reset/sv/clock_and_reset_if.sv
../clock_and_reset/sv/clock_and_reset_pkg.sv


+incdir+../router_rtl   
../router_rtl/yapp_router.sv 
../router_rtl/clkgen.sv
../router_rtl/hw_top_dut.sv
tb_top.sv            # compile top level module 

+timescale+1ns/1ns

