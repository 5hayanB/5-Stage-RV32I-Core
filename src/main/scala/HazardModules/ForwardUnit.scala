package HazardModules

import chisel3._

class ForwardUnit_IO extends Bundle
{
    // Input
    val EX_MEM_rd_addr: UInt = Input(UInt(5.W))
    val MEM_WB_rd_addr: UInt = Input(UInt(5.W))
    val ID_EX_rs1_addr: UInt = Input(UInt(5.W))
    val ID_EX_rs2_addr: UInt = Input(UInt(5.W))
    val EX_MEM_write_en: Bool = Input(Bool())
    val MEM_WB_write_en: Bool = Input(Bool())

    // Output
    val forward_op1: UInt = Output(UInt(2.W))
    val forward_op2: UInt = Output(UInt(2.W))
}
class ForwardUnit extends Module
{
    // Initializing the wires and modules
    val io: ForwardUnit_IO = IO(new ForwardUnit_IO)
    val EX_MEM_rd_addr: UInt = dontTouch(WireInit(io.EX_MEM_rd_addr))
    val MEM_WB_rd_addr: UInt = dontTouch(WireInit(io.MEM_WB_rd_addr))
    val ID_EX_rs1_addr: UInt = dontTouch(WireInit(io.ID_EX_rs1_addr))
    val ID_EX_rs2_addr: UInt = dontTouch(WireInit(io.ID_EX_rs2_addr))
    val EX_MEM_write_en: Bool = dontTouch(WireInit(io.EX_MEM_write_en))
    val MEM_WB_write_en: Bool = dontTouch(WireInit(io.MEM_WB_write_en))

    // Wiring the outputs
    Seq(
        io.forward_op1,
        io.forward_op2
    ) map (_ := 0.U)
    
    // EX_MEM Hazard
    when (
        (io.EX_MEM_write_en === 1.B) && (io.EX_MEM_rd_addr =/= 0.U) && (io.EX_MEM_rd_addr === io.ID_EX_rs1_addr) && (io.EX_MEM_rd_addr === io.ID_EX_rs2_addr)
    ) {
        io.forward_op1 := 1.U
        io.forward_op2 := 1.U
    }.elsewhen (
        (io.EX_MEM_write_en === 1.B) && (io.EX_MEM_rd_addr =/= 0.U) && (io.EX_MEM_rd_addr === io.ID_EX_rs1_addr)
    ) {
        io.forward_op1 := 1.U
    }.elsewhen (
        (io.EX_MEM_write_en === 1.B) && (io.EX_MEM_rd_addr =/= 0.U) && (io.EX_MEM_rd_addr === io.ID_EX_rs2_addr)
    ) {
        io.forward_op2 := 1.U
    }

    // MEM_WB Hazard
    when (
        (io.MEM_WB_write_en === 1.B) && (io.MEM_WB_rd_addr =/= 0.U) && !(
            (io.EX_MEM_write_en === 1.B) && (io.EX_MEM_rd_addr =/= 0.U) && (io.EX_MEM_rd_addr === io.ID_EX_rs1_addr) && (io.EX_MEM_rd_addr =/= io.ID_EX_rs2_addr)
        ) && (io.MEM_WB_rd_addr === io.ID_EX_rs1_addr) && (io.MEM_WB_rd_addr === io.ID_EX_rs2_addr)
    ) {
        io.forward_op1 := 2.U
        io.forward_op2 := 2.U
    }.elsewhen (
        (io.MEM_WB_write_en === 1.B) && (io.MEM_WB_rd_addr =/= 0.U) && !(
            (io.EX_MEM_write_en === 1.B) && (io.EX_MEM_rd_addr =/= 0.U) && (io.EX_MEM_rd_addr === io.ID_EX_rs1_addr)
        ) && (io.MEM_WB_rd_addr === io.ID_EX_rs1_addr)
    ) {
        io.forward_op1 := 2.U
    }.elsewhen (
        (io.MEM_WB_write_en === 1.B) && (io.MEM_WB_rd_addr =/= 0.U) && !(
            (io.EX_MEM_write_en === 1.B) && (io.EX_MEM_rd_addr =/= 0.U) && (io.EX_MEM_rd_addr === io.ID_EX_rs2_addr)
        ) && (io.MEM_WB_rd_addr === io.ID_EX_rs2_addr)
    ) {
        io.forward_op2 := 2.U
    }
}
