package PipelineRegs

import chisel3._

class MEM_WB_IO extends Bundle
{
    // Inputs
    val EX_MEM_rd_addr_in: UInt = Input(UInt(5.W))
    val alu_in: SInt = Input(SInt(32.W))
    val load_in: SInt = Input(SInt(32.W))
    val ld_en_in: Bool = Input(Bool())
    
    // Outputs
    val EX_MEM_rd_addr_out: UInt = Output(UInt(5.W))
    val alu_out: SInt = Output(SInt(32.W))
    val load_out: SInt = Output(SInt(32.W))
    val ld_en_out: Bool = Output(Bool())
}
class MEM_WB extends Module
{
    // Initializing the wires and modules
    val io: MEM_WB_IO = IO(new MEM_WB_IO)
    val EX_MEM_rd_addr: UInt = dontTouch(RegInit(io.EX_MEM_rd_addr_in))
    val alu: SInt = dontTouch(RegInit(io.alu_in))
    val load: SInt = dontTouch(RegInit(io.load_in))
    val load_en: Bool = dontTouch(RegInit(io.ld_en_in))
    
    // Wiring the outputs
    Array(
        io.EX_MEM_rd_addr_out,
        io.alu_out,
        io.load_out,
        io.ld_en_out
    ) zip Array(
        EX_MEM_rd_addr,
        alu,
        load,
        load_en
    ) foreach
    {
        x => x._1 := x._2
    }
}
