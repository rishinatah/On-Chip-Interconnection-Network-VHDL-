dc:
	dc_shell -f dsyn.tcl 2>&1 | tee log/dc_output.log
dc_view:
	design_vision-xg -f view.tcl
icc:
	icc_shell -f psyn.tcl 2>&1 | tee log/icc_output.log
	icc_shell -gui
clean:
	rm -rf WORK/ *_LIB/ *.svf log/*.log *.log report/*.rpt *.ddc *.sdc *.sdf *_synth.v alib-52/