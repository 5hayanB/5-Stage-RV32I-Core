package PipelineRegs

import chisel3._

class EX_MEM_IO extends Bundle
{
    // Inputs
    val ld_en_in: Bool = Input(Bool())
    val str_en_in: Bool = Input(Bool())
    val ID_EX_rd_addr_in: UInt = Input(UInt(5.W))
    val ID_EX_rs2_addr_in: UInt = Input(UInt(5.W))
    val ID_EX_rs2_data_in: SInt = Input(SInt(32.W))
    val alu_in: UInt = Input(UInt(24.W))
    
    // Outputs
    val ld_en_out: Bool = Output(Bool())
    val str_en_out: Bool = Output(Bool())
    val ID_EX_rd_addr_out: UInt = Output(UInt(5.W))
    val ID_EX_rs2_addr_out: UInt = Output(UInt(5.W))
    val ID_EX_rs2_data_out: SInt = Output(SInt(32.W))
    val alu_out: UInt = Output(UInt(24.W))
}
class EX_MEM extends Module
{
    // Initializing the wires and modules
    val io: EX_MEM_IO = IO(new EX_MEM_IO)
    val ld_en: Bool = dontTouch(RegInit(io.ld_en_in))
    val str_en: Bool = dontTouch(RegInit(io.str_en_in))
    val ID_EX_rd_addr: UInt = dontTouch(RegInit(io.ID_EX_rd_addr_in))
    val ID_EX_rs2_addr: UInt = dontTouch(RegInit(io.ID_EX_rs2_addr_in))
    val ID_EX_rs2_data: SInt = dontTouch(RegInit(io.ID_EX_rs2_data_in))
    val alu: UInt = dontTouch(RegInit(io.alu_in))
    
    // Wiring the outputs
    Array(
        io.ld_en_out,
        io.str_en_out,
        io.ID_EX_rd_addr_out,
        io.ID_EX_rs2_addr_out,
        io.ID_EX_rs2_data_out,
        io.alu_out
    ) zip Array(
        ld_en,
        str_en,
        ID_EX_rd_addr,
        ID_EX_rs2_addr,
        ID_EX_rs2_data,
        alu
    ) foreach
    {
        x => x._1 := x._2
    }
}
