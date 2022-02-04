package Decoder

import chisel3._

class R_Type_IO extends Bundle
{
    val in: UInt = Input(UInt(25.W))
    val en: Bool = Input(Bool())
    val rd: UInt = Output(UInt(5.W))
    val func3: UInt = Output(UInt(3.W))
    val rs1: UInt = Output(UInt(5.W))
    val rs2: UInt = Output(UInt(5.W))
    val func7: UInt = Output(UInt(7.W))
}
class R_Type extends Module
{
    // Initializing the signals and modules
    val io: R_Type_IO = IO(new R_Type_IO)
    val en: Bool = dontTouch(WireInit(io.en))
    val rd: UInt = dontTouch(WireInit(io.in(4, 0)))
    val func3: UInt = dontTouch(WireInit(io.in(7, 5)))
    val rs1: UInt = dontTouch(WireInit(io.in(12, 8)))
    val rs2: UInt = dontTouch(WireInit(io.in(17, 13)))
    val func7: UInt = dontTouch(WireInit(io.in(24, 18)))
    
    // Wiring the outputs
    when (en)
    {
        Array(
            io.rd,
            io.func3,
            io.rs1,
            io.rs2,
            io.func7
        ) zip Array(
            rd,
            func3,
            rs1,
            rs2,
            func7
        ) foreach
            {
                x => x._1 := x._2
            }
    }.otherwise(
        Array(
            io.rd,
            io.func3,
            io.rs1,
            io.rs2,
            io.func7
        ) zip Array(
            0.U,
            0.U,
            0.U,
            0.U,
            0.U
        ) foreach
            {
                x => x._1 := x._2
            }
    )
}
