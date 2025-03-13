typedef enum bit { good_parity , bad_parity } parity_enum;

class yapp_packet extends uvm_sequence_item ;

rand bit [5:0] length ;
rand bit [1:0] addr;
rand bit [7:0] payload[];
     bit [7:0] parity;
rand parity_enum parity_type;
rand int packet_delay;

constraint addr1 {addr != 3; }
constraint length1 { length > 0; length == payload.size(); }
constraint parity1 {parity_type dist {good_parity:=5 ,bad_parity:=1}; }
constraint delay1 {packet_delay inside {[1:20]};}


     
     
     `uvm_object_utils_begin(yapp_packet)

        `uvm_field_int(length, UVM_DEFAULT + UVM_DEC)
        `uvm_field_int(addr, UVM_DEFAULT)
        `uvm_field_array_int(payload, UVM_DEFAULT)
        `uvm_field_int(parity, UVM_DEFAULT)
        `uvm_field_enum(parity_enum,parity_type, UVM_DEFAULT)
        `uvm_field_int(packet_delay, UVM_DEFAULT | UVM_NOCOMPARE)

     `uvm_object_utils_end


     function new (string name = "yapp_packet") ;
        super.new(name);
     endfunction


    function bit[7:0] calc_parity ();
        parity = {length, addr};
        for (int i=0; i<length; i++) begin
            parity = parity ^ payload[i];
        end
        //$display("⭐⭐⭐⭐parity:%h" , parity);
        return parity;
    endfunction


    //control knob (to send inject bad parity )


    function void set_parity();
    parity = calc_parity();

    if (parity_type == bad_parity)
            parity= ~parity;    

    endfunction

    
    
    
    function void post_randomize();

    set_parity();

    endfunction :post_randomize

endclass



class short_yapp_packet extends yapp_packet ;

 `uvm_object_utils(short_yapp_packet)
   
   function new (string name = "short_yapp_packet") ;
        super.new(name);
     endfunction

//constraint addr2 {addr != 2; }
constraint length2 {length < 15; }



endclass





