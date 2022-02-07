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
    val jal_in: Bool = Input(Bool())
    val jalr_in: Bool = Input(Bool())
    val lui_in: Bool = Input(Bool())
    val auipc_in: Bool = Input(Bool())
    
    // Output pins
    val IF_ID_PC_out: UInt = Output(UInt(32.W))
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
    val jal_out: Bool = Input(Bool())
    val jalr_out: Bool = Input(Bool())
    val lui_out: Bool = Input(Bool())
    val auipc_out: Bool = Input(Bool())
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
    val jal: Bool = dontTouch(RegInit(io.jal_in))
    val jalr: Bool = dontTouch(RegInit(io.jalr_in))
    val lui: Bool = dontTouch(RegInit(io.lui_in))
    val auipc: Bool = dontTouch(RegInit(io.auipc_in))
    
    // Wiring the outputs
    Array(
        io.IF_ID_PC_out,
        io.rd_addr_out,
        io.func3_out,
        io.rs1_addr_out,
        io.rs2_addr_out,
        io.rs1_data_out,
        io.rs2_data_out,
        io.func7_out,
        io.imm_out,
        io.ld_en_out,
        io.str_en_out,
        io.op2sel_out,
        io.br_en_out,
        io.jal_out,
        io.jalr_out,
        io.lui_out,
        io.auipc_out
    ) zip Array(
        IF_ID_PC,
        rd_addr,
        func3,
        rs1_addr,
        rs2_addr,
        rs1_data,
        rs2_data,
        func7,
        imm,
        ld_en,
        str_en,
        op2sel,
        br_en,
        jal,
        jalr,
        lui,
        auipc
    ) foreach
    {
        x => x._1 := x._2
    }
}
