class mem_coverage extends uvm_component;

`uvm_component_utils (mem_coverage)

mem_seq_item   item_data;


covergroup  cg  ;
	option.per_instance=1;
	
data: coverpoint  item_data.w_data {bins  b1={[25:45]}; 
								bins b2[2]= {[55:70]};
								bins b3[]= {[75:80],83,85,87,90};
							ignore_bins  b4=   {92,94,96,98,100};
								bins b5= default ;}



adrs:coverpoint  item_data.addr {bins  b1 = {[7:12]};
				bins b2 = {[13:15]};}
rd_e: coverpoint item_data.rd_enb {bins b1[] = {0,1};} 
wr_e: coverpoint  item_data.wr_en {bins b1 [] = {0,1};}


w_data: cross wr_e,rd_e {bins write_data =  binsof(wr_e.b1[1]) && binsof (rd_e.b1[0]);}
r_data: cross wr_e,rd_e {bins read_data =  binsof(wr_e.b1[0]) && binsof (rd_e.b1[1]);}
adrs_data: cross data,adrs {bins ad_data = !binsof (data) intersect {[13:15]};}
endgroup

					

function new (string name ,uvm_component parent);
super.new(name,parent);
cg=new();
endfunction

task run_phase(uvm_phase phase);

item_data=mem_seq_item::type_id:: create("item_data",this);
endtask

endclass
