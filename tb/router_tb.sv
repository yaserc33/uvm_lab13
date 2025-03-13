class router_tb extends uvm_env;
    `uvm_component_utils(router_tb)

yapp_uvc  uvc0;
channel_env ch0;
channel_env ch1;
channel_env ch2;
hbus_env hbus;
clock_and_reset_env clk_rst;
mc_sequencer mc_seqr;
router_scoreboard sbd;

function  new (string name = "router_tb" , uvm_component parent );
    super.new(name , parent);
endfunction


function  void build_phase(uvm_phase phase) ;
super.build_phase(phase);
`uvm_info("router_tb", "buildphase completed" , UVM_HIGH )

//setting the variables
uvm_config_int::set(this, "ch0", "channel_id",0); 
uvm_config_int::set(this, "ch1", "channel_id", 1); 
uvm_config_int::set(this, "ch2", "channel_id", 2); 
uvm_config_int::set(this, "hbus", "num_masters", 1); 
uvm_config_int::set(this, "hbus", "num_slaves" , 0); 


//constracting the UVCs
uvc0 = yapp_uvc::type_id::create("uvc0" ,this);
ch0 = channel_env::type_id::create("ch0" ,this);
ch1 = channel_env::type_id::create("ch1" ,this);
ch2 = channel_env::type_id::create("ch2" ,this);
hbus = hbus_env::type_id::create("hbus" ,this);
clk_rst = clock_and_reset_env::type_id::create("clk_rst" ,this);
mc_seqr = mc_sequencer::type_id::create("mc_seqr" ,this);
sbd = router_scoreboard::type_id::create("sbd", this);



endfunction:build_phase


function void connect_phase (uvm_phase phase);
 super.connect_phase(phase);

//sequencers connection to mc_seqr
 mc_seqr.yapp_seqr = uvc0.agt.seqr;
 mc_seqr.hbus_seqr = hbus.masters[0].sequencer;



 //connection of analysis ports
uvc0.agt.mon.mon_port.connect(sbd.yapp_imp);
ch0.rx_agent.monitor.item_collected_port.connect(sbd.ch0_imp);
ch1.rx_agent.monitor.item_collected_port.connect(sbd.ch1_imp);
ch2.rx_agent.monitor.item_collected_port.connect(sbd.ch2_imp);
//hbus.masters[0].monitor.item_collected_port.connect(sbd.hbus_imp);





`uvm_info(get_type_name(), "connect_phase 🧑🏻‍⚖️" , UVM_FULL)
endfunction:connect_phase



function void start_of_simulation_phase(uvm_phase phase);
super.start_of_simulation_phase(phase);
`uvm_info(get_type_name(), "running start_of_simulation_phase🙏🏻" , UVM_HIGH)
endfunction





endclass:router_tb