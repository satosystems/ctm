.PHONY: all install test clean

all: out/x86/ctm out/arm/ctm

out/x86:
	mkdir -p out/x86

out/arm:
	mkdir -p out/arm

out/x86/ctm: src/ctm.c out/x86
	gcc -Wall -O3 $< -o $@

out/arm/ctm: src/ctm.c out/arm
	arm-linux-gnueabi-gcc-5 -Wall -static -O3 $< -o $@

install:
	adb push out/$(shell adb shell cat /system/build.prop | grep ro.product.cpu.abi | awk -F, '{gsub("\x3d", ",", $$0); print $$2}')/ctm /data/local/tmp

test: out/x86/ctm test/ctm.class
	@out/x86/ctm -v
	@cd test && java ctm && cd ..
	@echo ""
	@out/x86/ctm
	@echo ""

test/ctm.class: test/ctm.java
	cd test && javac ctm.java

clean:
	rm -rf out test/ctm.class

