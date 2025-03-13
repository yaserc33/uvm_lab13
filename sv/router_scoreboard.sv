class router_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(router_scoreboard)




  ////////////////declaring the analysis port//////////////////
  `uvm_analysis_imp_decl(_yapp)
  `uvm_analysis_imp_decl(_ch0)
  `uvm_analysis_imp_decl(_ch1)
  `uvm_analysis_imp_decl(_ch2)
  //`uvm_analysis_imp_decl(_hbus)

  uvm_analysis_imp_yapp#(yapp_packet , router_scoreboard) yapp_imp;
  uvm_analysis_imp_ch0#(channel_packet , router_scoreboard) ch0_imp;
  uvm_analysis_imp_ch1#(channel_packet , router_scoreboard) ch1_imp;
  uvm_analysis_imp_ch2#(channel_packet , router_scoreboard) ch2_imp;
//  uvm_analysis_imp_hbus#(hbus_packet , router_scoreboard) hbus_imp;
////////////////////////////////////////////////////////////////////




    function new(string name= "router_scoreboard" , uvm_component parent);
        super.new(name,  parent);
        yapp_imp = new("yapp_imp" ,this); 
        ch0_imp = new("ch0_imp" ,this); 
        ch1_imp = new("ch1_imp" ,this); 
        ch2_imp = new("ch2_imp" ,this); 
//        hbus_imp = new("hbus_imp" ,this); 
    endfunction :new


    yapp_packet q0[$];
    yapp_packet q1[$];
    yapp_packet q2[$];
    int yapp_count =0 ;


    function void write_yapp (yapp_packet pkt);
    
    yapp_packet pkt_copy;

    // Early exit if parity is bad or if the packet is for address 3.
    if (pkt.parity_type == bad_parity || pkt.addr ==3 || pkt.length ==0) 
        return;

    $cast(pkt_copy , pkt.clone());
    case (pkt.addr)
        0: begin
            q0.push_back(pkt_copy);
            `uvm_info(get_type_name() ,"send packet to q0.. ", UVM_MEDIUM )
        end 

       1: begin
            q1.push_back(pkt_copy);
            `uvm_info(get_type_name() ,"send packet to q1.. ", UVM_MEDIUM )
        end
        
       2: begin
            q2.push_back(pkt_copy);
            `uvm_info(get_type_name() ,"send packet to q2.. ", UVM_MEDIUM )
        end         
    endcase

    yapp_count++;
    
    endfunction:write_yapp

    int err=0;
    int ch_count;

    function void write_ch0 (channel_packet pkt);
        yapp_packet ypkt;
        ypkt = q0.pop_front();
        if (!comp_equal (ypkt ,pkt))begin
            ++err;
            `uvm_warning(get_type_name() ,"mismach at  packet recived from ch0 .. " )
        end
        ch_count++;
    endfunction:write_ch0

    function void write_ch1 (channel_packet pkt);
        yapp_packet ypkt;
        ypkt = q1.pop_front();
        if (!comp_equal (ypkt ,pkt))begin
            ++err;
            `uvm_warning(get_type_name() ,"mismach at  packet recived from ch0 .. " )
        end
    
        ch_count++;
    endfunction:write_ch1

    function void write_ch2 (channel_packet pkt);
        yapp_packet ypkt;
        ypkt = q2.pop_front();
        if (!comp_equal (ypkt ,pkt))begin
            ++err;
            `uvm_warning(get_type_name() ,"mismach at  packet recived from ch0 .. ")
        end
    
        ch_count++;
    endfunction:write_ch2



    
    //function void write_hbus (hbus_packet pkt);


    //endfunction:write_hbus



    function bit comp_equal (input yapp_packet yp, input channel_packet cp);
      // returns first mismatch only
      if (yp.addr != cp.addr) begin
        `uvm_error("PKT_COMPARE",$sformatf("Address mismatch YAPP %0d Chan %0d",yp.addr,cp.addr))
        return(0);
      end
      if (yp.length != cp.length) begin
        `uvm_error("PKT_COMPARE",$sformatf("Length mismatch YAPP %0d Chan %0d",yp.length,cp.length))
        return(0);
      end
      foreach (yp.payload [i])
        if (yp.payload[i] != cp.payload[i]) begin
          `uvm_error("PKT_COMPARE",$sformatf("Payload[%0d] mismatch YAPP %0d Chan %0d",i,yp.payload[i],cp.payload[i]))
          return(0);
        end
    //   if (yp.parity != cp.parity ) begin
    //     `uvm_error("PKT_COMPARE",$sformatf("Parity mismatch YAPP %0d Chan %0d",yp.parity,cp.parity))
    //     return(0);
    //  end
      return(1);
    endfunction :comp_equal


function void report_phase(uvm_phase phase);
  super.report_phase(phase);

    `uvm_info(get_type_name(),"printing report",UVM_NONE)

    $display("\n****************** TEST REPORT ******************\n");



   $display("Packets Summary:\n");
   $display( "   - Yapp Packets   : %0d\n",yapp_count);
   $display( "   - Channel Packets: %0d\n",ch_count);
   $display( "   - Number of Mismatches: %0d\n",err);
      

  if (err || yapp_count != ch_count) begin
      $display("\n==================================================\n",
      "                   TEST FAILED ❌\n",
      "==================================================\n");
  end else begin
      $display("\n==================================================\n",
      "                    TEST PASS ✅\n",
      "==================================================\n");

  end


    $display("\n****************** END OF REPORT ******************\n");

endfunction : report_phase



endclass :router_scoreboard