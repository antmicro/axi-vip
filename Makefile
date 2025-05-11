# Common compile options for VCS
VCS_COMMON_COPTS := -full64 -kdb -sverilog -debug_access+all+class -CFLAGS -g -LDFLAGS -g

# UVM compile options
VCS_UVM_COPTS := -ntb_opts uvm-1.2 +define+UVM_VERDI_COMPWACVE

# File list
FILE_LIST := axi.f

# UVM run options
VCS_UVM_ROPTS := +UVM_OBJECT_TRACE +UVM_PHASE_TRACE +UVM_VERBOSITY=UVM_FULL +UVM_VERDI_TRACE="HIER+COMPWAVE"

# Default test name, can be overridden: make vcs_run UVM_TESTNAME=your_test
UVM_TESTNAME ?= axi_wrap_test

# Common run options
VCS_COMMON_ROPTS := -l sim.log -ucli -do vsim.tcl

.PHONY: all vcs_comp vcs_run clean

all: vcs_comp

# Compile target
vcs_comp:
	vcs -f $(FILE_LIST) $(VCS_UVM_COPTS) $(VCS_COMMON_COPTS)

# Run simulation target
vcs_run:
	./simv +UVM_TESTNAME=$(UVM_TESTNAME) $(VCS_UVM_ROPTS) $(VCS_COMMON_ROPTS)

# Clean generated files
clean:
	rm -rf simv simv.daidir csrc *.log *.key *.vpd *.fsdb *.ucdb DVEfiles
