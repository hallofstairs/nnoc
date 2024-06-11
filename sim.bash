# Compile verilog code to executable with icarus
iverilog -g2012 -o build/sim.vvp nnoc.sv nnoc_tb.sv && \

# Run the simulation
vvp build/sim.vvp

# Observe the waveform
# gtkwave build/waveform.vcd

exit