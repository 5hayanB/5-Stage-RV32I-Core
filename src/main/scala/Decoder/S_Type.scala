package Decoder

import chisel3._
import chisel3.util._

class S_Type_IO extends Bundle
{
    val in: UInt = Input(UInt(25.W))
    val en: Bool = Input(Bool())
    val func3: UInt = Output(UInt(3.W))
    val rs1: UInt = Output(UInt(5.W))
    val rs2: UInt = Output(UInt(5.W))
    val imm: SInt = Output(SInt(32.W))
}
class S_Type extends Module
{
    // Initializing the signals and modules
    val io: S_Type_IO = IO(new S_Type_IO)
    val en: Bool = dontTouch(WireInit(io.en))
    val func3: UInt = dontTouch(WireInit(io.in(7, 5)))
    val rs1: UInt = dontTouch(WireInit(io.in(12, 8)))
    val rs2: UInt = dontTouch(WireInit(io.in(17, 13)))
    val imm: SInt = dontTouch(WireInit(Cat
    (
        io.in(24, 18),
        io.in(4, 0)
    ).asSInt()))
    
    // Wiring the outputs
    when (en)
    {
        Array(
            io.func3,
            io.rs1,
            io.rs2,
            io.imm
        ) zip Array(
            func3,
            rs1,
            rs2,
            imm
        ) foreach
            {
                x => x._1 := x._2
            }
    }.otherwise(
        Array(
            io.func3,
            io.rs1,
            io.rs2,
            io.imm
        ) zip Array(
            0.U,
            0.U,
            0.U,
            0.S
        ) foreach
            {
                x => x._1 := x._2
            }
    )
}
