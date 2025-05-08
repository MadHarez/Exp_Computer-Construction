# 开启比特流压缩，优化 .bit 文件大小
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

# 管脚分配
set_property PULLDOWN true [get_ports A]
set_property IOSTANDARD LVCMOS18 [get_ports A]
set_property PACKAGE_PIN T3 [get_ports {A[0]}]
set_property PACKAGE_PIN U3 [get_ports {A[1]}]
set_property PACKAGE_PIN T4 [get_ports {A[2]}]
set_property PACKAGE_PIN V3 [get_ports {A[3]}]

set_property PULLDOWN true [get_ports B]
set_property IOSTANDARD LVCMOS18 [get_ports B]
set_property PACKAGE_PIN Y1 [get_ports {B[0]}]
set_property PACKAGE_PIN AA1 [get_ports {B[1]}]
set_property PACKAGE_PIN V2 [get_ports {B[2]}]
set_property PACKAGE_PIN Y2 [get_ports {B[3]}]

set_property IOSTANDARD LVCMOS18 [get_ports c0]
set_property PACKAGE_PIN R4 [get_ports c0]                         

set_property IOSTANDARD LVCMOS18 [get_ports F]
set_property PACKAGE_PIN R1 [get_ports {F[0]}]
set_property PACKAGE_PIN P2 [get_ports {F[1]}]
set_property PACKAGE_PIN P1 [get_ports {F[2]}]
set_property PACKAGE_PIN N2 [get_ports {F[3]}]

set_property IOSTANDARD LVCMOS18 [get_ports c4]
set_property PACKAGE_PIN M2 [get_ports c4]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[1]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[2]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[3]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[4]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[5]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[6]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[7]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[8]]
