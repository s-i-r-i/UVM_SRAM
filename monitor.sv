class mem_monitor extends uvm_monitor;

uvm_analysis_port #(mem_seq_item)item_port;
//uvm_blocking_put_port #(mem_seq_item) item_port;
virtual mem_intf vif;
mem_seq_item req;
bit [7:0] q[$];
`uvm_component_utils(mem_monitor)

function new (string name, uvm_component parent);
super.new(name,parent);
item_port = new("item_port",this);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
req=mem_seq_item::type_id::create("req",this);
if(!uvm_config_db #(virtual mem_intf)::get(this,"*","mem_intf",vif))
begin
`uvm_error("[mem_monitor]","uvm_config_db not get")
end


`uvm_info("MEM_MONITOR","MESSAEGE IS FROM MONITOR RUN PHASE WITH NONE",UVM_LOW)

endfunction

virtual task run_phase(uvm_phase phase);

forever begin

//@(vif.addr)
@(posedge vif.clk)

req.addr=vif.addr;
req.rd_addr=vif.rd_addr;
req.rd_enb=vif.rd_enb;
req.wr_en=vif.wr_en;
req.w_data=vif.w_data;

`uvm_info("mem_monitor",$sformatf("addr=%0d \t wr_en=%0b \t rd_addr=%0d \t rd_enb=%0b \t w_data=%0d",req.addr,req.wr_en,req.rd_addr,req.rd_enb,req.w_data),UVM_NONE)

begin
			      if(req.wr_en)

begin
	q.push_front(req.w_data);
	

	`uvm_info("mem_monitor",$sformatf("[w_data]q=%0p",q),UVM_NONE) 
		end
		else if (req.rd_enb)
		 begin
		req.r_data =q.pop_front();
	
	`uvm_info("mem_monitor",$sformatf("[r_data]q=%0p",q),UVM_NONE)
		`uvm_info("mem_monitor",$sformatf("[r_data]=%0d",req.r_data),UVM_NONE)

	end
	
	
item_port.write(req);
//item_port.put(req);
end
end
endtask
endclass
