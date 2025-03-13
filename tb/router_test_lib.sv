class base_test  extends uvm_test;

`uvm_component_utils(base_test)
uvm_objection obj;

function new(string name ="base_test" , uvm_component parent);
super.new(name,parent);

endfunction :new


router_tb tb;
function void build_phase (uvm_phase phase);
super.build_phase(phase);
tb = router_tb::type_id::create("tb" , this);

`uvm_info("base_test", "build_phase completed" , UVM_HIGH )
endfunction :build_phase





function void check_phase (uvm_phase phase);
`uvm_info(get_type_name(), "running check_phase✅" , UVM_HIGH)
check_config_usage(); 


endfunction:check_phase



function void end_of_elaboration_phase (uvm_phase phase);

uvm_top.print_topology();


endfunction :end_of_elaboration_phase





virtual task run_phase(uvm_phase phase);
    
  obj = phase.get_objection(); 
  obj.set_drain_time(this, 200ns);
  `uvm_info(get_type_name() , "run phase", UVM_HIGH)

endtask




endclass :base_test

//////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////


class simple_test extends base_test;

  `uvm_component_utils(simple_test)
  function new(string name ="simple_test" , uvm_component parent);
super.new(name,parent);

  endfunction:new


function void build_phase (uvm_phase phase);
  super.build_phase(phase);

  //set_type_override_by_type(yapp_packet::get_type() , short_yapp_packet::get_type());
  uvm_config_wrapper::set(this, "*uvc0.agt.seqr.run_phase",  "default_sequence", yapp_012_seq::get_type()); 
  uvm_config_wrapper::set(this, "*ch*",  "default_sequence", channel_rx_resp_seq::get_type()); 
  uvm_config_wrapper::set(this, "*clk_rst*",  "default_sequence", clk10_rst5_seq::get_type()); 

  uvm_config_int::set( this, "*", "recording_detail", 1); 
    `uvm_info(get_type_name(), "build_phase completed" , UVM_HIGH )
endfunction:build_phase


//yapp_012_seq  yapp_012;


task run_phase(uvm_phase phase);
  
  super.run_phase(phase);
  


  //----------------another ways to start SEQs ------------------------------//////////////
  // yapp_012 = yapp_012_seq::type_id::create("yapp_012");
  // phase.raise_objection(this);
  // yapp_012.start(tb.uvc0.agt.seqr);
  // phase.drop_objection(this);

endtask :run_phase




endclass : simple_test


///////////////////////////////////////////////////////////////////////////////////////////////////

class test_uvc_integration extends base_test;

  `uvm_component_utils(test_uvc_integration)
  function new(string name ="test_uvc_integration" , uvm_component parent);
super.new(name,parent);

  endfunction:new


function void build_phase (uvm_phase phase);
  super.build_phase(phase);

  uvm_config_wrapper::set(this, "*uvc0.agt.seqr.run_phase",  "default_sequence", yapp_88_seq::get_type()); 
  uvm_config_wrapper::set(this, "*ch*",  "default_sequence", channel_rx_resp_seq::get_type()); 
  uvm_config_wrapper::set(this, "*clk_rst*",  "default_sequence", clk10_rst5_seq::get_type()); 
  uvm_config_wrapper::set(this, "*hbus.master[0].sequencer.run_phase",  "default_sequence", hbus_small_packet_seq::get_type()); 
  

  uvm_config_int::set( this, "*", "recording_detail", 1); 
    `uvm_info(get_type_name(), "build_phase completed" , UVM_HIGH )
endfunction:build_phase




task run_phase(uvm_phase phase);
  
  super.run_phase(phase);
  //set_type_override_by_type(yapp_packet::get_type() , short_yapp_packet::get_type());




endtask :run_phase




endclass : test_uvc_integration

///////////////////////////////////////////////////////////////////////////////////////////////////////


//to test mc_seq & mc_seqr ////////
class mc_test extends base_test;

  `uvm_component_utils(mc_test)
  function new(string name ="mc_test" , uvm_component parent);
super.new(name,parent);

  endfunction:new


function void build_phase (uvm_phase phase);
  super.build_phase(phase);
  set_type_override_by_type(yapp_packet::get_type() , short_yapp_packet::get_type());


  uvm_config_wrapper::set(this, "*mc_seqr.run_phase",  "default_sequence", router_simple_mcseq::get_type()); 
  uvm_config_wrapper::set(this, "*ch*",  "default_sequence", channel_rx_resp_seq::get_type()); 
  uvm_config_wrapper::set(this, "*clk_rst*",  "default_sequence", clk10_rst5_seq::get_type()); 
  

  uvm_config_int::set( this, "*", "recording_detail", 1); 
    `uvm_info(get_type_name(), "build_phase completed" , UVM_HIGH )
endfunction:build_phase






endclass : mc_test


