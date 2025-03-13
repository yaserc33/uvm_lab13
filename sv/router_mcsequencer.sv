class mc_sequencer extends uvm_sequencer;
    
    `uvm_component_utils(mc_sequencer)


   //declare all the seqer u plan to use 
   uvm_sequencer#(yapp_packet) yapp_seqr;
   hbus_master_sequencer   hbus_seqr;
   
    function new(string name = "mc_sequencer" , uvm_component parent );
    super.new(name, parent);        
    endfunction :new



endclass:mc_sequencer