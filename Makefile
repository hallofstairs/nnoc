PROJ=nnoc
BUILD_DIR=./build

all: ${BUILD_DIR}/${PROJ}.dfu

${BUILD_DIR}:
	mkdir -p ${BUILD_DIR}


# ---- Upload to FPGA ----

dfu: ${BUILD_DIR}/${PROJ}.dfu
	dfu-util --alt 0 -D $<

${BUILD_DIR}/%.json: %.sv | ${BUILD_DIR}
	yosys -p "read_verilog -sv $<; synth_ecp5 -json $@" -o $@

${BUILD_DIR}/%_out.config: ${BUILD_DIR}/%.json
	nextpnr-ecp5 --json $< --textcfg $@ --85k --package CSFBGA285 --lpf ./fpga-board.pcf

${BUILD_DIR}/%.bit: ${BUILD_DIR}/%_out.config
	ecppack --compress --freq 38.8 --input $< --bit $@

${BUILD_DIR}/%.dfu : ${BUILD_DIR}/%.bit
	cp -a $< $@
	dfu-suffix -v 1209 -p 5af0 -a $@

# ---- Run testbench ----

sim: $(BUILD_DIR)/sim.vvp
	vvp $(BUILD_DIR)/sim.vvp
	# Uncomment the following line to open gtkwave after simulation
	# gtkwave $(BUILD_SIR)/waveform.vcd

$(BUILD_DIR)/sim.vvp: nnoc.sv nnoc_tb.sv | $(BUILD_DIR)
	iverilog -g2012 -o $@ nnoc.sv nnoc_tb.sv


# ---- Clean up ----

clean:
	rm -rf ${BUILD_DIR}

.PHONY: prog clean dfu
