vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/blk_mem_gen_v8_4_0
vlib modelsim_lib/msim/xil_defaultlib

vmap blk_mem_gen_v8_4_0 modelsim_lib/msim/blk_mem_gen_v8_4_0
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work blk_mem_gen_v8_4_0 -64 -incr \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr \
"../../../../tp_final_pipeline.srcs/sources_1/ip/Instruction_memory/sim/Instruction_memory.v" \


vlog -work xil_defaultlib \
"glbl.v"

