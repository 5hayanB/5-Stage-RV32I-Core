package PipelineRegs

import chisel3._

class EX_MEM_IO extends Bundle
{
    // Inputs
    val ld_en_in: Bool = Input(Bool())
    val str_en_in: Bool = Input(Bool())
    val rd_addr_in: UInt = Input(UInt(5.W))
    val rs1_data_in: SInt = Input(SInt(32.W))
    val rs2_data_in: SInt = Input(SInt(32.W))
    val imm_in: SInt = Input(SInt(32.W))
    val alu_in: SInt = Input(SInt(32.W))
    val br_en_in: Bool = Input(Bool())
    val jal_in: Bool = Input(Bool())
    val jalr_in: Bool = Input(Bool())
    val lui_in: Bool = Input(Bool())
    val auipc_in: Bool = Input(Bool())
    val PC_in: UInt = Input(UInt(32.W))
    val nPC_in: UInt = Input(UInt(32.W))
    val write_en_in: Bool = Input(Bool())
    
    // Outputs
    val ld_en_out: Bool = Output(Bool())
    val str_en_out: Bool = Output(Bool())
    val rd_addr_out: UInt = Output(UInt(5.W))
    val rs1_data_out: SInt = Output(SInt(32.W))
    val rs2_data_out: SInt = Output(SInt(32.W))
    val imm_out: SInt = Output(SInt(32.W))
    val alu_out: SInt = Output(SInt(32.W))
    val br_en_out: Bool = Output(Bool())
    val jal_out: Bool = Output(Bool())
    val jalr_out: Bool = Output(Bool())
    val lui_out: Bool = Output(Bool())
    val auipc_out: Bool = Output(Bool())
    val PC_out: UInt = Output(UInt(32.W))
    val nPC_out: UInt = Output(UInt(32.W))
    val write_en_out: Bool = Output(Bool())
}
class EX_MEM extends Module
{
    // Initializing the wires and modules
    val io: EX_MEM_IO = IO(new EX_MEM_IO)
    val ld_en: Bool = dontTouch(RegInit(0.B))
    val str_en: Bool = dontTouch(RegInit(0.B))
    val rd_addr: UInt = dontTouch(RegInit(0.U(5.W)))
    val rs1_data: SInt = dontTouch(RegInit(0.S(32.W)))
    val rs2_data: SInt = dontTouch(RegInit(0.S(32.W)))
    val imm: SInt = dontTouch(RegInit(0.S(32.W)))
    val alu: SInt = dontTouch(RegInit(0.S(32.W)))
    val br_en: Bool = dontTouch(RegInit(0.B))
    val jal: Bool = dontTouch(RegInit(0.B))
    val jalr: Bool = dontTouch(RegInit(0.B))
    val lui: Bool = dontTouch(RegInit(0.B))
    val auipc: Bool = dontTouch(RegInit(0.B))
    val PC: UInt = dontTouch(RegInit(0.U(32.W)))
    val nPC: UInt = dontTouch(RegInit(0.U(32.W)))
    val write_en: Bool = dontTouch(RegInit(0.B))
    
    // Wiring the modules
    Array(
        // Output ports
        io.ld_en_out, io.str_en_out, io.rd_addr_out, io.rs1_data_out, io.rs2_data_out,
        io.imm_out,   io.alu_out,    io.br_en_out,   io.jal_out,      io.jalr_out,
        io.lui_out,   io.auipc_out,  io.PC_out,      io.nPC_out,      io.write_en_out,

        // Registers
        ld_en,        str_en,        rd_addr,        rs1_data,        rs2_data,
        imm,          alu,           br_en,          jal,             jalr,
        lui,          auipc,         PC,             nPC,             write_en
    ) zip Array(  // Corresponding wires
        // Output wires
        ld_en,        str_en,        rd_addr,        rs1_data,        rs2_data,
        imm,          alu,           br_en,          jal,             jalr,
        lui,          auipc,         PC,             nPC,             write_en,

        // Registers
        io.ld_en_in,  io.str_en_in,  io.rd_addr_in,  io.rs1_data_in,  io.rs2_data_in,
        io.imm_in,    io.alu_in,     io.br_en_in,    io.jal_in,       io.jalr_in,
        io.lui_in,    io.auipc_in,   io.PC_in,       io.nPC_in,       io.write_en_in
    ) foreach
    {
        x => x._1 := x._2
    }
}
