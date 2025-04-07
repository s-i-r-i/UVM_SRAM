class driver extends uvm_driver#(mem_seq_item);

`uvm_component_utils(driver)

function new(string name, uvm_component parent);
super.new(name,parent);
endfunction
virtual mem_intf vif;

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(virtual mem_intf)::get(this,"*","mem_intf",vif))
begin
`uvm_error("[driver]","uvm_config_db not get")
end
endfunction


task run_phase(uvm_phase phase);
`uvm_info("DRIVER","MESSAGE IS FROM DRIVER RUN PHASE WITH NONE",UVM_NONE)

forever

 begin
 
seq_item_port.get_next_item(req); 

@(posedge vif.clk)
fork
write_data();

read_data();
join
//req.print();


seq_item_port.item_done(); 
`uvm_info("DRIVER",$sformatf("addr=%0d \t wr_en=%0b \t rd_addr=%0d \t rd_enb=%0b \t w_data=%0d",vif.addr,vif.wr_en,vif.rd_addr,vif.rd_enb,vif.w_data),UVM_LOW)





end
endtask


task write_data;
vif.wr_en = req.wr_en;
vif.rd_enb = req.rd_enb;
if(vif.wr_en==1 && vif.rd_enb ==0) begin
vif.addr=req.addr;

vif.w_data=req.w_data;	end

endtask

task read_data;
	vif.wr_en = req.wr_en;
vif.rd_enb = req.rd_enb;
if(vif.wr_en==0 && vif.rd_enb ==1)
vif.addr=req.addr;


endtask

endclass
