#This file must have the same name as your project

#Make input Clock a clock and set frequency to 50MHz (20ns period)
create_clock -name {Clock} -period 20 [get_ports {Clock}]
