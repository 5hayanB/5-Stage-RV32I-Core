package ControlUnit

import chisel3._

class ControlUnit_IO extends Bundle
{
    val id: UInt = Input(UInt(5.W))
    val ld_en: Bool = Output(Bool())
    val str_en: Bool = Output(Bool())
    val op2sel: Bool = Output(Bool())
    val br_en: Bool = Output(Bool())
    val jal: Bool = Output(Bool())
    val jalr: Bool = Output(Bool())
    val lui: Bool = Output(Bool())
    val auipc: Bool = Output(Bool())
}
class ControlUnit extends Module
{
    // Initializing the signals
    val io: ControlUnit_IO = IO(new ControlUnit_IO)
    val ld_en: Bool = dontTouch(WireInit(io.id === 0.U))
    val str_en: Bool = dontTouch(WireInit(io.id === 8.U))
    val op2sel: Bool = dontTouch(WireInit(io.id === 0.U || io.id === 4.U || io.id === 8.U))
    val br_en: Bool = dontTouch(WireInit(io.id === 24.U))
    val jal: Bool = dontTouch(WireInit(io.id === 27.U))
    val jalr: Bool = dontTouch(WireInit(io.id === 25.U))
    val auipc: Bool = dontTouch(WireInit(io.id === 5.U))
    val lui: Bool = dontTouch(WireInit(io.id === 13.U))
    
    // Wiring the outputs
    Array(
        ld_en,
        str_en,
        op2sel,
        br_en,
        jal,
        jalr,
        auipc,
        lui
    ) zip Array(
        io.ld_en,
        io.str_en,
        io.op2sel,
        io.br_en,
        io.jal,
        io.jalr,
        io.auipc,
        io.lui
    ) foreach {
        x => x._2 := x._1
    }
}
