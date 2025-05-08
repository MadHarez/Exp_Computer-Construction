onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib unsign_multiplier_opt

do {wave.do}

view wave
view structure
view signals

do {unsign_multiplier.udo}

run -all

quit -force
