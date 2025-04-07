 `include "mem_dut.sv"

module ram_dut(mem_intf.dut vif);
ram  tbb (.addr(vif.addr),.w_data(vif.w_data),.r_data(vif.r_data),.wr_en(vif.wr_en) ,.rd_enb(vif.rd_enb),.rd_addr(vif.rd_addr),.clk(vif.clk),.rst(vif.rst));
initial 
begin
$display("------------dut-------------");
end

endmodule 


