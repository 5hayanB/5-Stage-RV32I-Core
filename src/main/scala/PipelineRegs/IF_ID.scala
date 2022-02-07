package PipelineRegs

import chisel3._

class IF_ID_IO extends Bundle
{
    // Input pins
    val PC_in: UInt = Input(UInt(32.W))
    val nPC_in: SInt = Input(SInt(32.W))
    val inst_in: UInt = Input(UInt(32.W))
    
    // Output pins
    val PC_out: UInt = Output(UInt(32.W))
    val nPC_out: SInt = Output(SInt(32.W))
    val inst_out: UInt = Output(UInt(32.W))
}
class IF_ID extends Module
{
    // Initializing modules and wires
    val io: IF_ID_IO = IO(new IF_ID_IO)
    val PC: UInt = dontTouch(RegInit(io.PC_in))
    val nPC: SInt = dontTouch(RegInit(io.nPC_in))
    val inst: UInt = dontTouch(RegInit(io.inst_in))
    
    // Wiring the outputs
    Array(
        io.PC_out,
        io.nPC_out,
        io.inst_out
    ) zip Array(
        PC,
        nPC,
        inst
    ) foreach
    {
        x => x._1 := x._2
    }
}
