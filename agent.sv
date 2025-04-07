class mem_agent extends uvm_agent;

`uvm_component_utils(mem_agent)
mem_sequencer seq_h;
driver drv_h;
mem_monitor mon_h;


function new(string name,uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
seq_h = mem_sequencer::type_id::create("seq_h",this);
drv_h = driver::type_id::create("drv_h",this);
mon_h = mem_monitor::type_id::create("mon_h",this);
`uvm_info("AGENT","MESSAEGE IS FROM AGENT_1 RUN PHASE WITH NONE",UVM_NONE)
endfunction

function void connect_phase(uvm_phase phase);
drv_h.seq_item_port.connect(seq_h.seq_item_export);

endfunction

endclass
