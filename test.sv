class mem_model_test extends uvm_test;

`uvm_component_utils(mem_model_test)

mem_model_env env;
mem_sequence seq;

function new(string name = "mem_model_test",uvm_component parent = null);
super.new(name,parent);
endfunction:new

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
env = mem_model_env::type_id::create("env",this);
`uvm_info("MEM_MODEL_TEST","MESSAEGE IS FROM TEST BUILD PHASE WITH NONE",UVM_NONE)

endfunction

task run_phase(uvm_phase phase);
seq = mem_sequence::type_id::create("seq",this);

phase.raise_objection(this);
seq.start(env.agent_1.seq_h);
phase.drop_objection(this);

endtask

endclass
