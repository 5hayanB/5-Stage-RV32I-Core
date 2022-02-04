package Decoder

import chisel3._

class I_Type_IO extends Bundle
{
    val in: UInt = Input(UInt(25.W))
    val en: Bool = Input(Bool())
    val rd: UInt = Output(UInt(5.W))
    val func3: UInt = Output(UInt(3.W))
    val rs1: UInt = Output(UInt(5.W))
    val imm: SInt = Output(SInt(32.W))
}
class I_Type extends Module
{
    // Initializing the signals and modules
    val io: I_Type_IO = IO(new I_Type_IO)
    val en: Bool = dontTouch(WireInit(io.en))
    val rd: UInt = dontTouch(WireInit(io.in(4, 0)))
    val func3: UInt = dontTouch(WireInit(io.in(7, 5)))
    val rs1: UInt = dontTouch(WireInit(io.in(12, 8)))
    val imm: SInt = dontTouch(WireInit(io.in(24, 13).asSInt()))
    
    // Wiring the outputs
    when (en)
    {
        Array(
            io.rd,
            io.func3,
            io.rs1,
            io.imm
        ) zip Array(
            rd,
            func3,
            rs1,
            imm
        ) foreach
            {
                x => x._1 := x._2
            }
    }.otherwise(
        Array(
            io.rd,
            io.func3,
            io.rs1,
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
