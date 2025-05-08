onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib InstROM_opt

do {wave.do}

view wave
view structure
view signals

do {InstROM.udo}

run -all

quit -force
