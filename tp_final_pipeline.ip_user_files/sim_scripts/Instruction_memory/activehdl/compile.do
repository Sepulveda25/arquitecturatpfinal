vlib work
vlib activehdl

vlib activehdl/blk_mem_gen_v8_4_0
vlib activehdl/xil_defaultlib

vmap blk_mem_gen_v8_4_0 activehdl/blk_mem_gen_v8_4_0
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work blk_mem_gen_v8_4_0  -v2k5 \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../tp_final_pipeline.srcs/sources_1/ip/Instruction_memory/sim/Instruction_memory.v" \


vlog -work xil_defaultlib \
"glbl.v"

