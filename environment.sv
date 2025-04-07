class mem_model_env extends uvm_env;

mem_agent agent_1;
mem_agent_1 agent_2;
mem_scoreboard  scbd;
//uvm_tlm_fifo #(mem_seq_item) tlm_fifo;
//uvm_tlm_fifo #(mem_seq_item) tlm_fifo;
`uvm_component_utils(mem_model_env)

function new(string name,uvm_component parent);
super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
super.build_phase(phase);
agent_1 = mem_agent :: type_id :: create("agent_1",this);
agent_2 = mem_agent_1 :: type_id :: create("agent_2",this);
scbd=mem_scoreboard::type_id::create("scbd",this);
//tlm_fifo=new("tlm_fifo",this,2);
endfunction

function void connect_phase(uvm_phase phase);
 
/*agent_1.mon_h.item_port.connect(tlm_fifo.put_export);
scbd.any_imp_port.connect(tlm_fifo.get_export);

agent_2.mon_o.item_put_port.connect(tlm_fifo.put_export);
scbd.put_imp_port.connect(tlm_fifo.get_export);*/ 
 
agent_1.mon_h.item_port.connect(scbd.any_imp_port.analysis_export);
agent_2.mon_o.item_put_port.connect(scbd.put_imp_port.analysis_export); 
//agent_1.mon_h.item_port.connect(scbd.any_imp_port);
//agent_2.mon_o.item_put_port.connect(scbd.put_imp_port); 
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
super.end_of_elaboration_phase(phase);
`uvm_info("mem_model_env","MESSAGE IS FROM ENVIRONMENT ELABORATION PHASE WITH NONE",UVM_LOW)
uvm_top.print_topology();
endfunction

endclass 
