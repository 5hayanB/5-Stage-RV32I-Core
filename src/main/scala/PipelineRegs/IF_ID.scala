package PipelineRegs

import chisel3._

class IF_ID_IO extends Bundle
{
    // Input pins
    val PC_in: UInt = Input(UInt(32.W))
    val nPC_in: UInt = Input(UInt(32.W))
    val inst_in: UInt = Input(UInt(32.W))
    
    // Output pins
    val PC_out: UInt = Output(UInt(32.W))
    val nPC_out: UInt = Output(UInt(32.W))
    val inst_out: UInt = Output(UInt(32.W))
}
class IF_ID extends Module
{
    // Initializing modules and wires
    val io: IF_ID_IO = IO(new IF_ID_IO)
    val PC: UInt = dontTouch(RegInit(0.U(32.W)))
    val nPC: UInt = dontTouch(RegInit(0.U(32.W)))
    val inst: UInt = dontTouch(RegInit(0.U(32.W)))
    
    // Wiring the modules
    Array(
        // Output ports
        io.PC_out, io.nPC_out, io.inst_out,

        // Registers
        PC,        nPC,        inst
    ) zip Array(  // corresponding wires
        // Output ports
        PC,        nPC,        inst,

        // Registers
        io.PC_in,  io.nPC_in,  io.inst_in
    ) foreach
    {
        x => x._1 := x._2
    }
}
