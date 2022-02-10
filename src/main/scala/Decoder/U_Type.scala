package Decoder

import chisel3._
import chisel3.util._

class U_Type_IO extends Bundle
{
    val in: UInt = Input(UInt(25.W))
    val en: Bool = Input(Bool())
    val rd: UInt = Output(UInt(5.W))
    val imm: SInt = Output(SInt(20.W))
}
class U_Type extends Module
{
    // Initializing the signals and modules
    val io: U_Type_IO = IO(new U_Type_IO)
    val en: Bool = dontTouch(WireInit(io.en))
    val rd: UInt = dontTouch(WireInit(io.in(4, 0)))
    val imm: SInt = dontTouch(WireInit(io.in(24, 5).asSInt()))
    
    // Wiring the outputs
    when (en)
    {
        Array(
            io.rd,
            io.imm
        ) zip Array(
            rd,
            imm
        ) foreach
            {
                x => x._1 := x._2
            }
    }.otherwise(
        Array(
            io.rd,
            io.imm
        ) zip Array(
            0.U,
            0.S
        ) foreach
            {
                x => x._1 := x._2
            }
    )
}
