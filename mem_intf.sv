interface mem_intf (input logic clk,rst);

logic [3:0] addr;
 logic wr_en ;
 logic [7:0] w_data;
 logic [7:0] r_data;
 logic  rd_enb;
 logic [3:0] rd_addr;

 
 modport dut (input clk,rst,addr,wr_en,w_data,rd_addr,rd_enb,output r_data);
 modport tb (output addr,wr_en,w_data,rd_addr,rd_enb,input r_data ,clk,rst);
 
 endinterface
