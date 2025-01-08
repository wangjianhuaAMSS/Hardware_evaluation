# Script file for constraining encryption
set module_name Mantis
#set check_design_rpt_file "${module_name}_design.rpt"
set report_area_rpt_file 	"${module_name}_report_area.rpt"
#set report_design_rpt_file 	"${module_name}_report_design.rpt"
set report_cell_rpt_file 	"${module_name}_report_cell.rpt"
set report_reference_rpt_file  "${module_name}_report_reference.rpt"
#set report_port_rpt_file 	"${module_name}_report_port.rpt"
#set report_net_rpt_file 	"${module_name}_report_net.rpt"
#set report_compile_options_rpt_file "${module_name}_report_compile_options.rpt"
#set report_constraint_rpt_file "${module_name}_report_constraint.rpt"
set report_timing_rpt_file "${module_name}_report_timing.rpt"
set report_timing_maxpath_rpt_file "${module_name}_report_timing_maxpath.rpt"
#set report_qor_rpt_file "${module_name}_report_qor.rpt"

set design 		"${module_name}"
current_design 	${module_name}

# Need modify: No
source "${script_path}/defaults.con"

# Flatten
ungroup -flatten -all
# Preventing multi-output ports
set_fix_multiple_port_nets -all -buffer_constants


set_host_options -max_cores 8

#compile
compile_ultra -no_autoungroup
compile_ultra -incremental -no_autoungroup
compile_ultra -incremental -no_autoungroup
compile_ultra -incremental -no_autoungroup

# uniquify
uniquify -force

# Writing synthesized design
file mkdir Netlist_45nm
write -format verilog -hierarchy -output "Netlist_45nm/${design}.v"

if {[shell_is_in_xg_mode] == 0} {
write -hier -o "${db_path}/${design}.db"
} else {
write -format ddc -hier -o "${ddc_path}/${design}.ddc"
}

#Need Modify: No
source "${script_path}/report.tcl"