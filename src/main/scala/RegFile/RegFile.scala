package RegFile

import chisel3._

class RegFile_IO extends Bundle
{
    // Input pins
    val rd_addr: UInt = Input(UInt(5.W))
    val rs1_addr: UInt = Input(UInt(5.W))
    val rs2_addr: UInt = Input(UInt(5.W))
    val rd_data: SInt = Input(SInt(32.W))
    
    // Output pins
    val rs1_data: SInt = Output(SInt(32.W))
    val rs2_data: SInt = Output(SInt(32.W))
}
class RegFile extends Module
{
    // Initializing signals and modules
    val io: RegFile_IO = IO(new RegFile_IO)
    val regFile: Mem[SInt] = Mem(1024, SInt(32.W))
    val rd_addr: UInt = dontTouch(WireInit(io.rd_addr))
    val rs1_addr: UInt = dontTouch(WireInit(io.rs1_addr))
    val rs2_addr: UInt = dontTouch(WireInit(io.rs2_addr))
    val rd_data: SInt = dontTouch(WireInit(io.rd_data))
    val rs1_data: SInt = dontTouch(WireInit(regFile.read(rs1_addr)))
    val rs2_data: SInt = dontTouch(WireInit(regFile.read(rs2_addr)))
    val x0: UInt = dontTouch(WireInit(0.U(32.W)))
    
    // Writing to rd
    regFile.write(rd_addr, rd_data)
    
    // Wiring the outputs
    when (rs1_addr === 0.U)
    {
        io.rs1_data := 0.S
    }.otherwise
    {
        io.rs1_data := rs1_data
    }
    when (rs2_addr === 0.U)
    {
        io.rs2_data := 0.S
    }.otherwise
    {
        io.rs2_data := rs2_data
    }
}
