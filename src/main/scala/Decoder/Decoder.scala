package Decoder

import chisel3._

class Decoder_IO extends Bundle
{
    val in: UInt = Input(UInt(32.W))
    val rd: UInt = Output(UInt(5.W))
    val func3: UInt = Output(UInt(3.W))
    val rs1: UInt = Output(UInt(5.W))
    val rs2: UInt = Output(UInt(5.W))
    val func7: UInt = Output(UInt(7.W))
    val imm: SInt = Output(SInt(32.W))
    val id: UInt = Output(UInt(5.W))
}
class Decoder extends Module
{
    // Initializing modules and signals
    val io: Decoder_IO = IO(new Decoder_IO())
    val inst = WireInit(io.in(31, 7))
    val id: UInt = dontTouch(WireInit(io.in(6, 2)))
    val r: R_Type = Module(new R_Type)
    val i: I_Type = Module(new I_Type)
    val s: S_Type = Module(new S_Type)
    val sb: SB_Type = Module(new SB_Type)
    val u: U_Type = Module(new U_Type)
    val uj: UJ_Type = Module(new UJ_Type)
    val rd: UInt = dontTouch(WireInit(r.io.rd | i.io.rd | u.io.rd | uj.io.rd))
    val func3: UInt = dontTouch(WireInit(r.io.func3 | i.io.func3 | s.io.func3 | sb.io.func3))
    val rs1: UInt = dontTouch(WireInit(r.io.rs1 | i.io.rs1 | s.io.rs1 | sb.io.rs1))
    val rs2: UInt = dontTouch(WireInit(r.io.rs2 | s.io.rs2 | sb.io.rs2))
    val func7: UInt = dontTouch(WireInit(r.io.func7))
    val imm: SInt = dontTouch(WireInit(i.io.imm | s.io.imm | sb.io.imm | u.io.imm | uj.io.imm))
    
    // Wiring the modules
    Array(
        r.io.in,
        i.io.in,
        s.io.in,
        sb.io.in,
        u.io.in,
        uj.io.in,
    ) zip Array(
        inst,
        inst,
        inst,
        inst,
        inst,
        inst
    ) foreach
    {
        x => x._1 := x._2
    }
    
    // Setting up the enables
    when (id === 12.U || id === 14.U)  // Enabling R_Type
    {
        Array(
            r.io.en,
            i.io.en,
            s.io.en,
            sb.io.en,
            u.io.en,
            uj.io.en
        ) zip Array(
            1.B,
            0.B,
            0.B,
            0.B,
            0.B,
            0.B
        ) foreach
        {
            x => x._1 := x._2
        }
    }.elsewhen (id === 0.U || id === 4.U || id === 25.U)  // Enabling I_Type
    {
        Array(
            r.io.en,
            i.io.en,
            s.io.en,
            sb.io.en,
            u.io.en,
            uj.io.en
        ) zip Array(
            0.B,
            1.B,
            0.B,
            0.B,
            0.B,
            0.B
        ) foreach
            {
                x => x._1 := x._2
            }
    }.elsewhen (id === 8.U)  // Enabling S_Type
    {
        Array(
            r.io.en,
            i.io.en,
            s.io.en,
            sb.io.en,
            u.io.en,
            uj.io.en
        ) zip Array(
            0.B,
            0.B,
            1.B,
            0.B,
            0.B,
            0.B
        ) foreach
            {
                x => x._1 := x._2
            }
    }.elsewhen (id === 24.U)  // Enabling SB_Type
    {
        Array(
            r.io.en,
            i.io.en,
            s.io.en,
            sb.io.en,
            u.io.en,
            uj.io.en
        ) zip Array(
            0.B,
            0.B,
            0.B,
            1.B,
            0.B,
            0.B
        ) foreach
            {
                x => x._1 := x._2
            }
    }.elsewhen(id === 5.U || id === 13.U)  // Enabling U_Type
    {
        Array(
            r.io.en,
            i.io.en,
            s.io.en,
            sb.io.en,
            u.io.en,
            uj.io.en
        ) zip Array(
            0.B,
            0.B,
            0.B,
            0.B,
            1.B,
            0.B
        ) foreach
            {
                x => x._1 := x._2
            }
    }.elsewhen (id === 27.U)  // Enabling UJ_Type
    {
        Array(
            r.io.en,
            i.io.en,
            s.io.en,
            sb.io.en,
            u.io.en,
            uj.io.en
        ) zip Array(
            0.B,
            0.B,
            0.B,
            0.B,
            0.B,
            1.B
        ) foreach
            {
                x => x._1 := x._2
            }
    }otherwise(
        Array(
            r.io.en,
            i.io.en,
            s.io.en,
            sb.io.en,
            u.io.en,
            uj.io.en
        ) zip Array(
            0.B,
            0.B,
            0.B,
            0.B,
            0.B,
            0.B
        ) foreach
            {
                x => x._1 := x._2
            }
    )
    
    // Wiring the outputs
    Array(
        io.rd,
        io.func3,
        io.rs1,
        io.rs2,
        io.func7,
        io.imm,
        io.id
    ) zip Array(
        rd,
        func3,
        rs1,
        rs2,
        func7,
        imm,
        id
    ) foreach
    {
        x => x._1 := x._2
    }
}
