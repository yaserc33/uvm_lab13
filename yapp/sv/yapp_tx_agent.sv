class yapp_tx_agent extends uvm_agent;

`uvm_component_utils_begin(yapp_tx_agent)
`uvm_field_enum(uvm_active_passive_enum , is_active , UVM_ALL_ON)
`uvm_component_utils_end



yapp_tx_driver drv;
yapp_tx_monitor mon;
//yapp_tx_sequencer seqr;
uvm_sequencer#(yapp_packet) seqr;

function  new(string name = "yapp_tx_agent", uvm_component parent);
super.new(name , parent);

endfunction


function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info("agt", "Build Phase!", UVM_HIGH)
mon = yapp_tx_monitor::type_id::create("mon", this);

if (is_active == UVM_ACTIVE) begin
drv = yapp_tx_driver::type_id::create("drv", this);
//seqr = yapp_tx_sequencer::type_id::create("seqr", this);
seqr  =  uvm_sequencer#(yapp_packet)::type_id::create("seqr",this);

end

endfunction: build_phase


function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
`uvm_info("agt", "connect phase!", UVM_HIGH)


    if (is_active == UVM_ACTIVE)
        drv.seq_item_port.connect(seqr.seq_item_export);


endfunction



function void start_of_simulation_phase(uvm_phase phase);
super.start_of_simulation_phase(phase);
`uvm_info(get_type_name(), "running start_of_simulation_phase🙏🏻" , UVM_HIGH)
endfunction


task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("agt" , "run phase", UVM_HIGH)
endtask








    
endclass