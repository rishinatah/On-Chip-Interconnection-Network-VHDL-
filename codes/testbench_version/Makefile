TOP=top.sv
BENCH=bench
DUT=router.sv


.PHONY: help

help:
	@echo "The following make targets are supported:" ;\
	echo " bench  - builds the testbench";\
	echo " wave   - convert vcd to vpd";\
	echo " expand - expands veritedium directives (autoargs, inst etc.)";\
	echo " indent - automatically indents verilog and c files" ;\
	echo " clean  - cleans testbench and intermediate files" ;\
	echo " help   - show this information";\

indent:
	emacs --batch *.sv -f verilog-batch-indent
	indent -linux *.c *.h
	rm *~
test:
	vcs -full64 -sverilog -PP +define+VPD *.sv -o $(BENCH)
	./$(BENCH)
dut:  
	vcs -full64 -PP -sverilog +define+SV +define+VPD +lint=all,noVCDE -notice $(DUT)

bench: 
	vcs -full64 -sverilog -PP +define+VPD *.sv -o $(BENCH)
	./$(BENCH)

wave:
	vcs -vpd2vcd vcdplus.vpd waveform.vcd
	gtkwave waveform.vcd &
cover:
	vcs -full64 -cm line+tgl+cond+fsm+branch+assert -debug_pp -sverilog -notice +lint=all,noVCDE +define+SV +define+VPD  *.sv -o coverTestbench.exe

clean:
	rm -rf *.o *~ *.vpd sim* csrc DVEfiles *daidir *exe *.key
