package PipelineRegs

import chisel3._

class MEM_WB_IO extends Bundle
{
    // Inputs
    val rd_addr_in: UInt = Input(UInt(5.W))
    val rs1_data_in: SInt = Input(SInt(32.W))
    val imm_in: SInt = Input(SInt(32.W))
    val alu_in: SInt = Input(SInt(32.W))
    val load_in: SInt = Input(SInt(32.W))
    val ld_en_in: Bool = Input(Bool())
    val br_en_in: Bool = Input(Bool())
    val jal_in: Bool = Input(Bool())
    val jalr_in: Bool = Input(Bool())
    val lui_in: Bool = Input(Bool())
    val auipc_in: Bool = Input(Bool())
    val PC_in: UInt = Input(UInt(32.W))
    val nPC_in: UInt = Input(UInt(32.W))
    
    // Outputs
    val rd_addr_out: UInt = Output(UInt(5.W))
    val rs1_data_out: SInt = Output(SInt(32.W))
    val imm_out: SInt = Output(SInt(32.W))
    val alu_out: SInt = Output(SInt(32.W))
    val load_out: SInt = Output(SInt(32.W))
    val ld_en_out: Bool = Output(Bool())
    val br_en_out: Bool = Output(Bool())
    val jal_out: Bool = Output(Bool())
    val jalr_out: Bool = Output(Bool())
    val lui_out: Bool = Output(Bool())
    val auipc_out: Bool = Output(Bool())
    val PC_out: UInt = Output(UInt(32.W))
    val nPC_out: UInt = Output(UInt(32.W))
}
class MEM_WB extends Module
{
    // Initializing the wires and modules
    val io: MEM_WB_IO = IO(new MEM_WB_IO)
    val rd_addr: UInt = dontTouch(RegInit(io.rd_addr_in))
    val rs1_data: SInt = dontTouch(RegInit(io.rs1_data_in))
    val imm: SInt = dontTouch(RegInit(io.imm_in))
    val alu: SInt = dontTouch(RegInit(io.alu_in))
    val load: SInt = dontTouch(RegInit(io.load_in))
    val load_en: Bool = dontTouch(RegInit(io.ld_en_in))
    val br_en: Bool = dontTouch(RegInit(io.br_en_in))
    val jal: Bool = dontTouch(RegInit(io.jal_in))
    val jalr: Bool = dontTouch(RegInit(io.jalr_in))
    val lui: Bool = dontTouch(RegInit(io.lui_in))
    val auipc: Bool = dontTouch(RegInit(io.auipc_in))
    val PC: UInt = dontTouch(RegInit(io.PC_in))
    val nPC: UInt = dontTouch(RegInit(io.nPC_in))
    
    // Wiring the outputs
    Array(
        io.rd_addr_out,
        io.rs1_data_out,
        io.imm_out,
        io.alu_out,
        io.load_out,
        io.ld_en_out,
        io.br_en_out,
        io.jal_out,
        io.jalr_out,
        io.lui_out,
        io.auipc_out,
        io.PC_out,
        io.nPC_out
    ) zip Array(
        rd_addr,
        rs1_data,
        imm,
        alu,
        load,
        load_en,
        br_en,
        jal,
        jalr,
        lui,
        auipc,
        PC,
        nPC
    ) foreach
    {
        x => x._1 := x._2
    }
}
