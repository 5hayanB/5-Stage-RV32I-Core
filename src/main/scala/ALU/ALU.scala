package ALU

import chisel3._
import chisel3.util._

class ALU_IO extends Bundle
{
    // Inputs
    val ID_EX_rs1_data: SInt = Input(SInt(32.W))
    val op2: SInt = Input(SInt(32.W))
    val EX_MEM_alu_out: SInt = Input(SInt(32.W))
    val rd_data: SInt = Input(SInt(32.W))
    val func3: UInt = Input(UInt(3.W))
    val func7: UInt = Input(UInt(7.W))
    val id: UInt = Input(UInt(7.W))
    val forward_op1: UInt = Input(UInt(2.W))

    // Outputs
    val out: SInt = Output(SInt(32.W))
}
class ALU extends Module
{
    // Initializing the signals and modules
    val io: ALU_IO = IO(new ALU_IO)
    val op1: SInt = dontTouch(WireInit(
        MuxLookup(io.forward_op1, io.ID_EX_rs1_data, Array(
            1.U -> io.EX_MEM_alu_out,
            2.U -> io.rd_data
        ))
    ))
    val opSel: UInt = dontTouch(WireInit(Cat(io.func7, io.func3, io.id)))
    val add: SInt = dontTouch(WireInit(op1 + io.op2))
    val sub: SInt = dontTouch(WireInit(op1 - io.op2))
    val sll: SInt = dontTouch(WireInit((op1 << io.op2(18, 0).asUInt()).asSInt()))
    val lt: SInt = dontTouch(WireInit(Mux(op1 < io.op2, 1.S, 0.S)))
    val ltu: SInt = dontTouch(WireInit(Mux(op1.asUInt() < io.op2.asUInt(), 1.S, 0.S)))
    val xor: SInt = dontTouch(WireInit(op1 ^ io.op2))
    val srl: SInt = dontTouch(WireInit((op1 >> io.op2(18, 0).asUInt()).asSInt()))
    val sra: SInt = dontTouch(WireInit((op1 >> io.op2(18, 0).asUInt()).asSInt()))
    val or: SInt = dontTouch(WireInit(op1 | io.op2))
    val and: SInt = dontTouch(WireInit(op1 & io.op2))
    val beq: SInt = dontTouch(WireInit(Mux(op1 === io.op2, 1.S, 0.S)))
    val bge: SInt = dontTouch(WireInit((op1 >= io.op2).asSInt()))
    val bgeu: SInt = dontTouch(WireInit((op1.asUInt() >= io.op2.asUInt()).asSInt()))
    val bne: SInt = dontTouch(WireInit(Mux(op1 =/= io.op2, 1.S, 0.S)))
    
    // Selecting the operation output
    io.out := MuxCase(
        0.S,
        Array(
            (opSel === 51.U || opSel === 259.U || opSel === 19.U || opSel === 291.U) -> add,
            (opSel === 32819.U) -> sub,
            (opSel === 179.U) -> sll,
            (opSel === 307.U || opSel === 275.U || opSel === 611.U) -> lt,
            (opSel === 867.U || opSel === 435.U || opSel === 403.U) -> ltu,
            (opSel === 531.U || opSel === 563.U) -> xor,
            (opSel === 1331.U || opSel === 659.U) -> srl,
            (opSel === 33427.U || opSel === 33459.U) -> sra,
            (opSel === 819.U || opSel === 787.U) -> or,
            (opSel === 915.U || opSel === 947.U) -> and,
            (opSel === 99.U) -> beq,
            (opSel === 739.U) -> bge,
            (opSel === 995.U) -> bgeu,
            (opSel === 227.U) -> bne
        )
    )
}
