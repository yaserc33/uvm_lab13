
//------------------------------------------------------------------------------
//
// SEQUENCE: base yapp sequence - base sequence with objections from which 
// all sequences can be derived
//
//------------------------------------------------------------------------------
class yapp_base_seq extends uvm_sequence #(yapp_packet);
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_base_seq)

  // Constructor
  function new(string name="yapp_base_seq");
    super.new(name);
  endfunction

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

endclass : yapp_base_seq

//------------------------------------------------------------------------------
//
// SEQUENCE: yapp_5_packets
//
//  Configuration setting for this sequence
//    - update <path> to be hierarchial path to sequencer 
//
//  uvm_config_wrapper::set(this, "<path>.run_phase",
//                                 "default_sequence",
//                                 yapp_5_packets::get_type());
//
//------------------------------------------------------------------------------
class yapp_5_packets extends yapp_base_seq ;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_5_packets)

  // Constructor
  function new(string name="yapp_5_packets");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_5_packets sequence", UVM_LOW)
     repeat(5)
      `uvm_do(req)
  endtask
  
endclass : yapp_5_packets

       
       
             
       
 class yapp_1_seq extends yapp_base_seq;
   `uvm_object_utils(yapp_1_seq)
   
   function new (string name = "yapp_1_seq");
    
     super.new(name);
     endfunction
   
   
 task body();
   `uvm_info(get_type_name(), "Executing tag sequence", UVM_LOW)

   `uvm_do_with(req, {addr == 1;})
   
  endtask
       
 endclass : yapp_1_seq
    
    
    




 class yapp_88_seq extends yapp_base_seq;
   `uvm_object_utils(yapp_88_seq)
   
   function new (string name = "yapp_88_seq");
     super.new(name);
   endfunction : new
   
   
 task body();
   `uvm_info(get_type_name(), "Executing tag sequence", UVM_LOW)

    `uvm_create(req)
    req.addr1.constraint_mode(0);
    for (int i=1; i<=22; ++i) begin
      for (int j=1; j<=3; ++j) begin

     
     `uvm_rand_send_with(req, {addr == j; length == i;})
      
      end
    end

   
   
 endtask : body
       
 endclass : yapp_88_seq
           
           
           
           
           
           
           
       
 class yapp_012_seq extends yapp_base_seq ;
   `uvm_object_utils(yapp_012_seq)
   
   function new (string name = "yapp_012_seq");
    
     super.new(name);
     endfunction
   
   
 task body();
   `uvm_info(get_type_name(), "Executing tag sequence", UVM_LOW)
   
   `uvm_do_with(req, {addr == 0;})
                   `uvm_do_with(req, {addr == 1;})
                         `uvm_do_with(req, {addr == 2;})
                       
   
  endtask
       
 endclass : yapp_012_seq
       
     
   
   
   
   
  
    
    
    
    
           
 class yapp_111_seq extends yapp_base_seq  ;
   `uvm_object_utils(yapp_111_seq)
   
   function new (string name = "yapp_111_seq");
    
     super.new(name);
     endfunction
   
   
 task body();
   `uvm_info(get_type_name(), "Executing tag sequence", UVM_LOW)
    
   repeat (3)  begin
     `uvm_do_with(req, {addr == 1;})
     
   end
   
   
  endtask
       
       
     
   
   
   
   
 endclass :yapp_111_seq
                  
                  
                  
                  
                  
      
           
 class yapp_repeat_addr_seq extends yapp_base_seq  ;
   `uvm_object_utils(yapp_repeat_addr_seq)
   
   
   
   int x =0;
   
   function new (string name = "yapp_repeat_addr_seq");
    
     super.new(name);
     endfunction
   
   
 task body();
   `uvm_info(get_type_name(), "Executing tag sequence", UVM_LOW)
    
   
   
   x= $urandom_range(0,2 );
   repeat (2)  begin
     `uvm_do_with(req, {addr == x;}  )
   end
   
   
  endtask
       
       
     
   
   
   
   
 endclass :yapp_repeat_addr_seq                
                  
                  
                  
                  
                  
                  
                  
                  
                  
                             
class yapp_incr_payload_seq extends yapp_base_seq ;
   `uvm_object_utils(yapp_incr_payload_seq)
   
  function new (string name = "yapp_incr_payload_seq");
    
     super.new(name);
     endfunction
   
   
 task body();
   `uvm_info(get_type_name(), "Executing tag sequence", UVM_LOW)
    
   `uvm_create(req)
   req.randomize();
        req.print();
   		foreach (req.payload[i]) 
          req.payload[i]++;
                 
        req.set_parity();
        req.print();
   `uvm_send(req)
   
   
  endtask
       
       
     
   
   
   
   
 endclass :yapp_incr_payload_seq
                  
                  

    
    
    
    
    
    
    
    
//     yapp_exhaustive_seq – execute all sequences to 
// test (Do all of your user-defined sequences). 
    
    
    
class yapp_exhaustive_seq extends yapp_base_seq ;
  `uvm_object_utils(yapp_exhaustive_seq)
  
    yapp_1_seq             seq_1        ;
    yapp_012_seq           seq_012      ;
    yapp_111_seq           seq_111      ;
    yapp_repeat_addr_seq   seq_repeat   ;
    yapp_incr_payload_seq  seq_incr     ;


  function new(string name = "yapp_exhaustive_seq");
    super.new(name);
  endfunction
  
  task body();

    


    `uvm_do(seq_1)
    `uvm_do(seq_012)
    `uvm_do(seq_111)
    `uvm_do(seq_repeat)
    `uvm_do(seq_incr)
   
  endtask
  
endclass : yapp_exhaustive_seq

                     
    