class mem_seq_item extends uvm_sequence_item;


randc bit [3:0] addr;
rand bit [3:0] rd_addr;
rand bit wr_en;
rand bit rd_enb;

rand bit [7:0] w_data;
bit [7:0] r_data;
 


`uvm_object_utils_begin(mem_seq_item) 
`uvm_field_int(rd_addr,UVM_ALL_ON|UVM_DEC)
`uvm_field_int(addr,UVM_ALL_ON|UVM_DEC)
`uvm_field_int(rd_enb,UVM_ALL_ON|UVM_DEC)
`uvm_field_int(wr_en,UVM_ALL_ON|UVM_DEC)
`uvm_field_int(w_data,UVM_ALL_ON|UVM_DEC) 
`uvm_object_utils_end

function new(string name = "mem_seq_item");
super.new(name);
endfunction

constraint addr_rng{addr inside {[5:15]};}
constraint data_rang {w_data inside {[25:100]};}

endclass
						
