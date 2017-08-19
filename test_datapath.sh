sh genmem.sh
ghdl -a EE224_Components.vhd
ghdl -a mempack.vhd
ghdl -a *.vhd
ghdl -a Testbench_Datapath.vhd
ghdl -a Components.vhd
ghdl -a Datapath.vhd
ghdl -a InstructionMemory.vhd
ghdl -a DataHazDetect.vhd
ghdl -a ControlHazardDetector.vhd
ghdl -a Memory.vhd
ghdl -a ALU.vhd
ghdl -m Testbench_Datapath
ghdl -r Testbench_Datapath --stop-time=500ns --vcd=run.vcd --wave=waveform.ghw
