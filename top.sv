`include "uvm_pkg.sv"

import uvm_pkg::*;

`include  "s_ram_pkg_file.sv"
import s_ram_pkg_file :: *;

`include "mem_intf.sv"

`include  "mem_dut_wrpr.sv"
`include "assertions.sv"
//`include "mem_dut.sv"
module top;
bit clk,rst;
mem_intf vif(clk,rst);
ram_dut dut(vif);


bind ram ram_assertions ram_sva(.*);

initial begin
rst=1;
clk=1;
#20;
rst=0;
end
always #10 clk=~clk; 
initial begin
uvm_config_db#(virtual mem_intf)::set(null,"*","mem_intf",vif);
end
initial begin
run_test(" ");
end
endmodule
