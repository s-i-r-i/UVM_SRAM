`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8 


module ram_assertions(clk,rst,wr_en,addr,w_data,rd_enb,r_data);
           /* rst,
            wr_en,
            addr,
            w_data,
            rd_enb,
            r_data);*/

//port direction
  input clk, rst;
  

 //write signals
  input                   wr_en;
  input [(`ADDR_WIDTH-1):0] addr;
  input [(`DATA_WIDTH-1):0] w_data;

 //read signals
  input                        rd_enb;
  input [(`DATA_WIDTH-1):0] r_data;
  

  property rstt;

@(posedge clk) rst|-> r_data==0;
  endproperty
reset:assert property (rstt);

property wr_data;
@(posedge clk) disable iff(rst)

$rose(wr_en) |-> !$isunknown(addr && w_data)

endproperty

data: assert property (wr_data);

property rd_data;
@(posedge clk) disable iff(rst)

$rose(rd_enb) |-> !$isunknown(addr) |=>!$isunknown(r_data);

endproperty

rdata: assert property (rd_data);




endmodule
