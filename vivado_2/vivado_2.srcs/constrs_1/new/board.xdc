# ����������ѹ�����Ż� .bit �ļ���С
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

# �ܽŷ���
set_property PACKAGE_PIN T3 [get_ports A]
set_property PACKAGE_PIN U3 [get_ports B]
set_property PACKAGE_PIN T4 [get_ports Ci]
set_property PACKAGE_PIN P2 [get_ports F]
set_property PACKAGE_PIN R1 [get_ports C]

# I/O ��׼
set_property IOSTANDARD LVCMOS18 [get_ports A]
set_property IOSTANDARD LVCMOS18 [get_ports B]
set_property IOSTANDARD LVCMOS18 [get_ports Ci]
set_property IOSTANDARD LVCMOS18 [get_ports F]
set_property IOSTANDARD LVCMOS18 [get_ports C]

# ��������
set_property PULLDOWN true [get_ports A]
set_property PULLDOWN true [get_ports B]
set_property PULLDOWN true [get_ports Ci]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[1]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[2]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[3]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[4]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[5]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[6]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[7]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets swb_IBUF[8]]