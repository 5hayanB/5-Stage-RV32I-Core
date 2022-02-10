package ALU

import chisel3._
import chisel3.util._

class ALU_IO extends Bundle
{
    val rs1: SInt = Input(SInt(32.W))
    val rs2: SInt = Input(SInt(32.W))
    val imm: SInt = Input(SInt(32.W))
    val func3: UInt = Input(UInt(3.W))
    val func7: UInt = Input(UInt(7.W))
    val id: UInt = Input(UInt(5.W))
    val op2sel: Bool = Input(Bool())
    val out: SInt = Output(SInt(32.W))
}
class ALU extends Module
{
    // Initializing the signals and modules
    val io: ALU_IO = IO(new ALU_IO)
    val op2: SInt = dontTouch(WireInit(Mux(io.op2sel, io.imm, io.rs2)))
    val opSel: UInt = dontTouch(WireInit(Cat(io.id(2), io.func7(5), io.func3)))
    val add: SInt = dontTouch(WireInit(io.rs1 + op2))
    val sub: SInt = dontTouch(WireInit(io.rs1 - op2))
    val sll: SInt = dontTouch(WireInit((io.rs1 << op2(18, 0).asUInt()).asSInt()))
    val lt: SInt = dontTouch(WireInit(Mux(io.rs1 < op2, 1.S, 0.S)))
    val ltu: SInt = dontTouch(WireInit(Mux(io.rs1.asUInt() < op2.asUInt(), 1.S, 0.S)))
    val xor: SInt = dontTouch(WireInit(io.rs1 ^ op2))
    val srl: SInt = dontTouch(WireInit((io.rs1 >> op2(18, 0).asUInt()).asSInt()))
    val sra: SInt = dontTouch(WireInit((io.rs1 >> op2(18, 0).asUInt()).asSInt()))
    val or: SInt = dontTouch(WireInit(io.rs1 | op2))
    val and: SInt = dontTouch(WireInit(io.rs1 & op2))
    val beq: SInt = dontTouch(WireInit(Mux(io.rs1 === op2, 1.S, 0.S)))
    val bge: SInt = dontTouch(WireInit((io.rs1 >= op2).asSInt()))
    val bgeu: SInt = dontTouch(WireInit((io.rs1.asUInt() >= op2.asUInt()).asSInt()))
    val bne: SInt = dontTouch(WireInit(Mux(io.rs1 =/= op2, 1.S, 0.S)))
    
    // Selecting the operation output
    io.out := MuxCase(
        0.S,
        Array(
            (opSel === 2.U || opSel === 16.U) -> add,
            (opSel === 24.U) -> sub,
            (opSel === 17.U) -> sll,
            (opSel === 4.U || opSel === 18.U) -> lt,
            (opSel === 6.U || opSel === 19.U) -> ltu,
            (opSel === 20.U) -> xor,
            (opSel === 21.U) -> srl,
            (opSel === 29.U) -> sra,
            (opSel === 22.U) -> or,
            (opSel === 23.U) -> and,
            (opSel === 0.U) -> beq,
            (opSel === 5.U) -> bge,
            (opSel === 7.U) -> bgeu,
            (opSel === 1.U) -> bne
        )
    )
}
