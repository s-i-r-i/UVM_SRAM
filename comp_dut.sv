module comp_dut(comp_intf.dut vif);
input vif.a,vif.b;
output vif.g,vif.l,vif.e;
//assign g=(a>b);
//assign e= (a==b);
//assign l=(a<b);

assign vif.g=vif.a&~vif.b;
assign vif.e=~(vif.a^vif.b);

assign vif.l=~vif.a&vif.b;
endmodule



module comp_2bit(vif.a,vif.b,vif.g,vif.l,vif.e);
input [0:1]vif.a,vif.b;
output [0:1]vif.g,vif.l;
output vif.e;
wire w1,w2;
comp_dut c1(vif.a[1],vif.b[1],vif.g[1],vif.l[1],w1);
comp_dut c2(vif.a[0],vif.b[0],vif.g[0],vif.l[0],w2);
and (vif.e,w1,w2);
endmodule