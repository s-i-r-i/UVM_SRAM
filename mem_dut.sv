
//RAM 16x8
`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8 
module ram (clk,
            rst,
            wr_en,
            addr,
            w_data,
            rd_enb,
            rd_addr,
            r_data);

//port direction
  input clk, rst;
  

 //write signals
  input                   wr_en;
  input [(`ADDR_WIDTH-1):0] addr;
  input [(`DATA_WIDTH-1):0] w_data;

 //read signals
  input                        rd_enb;
  input      [(`ADDR_WIDTH-1):0] rd_addr;
  output reg [(`DATA_WIDTH-1):0] r_data;


 //internal memory
 reg [(`DATA_WIDTH-1):0] ram [0:(`DEPTH-1)];

 reg [`ADDR_WIDTH:0] i;

 //implementation
 always@(posedge clk) 	begin
  if (rst) begin
     r_data <= `DATA_WIDTH'd0;
	 //memory initialisation
     for (i=0;i<`DEPTH;i=i+1) 
         ram[i] <= `DATA_WIDTH'd0;
  end
  else begin
    //write logic
    if (wr_en) begin
        ram[addr] <= w_data;

	$display("time=%0t ,w_data=%od",$time,w_data);	end  end



    //read logic
    if (rd_enb)	begin
        //r_data <= ram[rd_addr];
        r_data <= ram[addr];
	$display("time=%0t ,r_data=%od",$time,r_data);
  end  
  end

endmodule

