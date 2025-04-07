class mem_sequence extends uvm_sequence #(mem_seq_item);

`uvm_object_utils(mem_sequence)
mem_seq_item req1,req2;
function new(string name = "mem_sequence");
super.new(name);
endfunction

virtual task body();

req1 =mem_seq_item :: type_id :: create ("req1");
req2 =mem_seq_item :: type_id :: create ("req2");
repeat (10) begin

//`uvm_do(req);
`uvm_do_with (req1 ,{wr_en==1 ; rd_enb ==0;})



`uvm_do_with (req2 ,{wr_en==0 ;
			rd_enb ==1;
			foreach(addr[i])
			addr[i]== req1.addr[i];})


//`uvm_do_with(req,{rd_enb==1; wr_en dist {1 := 90 ,0 := 10 }; })

end
endtask
endclass

