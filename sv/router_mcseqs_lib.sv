class router_simple_mcseq extends uvm_sequence;
    
    `uvm_object_utils(router_simple_mcseq)
  
   //declare the multichannel_sequencer
    `uvm_declare_p_sequencer(mc_sequencer)


    function new(string name ="router_simple_mcseq");
        super.new(name);
    endfunction:new

task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body


//declare the sequences you want to use


hbus_small_packet_seq h_small;      // SEQUENCE: hbus_small_packet_seq - max_pkt_reg = 20, enable_reg = 1
hbus_set_default_regs_seq h_big;    // SEQUENCE: hbus_set_default_regs_seq - max_pkt_reg = 63, enable_reg = 1

hbus_get_yapp_regs_seq h_read;      // SEQUENCE: hbus_get_yapp_regs_seq - reads the max_pkt_reg and enable_reg
 
yapp_012_seq yapp_012;              //send a packet data to adder 0 then adder 1 then adder 2 


//in task body() do the SEQs in the targeted seqr
virtual task body;
`uvm_info(get_type_name(), "body of mc_sequence 🧑🏻‍⚖️" , UVM_FULL)

`uvm_do_on(h_small, p_sequencer.hbus_seqr)
`uvm_do_on(h_read , p_sequencer.hbus_seqr)
`uvm_do_on(yapp_012 , p_sequencer.yapp_seqr)
`uvm_do_on(yapp_012 , p_sequencer.yapp_seqr)

`uvm_do_on(h_big, p_sequencer.hbus_seqr)
`uvm_do_on(h_read , p_sequencer.hbus_seqr)
`uvm_do_on(yapp_012 , p_sequencer.yapp_seqr)
`uvm_do_on(yapp_012 , p_sequencer.yapp_seqr)

endtask:body








endclass: router_simple_mcseq