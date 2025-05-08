onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+unsign_multiplier -L xbip_utils_v3_0_9 -L xbip_pipe_v3_0_5 -L xbip_bram18k_v3_0_5 -L mult_gen_v12_0_14 -L xil_defaultlib -L secureip -O5 xil_defaultlib.unsign_multiplier

do {wave.do}

view wave
view structure

do {unsign_multiplier.udo}

run -all

endsim

quit -force
