set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]  

set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS18} [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0 5} [get_ports clk]

set_property IOSTANDARD LVCMOS18 [get_ports mclk]       
set_property PACKAGE_PIN R4 [get_ports mclk]   
set_property IOSTANDARD LVCMOS18 [get_ports rst]       
set_property PACKAGE_PIN AA4 [get_ports rst]
set_property IOSTANDARD LVCMOS18 [get_ports Write_Reg]       
set_property PACKAGE_PIN AB6 [get_ports Write_Reg]            
        


#ÊýÂë¹Ü
set_property IOSTANDARD LVCMOS18 [get_ports seg]
set_property PACKAGE_PIN H19 [get_ports {seg[7]}]
set_property PACKAGE_PIN G20 [get_ports {seg[6]}]
set_property PACKAGE_PIN J22 [get_ports {seg[5]}]
set_property PACKAGE_PIN K22 [get_ports {seg[4]}]
set_property PACKAGE_PIN K21 [get_ports {seg[3]}]
set_property PACKAGE_PIN H20 [get_ports {seg[2]}]
set_property PACKAGE_PIN H22 [get_ports {seg[1]}]
set_property PACKAGE_PIN J21 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports which]
set_property PACKAGE_PIN N22 [get_ports {which[0]}]
set_property PACKAGE_PIN M21 [get_ports {which[1]}]
set_property PACKAGE_PIN M22 [get_ports {which[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN L21} [get_ports enable]


set_property SEVERITY {Warning} [get_drc_checks UCIO-1]