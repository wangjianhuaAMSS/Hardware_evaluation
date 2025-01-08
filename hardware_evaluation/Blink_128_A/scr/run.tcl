# Removing current design
remove_design -all

# Setting environment
# Need modify: Yes
cd /mnt/hgfs/VMShared/TEST/Blink_128_256_2-CodeTestArea

# Clean Workspace
if [file exists work] {file delete -force work}

# Define design lib
file mkdir work
define_design_lib work -path "./work"

# Define the designer and company
set designer "xxxxxx"
set company "HuaWei"

# Define the path directories for file locations
set file_path 	[concat /mnt/hgfs/VMShared/TEST/Blink_128_256_2-CodeTestArea]
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

# Initial compile with estimated constraints
# Read verilog or vhdl
# Need modify: Yes
set top_design Blink_128_256
set source_file [sh find ./src/*.v]
analyze -format verilog -library work ${source_file}
elaborate -library work $top_design
link

# report each file
#Need modify: Yes
source "${script_path}/Blink_128_256.tcl"
