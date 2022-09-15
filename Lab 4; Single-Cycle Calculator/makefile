GHDL=ghdl
GHDLFLAGS=
MODULES=\
	alu.o \
	bitreg8.o \
	alculator.o \
	controller.o \
	demux_1to4.o \
	fulladder.o \
	mux_2to1.o \
	mux_4to1.o \
	reg8.o \
	calculator_tb


test: $(MODULES)
		$(GHDL) -r calculator_tb --vcd=calculator_tb.vcd
  
%: %.o
		$(GHDL) -e $(GHDLFLAGS) $@

%.o: %.vhdl
		$(GHDL) -a $(GHDLFLAGS) $<