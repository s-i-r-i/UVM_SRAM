class mem_omonitor extends uvm_monitor;
uvm_analysis_port #(mem_seq_item) item_put_port;

//uvm_blocking_put_port #(mem_seq_item) item_put_port;
virtual mem_intf vif;
mem_seq_item req;

`uvm_component_utils(mem_omonitor)

function new (string name, uvm_component parent);
super.new(name,parent);
item_put_port = new("item_put_port",this);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
req=mem_seq_item::type_id::create("req",this);
if(!uvm_config_db #(virtual mem_intf)::get(this,"*","mem_intf",vif))
begin
`uvm_error("[mem_omonitor]","uvm_config_db not get")
end


`uvm_info("MEM_oMONITOR","MESSAEGE IS FROM MONITOR RUN PHASE WITH NONE",UVM_FULL)
endfunction

virtual task run_phase(uvm_phase phase);
forever begin

//@(vif.r_data);
@(posedge vif.clk)


req.r_data=vif.r_data;
	`uvm_info("mem_monitor",$sformatf("r_data=%0d",req.r_data),UVM_NONE)

//item_put_port.put(req);
item_put_port.write(req);
end
endtask
endclass
