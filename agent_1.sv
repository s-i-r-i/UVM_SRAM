class mem_agent_1 extends uvm_agent;

`uvm_component_utils(mem_agent_1)

mem_omonitor mon_o;

function new(string name,uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
mon_o = mem_omonitor::type_id::create("mon_o",this);
`uvm_info("AGENT_1","MESSAEGE IS FROM AGENT_2 RUN PHASE WITH NONE",UVM_NONE)

endfunction
endclass
