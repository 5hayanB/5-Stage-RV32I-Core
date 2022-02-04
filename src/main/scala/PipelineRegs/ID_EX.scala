package PipelineRegs

import chisel3._

class ID_EX_IO extends Bundle
{
    // Input pins
    val IF_ID_PC_in: UInt = Input(UInt(32.W))
    val rd_addr_in: UInt = Input(UInt(5.W))
    val func3_in: UInt = Input(UInt(3.W))
    val rs1_addr_in: UInt = Input(UInt(5.W))
    val rs2_addr_in: UInt = Input(UInt(5.W))
    val rs1_data_in: SInt = Input(SInt(32.W))
    val rs2_data_in: SInt = Input(SInt(32.W))
    val func7_in: UInt = Input(UInt(7.W))
    val imm_in: SInt = Input(SInt(32.W))
    val ld_en_in: Bool = Input(Bool())
    val str_en_in: Bool = Input(Bool())
    val op2sel_in: Bool = Input(Bool())
    val br_en_in: Bool = Input(Bool())
    val jal: Bool = Input(Bool())
    val jalr: Bool = Input(Bool())
    val lui: Bool = Input(Bool())
    val auipc: Bool = Input(Bool())
    
    // Output pins
    val IF_ID_PC_out: UInt = Output(UInt(32.W))
}
class ID_EX extends Module
{
    // Initializing the wires and modules
    val io: ID_EX_IO = IO(new ID_EX_IO)
    val IF_ID_PC: UInt = dontTouch(RegInit(io.IF_ID_PC_in))
    val rd_addr: UInt = dontTouch(RegInit(io.rd_addr_in))
    val func3: UInt = dontTouch(RegInit(io.func3_in))
    val rs1_addr: UInt = dontTouch(RegInit(io.rs1_addr_in))
    val rs2_addr: UInt = dontTouch(RegInit(io.rs2_addr_in))
    val rs1_data: SInt = dontTouch(RegInit(io.rs1_data_in))
    val rs2_data: SInt = dontTouch(RegInit(io.rs2_data_in))
    val func7: UInt = dontTouch(RegInit(io.func7_in))
    val imm: SInt = dontTouch(RegInit(io.imm_in))
    val ld_en: Bool = dontTouch(RegInit(io.ld_en_in))
    val str_en: Bool = dontTouch(RegInit(io.str_en_in))
    val op2sel: Bool = dontTouch(RegInit(io.op2sel_in))
    val br_en: Bool = dontTouch(RegInit(io.br_en_in))
    val jal: Bool = dontTouch(RegInit(io.jal))
    val jalr: Bool = dontTouch(RegInit(io.jalr))
    val lui: Bool = dontTouch(RegInit(io.lui))
    val auipc: Bool = dontTouch(RegInit(io.auipc))
}
