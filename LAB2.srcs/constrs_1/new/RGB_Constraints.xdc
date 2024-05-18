#Constraints file for use with the RGB design
# Change the signal name in the {} brackets after get_ports to your signal name
# Comment signals nod used, uncomment the ones needed

############################
# On-board Push Buttons    #
############################
set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports { "but_red" }]; # btn 0
set_property -dict { PACKAGE_PIN D20   IOSTANDARD LVCMOS33 } [get_ports { "but_grn" }]; # btn 1
set_property -dict { PACKAGE_PIN L20   IOSTANDARD LVCMOS33 } [get_ports { "but_blu" }]; # btn 2
set_property -dict { PACKAGE_PIN L19   IOSTANDARD LVCMOS33 } [get_ports { "but-dc" }];  # btn 3

############################
# On-board Switches        #
############################
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports {sw_dc}]; # sw 0
#set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports {sw[1]}] # sw 1

############################
# On-board leds            #
############################
set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; # led 0
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; # led 1
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; # led 3
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; # led 4

set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { rgb[0] }]; # rgb 0
set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { rgb[1] }]; # rgb 1
set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { rgb[2] }]; # rgb 3
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { rgb[3] }]; # rgb 0
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { rgb[4] }]; # rgb 1
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { rgb[5] }]; # rgb 3

############################
# 125 MHz Clock            #
############################
set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { clk }];
# Clock timing
create_clock -period 8.000 -waveform (0.000 4.000) [get_ports clk]

############################
#    Fix Errors and Keep   #
#  Bitstream Writer Happy  #
############################
set_property SEVERITY {Warning} [get_drc_checks LUTLP-1]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets ];
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ];
