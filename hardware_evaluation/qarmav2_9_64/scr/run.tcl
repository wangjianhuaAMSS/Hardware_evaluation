# Removing current design
remove_design -all

# Need modify: Yes
# Setting environment
cd /home/xxxxxx/dctest/qarmav2_64_9-CodeTestArea

# Clean Workspace
if [file exists work] {file delete -force work}

# Define design lib
file mkdir work
define_design_lib work -path "./work"

# Define the designer and company
set designer "xxxxxx"
set company "HuaWei"

# Define the path directories for file locations
set file_path 	[concat /home/xxxxxx/dctest/qarmav2_64_9-CodeTestArea]
set script_path [concat ${file_path}/scr]
set source_path [concat ${file_path}/src]
set db_path 	[concat ${file_path}/db]
set ddc_path 	[concat ${file_path}/ddc]
set lib_path 	[concat ${file_path}/lib]
set log_path 	[concat ${file_path}/log]

# Define the search, target, link logic library
set search_path [concat ${script_path}]
set search_path [concat ${source_path}]
set search_path [concat ${db_path}]
set search_path [concat ${ddc_path}]
set search_path [concat ${lib_path}]
set search_path [concat ${log_path}]

# UMC180nmLibrary_typical
#set target_library	${lib_path}/UMC180nmLibrary_typical.db
#set link_library 	${lib_path}/UMC180nmLibrary_typical.db

# NanGate45nm
set target_library	${lib_path}/NangateOpenCellLibrary_fast.db
set link_library    [concat * $target_library]

get_libs

# Need modify: Yes
# Initial compile with estimated constraints
# Read verilog or vhdl
set top_design qarmav2_64
set source_file [sh find ./src/*.v]
analyze -format verilog -library work ${source_file}
elaborate -library work $top_design
link

#Need modify: Yes
# report each file
source "${script_path}/qarmav2_64.tcl"
