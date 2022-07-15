package PipelineRegs

import chisel3._

class ID_EX_IO extends Bundle
{
    // Input pins
    val PC_in: UInt = Input(UInt(32.W))
    val nPC_in: UInt = Input(UInt(32.W))
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
    val jal_in: Bool = Input(Bool())
    val jalr_in: Bool = Input(Bool())
    val lui_in: Bool = Input(Bool())
    val auipc_in: Bool = Input(Bool())
    val id_in: UInt = Input(UInt(7.W))
    val write_en_in: Bool = Input(Bool())
    
    // Output pins
    val PC_out: UInt = Output(UInt(32.W))
    val nPC_out: UInt = Output(UInt(32.W))
    val rd_addr_out: UInt = Output(UInt(5.W))
    val func3_out: UInt = Output(UInt(3.W))
    val rs1_addr_out: UInt = Output(UInt(5.W))
    val rs2_addr_out: UInt = Output(UInt(5.W))
    val rs1_data_out: SInt = Output(SInt(32.W))
    val rs2_data_out: SInt = Output(SInt(32.W))
    val func7_out: UInt = Output(UInt(7.W))
    val imm_out: SInt = Output(SInt(32.W))
    val ld_en_out: Bool = Output(Bool())
    val str_en_out: Bool = Output(Bool())
    val op2sel_out: Bool = Output(Bool())
    val br_en_out: Bool = Output(Bool())
    val jal_out: Bool = Output(Bool())
    val jalr_out: Bool = Output(Bool())
    val lui_out: Bool = Output(Bool())
    val auipc_out: Bool = Output(Bool())
    val id_out: UInt = Output(UInt(7.W))
    val write_en_out: Bool = Output(Bool())
}
class ID_EX extends Module
{
    // Initializing the wires and modules
    val io: ID_EX_IO = IO(new ID_EX_IO)
    val PC: UInt = dontTouch(RegInit(0.U(32.W)))
    val nPC: UInt = dontTouch(RegInit(0.U(32.W)))
    val rd_addr: UInt = dontTouch(RegInit(0.U(5.W)))
    val func3: UInt = dontTouch(RegInit(0.U(3.W)))
    val rs1_addr: UInt = dontTouch(RegInit(0.U(5.W)))
    val rs2_addr: UInt = dontTouch(RegInit(0.U(5.W)))
    val rs1_data: SInt = dontTouch(RegInit(0.S(32.W)))
    val rs2_data: SInt = dontTouch(RegInit(0.S(32.W)))
    val func7: UInt = dontTouch(RegInit(0.U(7.W)))
    val imm: SInt = dontTouch(RegInit(0.S(32.W)))
    val ld_en: Bool = dontTouch(RegInit(0.B))
    val str_en: Bool = dontTouch(RegInit(0.B))
    val op2sel: Bool = dontTouch(RegInit(0.B))
    val br_en: Bool = dontTouch(RegInit(0.B))
    val jal: Bool = dontTouch(RegInit(0.B))
    val jalr: Bool = dontTouch(RegInit(0.B))
    val lui: Bool = dontTouch(RegInit(0.B))
    val auipc: Bool = dontTouch(RegInit(0.B))
    val id: UInt = dontTouch(RegInit(0.U(7.W)))
    val write_en: Bool = dontTouch(RegInit(0.B))
    
    // Wiring the modules
    Array(
        // Output ports
        io.PC_out,       io.nPC_out,      io.rd_addr_out,  io.func3_out, io.rs1_addr_out,
        io.rs2_addr_out, io.rs1_data_out, io.rs2_data_out, io.func7_out, io.imm_out,
        io.ld_en_out,    io.str_en_out,   io.op2sel_out,   io.br_en_out, io.jal_out,
        io.jalr_out,     io.lui_out,      io.auipc_out,    io.id_out,    io.write_en_out,

        // Registers
        PC,              nPC,             rd_addr,         func3,        rs1_addr,
        rs2_addr,        rs1_data,        rs2_data,        func7,        imm,
        ld_en,           str_en,          op2sel,          br_en,        jal,
        jalr,            lui,             auipc,           id,           write_en
    ) zip Array(  // Corresponding wires
        // Output ports
        PC,              nPC,             rd_addr,         func3,        rs1_addr,
        rs2_addr,        rs1_data,        rs2_data,        func7,        imm,
        ld_en,           str_en,          op2sel,          br_en,        jal,
        jalr,            lui,             auipc,           id,           write_en,

        // Registers
        io.PC_in,              io.nPC_in,             io.rd_addr_in,         io.func3_in,        io.rs1_addr_in,
        io.rs2_addr_in,        io.rs1_data_in,        io.rs2_data_in,        io.func7_in,        io.imm_in,
        io.ld_en_in,           io.str_en_in,          io.op2sel_in,          io.br_en_in,        io.jal_in,
        io.jalr_in,            io.lui_in,             io.auipc_in,           io.id_in,           io.write_en_in
    ) foreach
    {
        x => x._1 := x._2
    }
}
