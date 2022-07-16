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
    val write_en_in: Bool = Input(Bool())
    
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
    val write_en_out: Bool = Output(Bool())
}
class MEM_WB extends Module
{
    // Initializing the wires and modules
    val io: MEM_WB_IO = IO(new MEM_WB_IO)
    val rd_addr: UInt = dontTouch(RegInit(0.U(5.W)))
    val rs1_data: SInt = dontTouch(RegInit(0.S(32.W)))
    val imm: SInt = dontTouch(RegInit(0.S(32.W)))
    val alu: SInt = dontTouch(RegInit(0.S(32.W)))
    val load: SInt = dontTouch(RegInit(0.S(32.W)))
    val load_en: Bool = dontTouch(RegInit(0.B))
    val br_en: Bool = dontTouch(RegInit(0.B))
    val jal: Bool = dontTouch(RegInit(0.B))
    val jalr: Bool = dontTouch(RegInit(0.B))
    val lui: Bool = dontTouch(RegInit(0.B))
    val auipc: Bool = dontTouch(RegInit(0.B))
    val PC: UInt = dontTouch(RegInit(0.U(32.W)))
    val nPC: UInt = dontTouch(RegInit(0.U(32.W)))
    val write_en: Bool = dontTouch(RegInit(0.B))
    
    // Wiring the outputs
    Array(
        // Output ports
        io.rd_addr_out, io.rs1_data_out, io.imm_out, io.alu_out,      io.load_out,
        io.ld_en_out,   io.br_en_out,    io.jal_out, io.jalr_out,     io.lui_out,
        io.auipc_out,   io.PC_out,       io.nPC_out, io.write_en_out,

        // Registers
        rd_addr,        rs1_data,        imm,        alu,             load,
        load_en,        br_en,           jal,        jalr,            lui,
        auipc,          PC,              nPC,        write_en
    ) zip Array(  // Corresponding wires
        // Output ports
        rd_addr,        rs1_data,        imm,        alu,             load,
        load_en,        br_en,           jal,        jalr,            lui,
        auipc,          PC,              nPC,        write_en,

        // Registers
        io.rd_addr_in,  io.rs1_data_in,  io.imm_in,  io.alu_in,       io.load_in,
        io.ld_en_in,    io.br_en_in,     io.jal_in,  io.jalr_in,      io.lui_in,
        io.auipc_in,    io.PC_in,        io.nPC_in,  io.write_en_in
    ) foreach
    {
        x => x._1 := x._2
    }
}
