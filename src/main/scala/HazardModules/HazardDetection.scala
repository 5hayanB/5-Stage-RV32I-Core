package HazardModules

import chisel3._

class HazardDetection_IO extends Bundle
{
    // Input pins
    val IF_ID_inst_in = Input(UInt(32.W))
    val ID_EX_ld_en_in = Input(Bool())
    val ID_EX_rd_addr_in = Input(UInt(5.W))
    val PC_in = Input(UInt(32.W))
    val current_PC_in = Input(UInt(32.W))

    // Output pins
    val forward_inst = Output(Bool())
    val forward_PC = Output(Bool())
    val forward_ctrl = Output(Bool())
    val inst_out = Output(UInt(32.W))
    val PC_out = Output(UInt(32.W))
    val current_PC_out = Output(UInt(32.W))
}
class HazardDetection extends Module
{
    val io = IO(new HazardDetection_IO)
    val rs1_sel = dontTouch(WireInit(io.IF_ID_inst_in(19, 15)))
    val rs2_sel = dontTouch(WireInit(io.IF_ID_inst_in(24, 20)))

    when (io.ID_EX_ld_en_in === 1.B && ((io.ID_EX_rd_addr_in === rs1_sel) || (io.ID_EX_rd_addr_in === rs2_sel)))
    {
        Array(io.forward_inst, io.forward_PC, io.forward_ctrl) map (_ := 1.B)
        io.inst_out := io.IF_ID_inst_in
        io.PC_out := io.PC_in
        io.current_PC_out := io.current_PC_in
    }.otherwise
    {
        Array(io.forward_inst, io.forward_PC, io.forward_ctrl) map (_ := 0.B)
        io.inst_out := io.IF_ID_inst_in
        io.PC_out := io.PC_in
        io.current_PC_out := io.current_PC_in
    }
}