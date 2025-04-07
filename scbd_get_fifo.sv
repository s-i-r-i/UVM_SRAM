
class mem_scoreboard extends uvm_scoreboard;

`uvm_component_utils(mem_scoreboard)

    mem_seq_item ref_data;
    mem_seq_item dut_data;
uvm_blocking_get_port #(mem_seq_item) any_imp_port;
uvm_blocking_get_port #(mem_seq_item) put_imp_port;

    function new(string name,uvm_component parent);  
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
       any_imp_port = new("any_imp_port",this);
       put_imp_port = new("put_imp_port",this);

       ref_data = mem_seq_item::type_id::create("ref_data",this);
       dut_data = mem_seq_item::type_id::create("dut_data",this);
        
    endfunction

task run_phase(uvm_phase phase);

//forever begin
//@(ref_data.r_data)
repeat (10)  begin
fork
any_imp_port.get(ref_data);
put_imp_port.get(dut_data);
join
   @(ref_data.r_data );
    if(ref_data.r_data == dut_data.r_data)

    `uvm_info("test passed",$sformatf(" ref_data.r_data=%0d,dut_data.r_data=%0d",ref_data.r_data,dut_data.r_data),UVM_NONE)

    else

    `uvm_info("test not pass",$sformatf(" ref_data.r_data=%0d,dut_data.r_data=%0d",ref_data.r_data,dut_data.r_data),UVM_NONE)
	end

endtask
endclass