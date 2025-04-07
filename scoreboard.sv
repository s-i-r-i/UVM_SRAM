`include  "coverages.sv"
class mem_scoreboard extends uvm_scoreboard;

`uvm_component_utils(mem_scoreboard)

    mem_seq_item ref_data;
    mem_seq_item dut_data;
mem_coverage  m_cvr;
bit [7:0] i_mon_data [$];
bit [7:0] o_mon_data [$];
real cover_report;
uvm_tlm_analysis_fifo #(mem_seq_item) any_imp_port;
uvm_tlm_analysis_fifo #(mem_seq_item) put_imp_port;
    function new(string name,uvm_component parent);  
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
       any_imp_port = new("any_imp_port",this);
       put_imp_port = new("put_imp_port",this);

       ref_data = mem_seq_item::type_id::create("ref_data",this);
       dut_data = mem_seq_item::type_id::create("dut_data",this);
        m_cvr=mem_coverage::type_id::create("m_cvr",this);
    endfunction




task run_phase(uvm_phase phase);
forever begin
fork
any_imp_port.get(ref_data);
put_imp_port.get(dut_data);
join

@(ref_data.r_data)

i_mon_data.push_front(ref_data.r_data);
@(dut_data.r_data)
o_mon_data.push_front(dut_data.r_data);
 
//	foreach(i_mon_data[i])


    if(i_mon_data == o_mon_data)

    `uvm_info("test passed",$sformatf(" i_mon_data=%0p,o_mon_data=%0p",i_mon_data ,o_mon_data),UVM_NONE)

    else

    `uvm_info("test fail",$sformatf(" i_mon_data=%0p,o_mon_data=%0p",i_mon_data ,o_mon_data),UVM_NONE)
	
m_cvr.item_data=ref_data;
m_cvr.cg.sample();
cover_report=m_cvr.cg.get_coverage();
`uvm_info("cover_report",$sformatf("coverage=%0f",cover_report),UVM_NONE)
	end
endtask
endclass
