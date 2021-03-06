# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_msg_config  -ruleid {1}  -id {VRFC 10-1783}  -string {{WARNING: [VRFC 10-1783] select index 62 into current_contents is out of bounds [/wrk/2017.sub/2017.3.1/nightly/2017_10_20_2035080/packages/customer/vivado/data/ip/xilinx/blk_mem_gen_v8_4/simulation/blk_mem_gen_v8_4.v:2420]}}  -suppress 
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.cache/wt} [current_project]
set_property parent.project_path {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.xpr} [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {e:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba _storage_load.coe}}
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba _deteccion_riesgo.coe}}
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba_unidad_corto_bis.coe}}
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba_unidad_corto.coe}}
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba _flags_jal_jalr.coe}}
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba_BNE.coe}}
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba_BEQ.coe}}
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba_JR.coe}}
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba_JARL.coe}}
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba_Jmp.coe}}
add_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/prueba_JAL.coe}}
read_verilog -library xil_defaultlib {
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/ALU.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/ALU_Control.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Adder.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Comparador_registros.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Control_Unit.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Etapa1_IF.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Etapa2_ID.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Etapa2_ID_Modulo_Saltos.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Etapa3_EX.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Etapa4_MEM.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/MUX.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/ProgramCounter.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Registers.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Sign_Extend.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Triple_MUX.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/Unidad_halt.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/imports/Tp3_BIP/contador_clk.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/latch_EX_MEM.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/latch_ID_EX.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/latch_IF_ID.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/latch_MEM_WB.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/pc_jump.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/unidad_de_cortocircuito.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/unidad_de_deteccion_de_riesgos.v}
  {E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/new/pipeline_segmentado_sintesis.v}
}
read_ip -quiet {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci}}
set_property used_in_implementation false [get_files -all {{e:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc}}]
set_property used_in_implementation false [get_files -all {{e:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc}}]
set_property used_in_implementation false [get_files -all {{e:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc}}]

read_ip -quiet {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/ip/Instruction_memory/Instruction_memory.xci}}
set_property used_in_implementation false [get_files -all {{e:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/ip/Instruction_memory/Instruction_memory_ooc.xdc}}]

read_ip -quiet {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/ip/Data_Memory/Data_Memory.xci}}
set_property used_in_implementation false [get_files -all {{e:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/sources_1/ip/Data_Memory/Data_Memory_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/constrs_1/new/pines_pipeline_segmentado.xdc}}
set_property used_in_implementation false [get_files {{E:/Facultad/Arquitectura de Computadoras/Practicos Vivado/tp_final_pipeline/tp_final_pipeline.srcs/constrs_1/new/pines_pipeline_segmentado.xdc}}]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top pipeline_segmentado_sintesis -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef pipeline_segmentado_sintesis.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file pipeline_segmentado_sintesis_utilization_synth.rpt -pb pipeline_utilization_synth.pb"
