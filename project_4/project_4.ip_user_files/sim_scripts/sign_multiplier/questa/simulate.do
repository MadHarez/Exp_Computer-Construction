onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib sign_multiplier_opt

do {wave.do}

view wave
view structure
view signals

do {sign_multiplier.udo}

run -all

quit -force
