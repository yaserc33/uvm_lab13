class yapp_uvc extends uvm_env;

`uvm_component_utils(yapp_uvc)



yapp_tx_agent agt;



function  new(string name = "yapp_uvc", uvm_component parent);
super.new(name , parent);
endfunction


function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info("env", "Build Phase!", UVM_HIGH)
agt = yapp_tx_agent::type_id::create("agt", this);


endfunction: build_phase


function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
`uvm_info("env", "connect phase!", UVM_HIGH)


endfunction



function void start_of_simulation_phase(uvm_phase phase);
super.start_of_simulation_phase(phase);
`uvm_info(get_type_name(), "running start_of_simulation_phase🙏🏻" , UVM_HIGH)
endfunction


task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("env" , "run phase", UVM_LOW)
endtask








    
endclass