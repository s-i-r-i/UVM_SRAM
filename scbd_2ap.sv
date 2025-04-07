`uvm_analysis_imp_decl(_input_mon)
`uvm_analysis_imp_decl(_output_mon)
class mem_scoreboard extends uvm_scoreboard;

`uvm_component_utils(mem_scoreboard)

    mem_seq_item ref_data;
    mem_seq_item dut_data;

uvm_analysis_imp_input_mon #(mem_seq_item,mem_scoreboard)  any_imp_port;
uvm_analysis_imp_output_mon #(mem_seq_item,mem_scoreboard)  put_imp_port;
    function new(string name,uvm_component parent);  
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
       any_imp_port = new("any_imp_port",this);
       put_imp_port = new("put_imp_port",this);

       ref_data = mem_seq_item::type_id::create("ref_data",this);
       dut_data = mem_seq_item::type_id::create("dut_data",this);
        
    endfunction
	
	task write_input_mon(mem_seq_item ref_data);
	
	this.ref_data=ref_data;
	    `uvm_info("ref_data from i_mon",$sformatf(" ref_data.r_data=%0d",ref_data.r_data),UVM_NONE)

	endtask
	
	task write_output_mon(mem_seq_item dut_data);
	this.dut_data=dut_data;
		    `uvm_info("dut_data from o_mon",$sformatf(" dut_data.r_data=%0d",dut_data.r_data),UVM_NONE)

	
	endtask

task run_phase(uvm_phase phase);

	forever begin 
   @(ref_data.r_data , dut_data.r_data );
    if(ref_data.r_data == dut_data.r_data)

    `uvm_info("test passed",$sformatf(" ref_data.r_data=%0d,dut_data.r_data=%0d",ref_data.r_data,dut_data.r_data),UVM_NONE)

    else

    `uvm_info("test not pass",$sformatf(" ref_data.r_data=%0d,dut_data.r_data=%0d",ref_data.r_data,dut_data.r_data),UVM_NONE)
	end
endtask
endclass
