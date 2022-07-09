package FiveStageCore

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import Fetch.Fetch
import ALU.ALU
import ControlUnit.ControlUnit
import Decoder.Decoder
import RegFile.RegFile
import WriteBack.WriteBack
import PipelineRegs._
import HazardModules._

class FiveStageCore extends Module
{
    // Initializing the pins and modules
    val Fetch: Fetch = Module(new Fetch)
    val Decoder: Decoder = Module(new Decoder)
    val RegFile: RegFile = Module(new RegFile)
    val ALU: ALU = Module(new ALU)
    val ControlUnit: ControlUnit = Module(new ControlUnit)
    val WriteBack: WriteBack = Module(new WriteBack)
    val IF_ID: IF_ID = Module(new IF_ID)
    val ID_EX: ID_EX = Module(new ID_EX)
    val EX_MEM: EX_MEM = Module(new EX_MEM)
    val MEM_WB: MEM_WB = Module(new MEM_WB)
    val ForwardUnit: ForwardUnit = Module(new ForwardUnit)
    val inst_memory: Mem[UInt] = Mem(1024, UInt(32.W))
    val ld_str_memory: Mem[SInt] = Mem(1024, SInt(32.W))
    val nPC: UInt = WireInit(Mux(
        MEM_WB.io.jalr_out,
        (MEM_WB.io.rs1_data_out + MEM_WB.io.imm_out).asUInt,
        MEM_WB.io.PC_out + Cat(MEM_WB.io.imm_out(31, 1), "b0".U)
    ))
    val lui = WireInit(MEM_WB.io.imm_out << 12)
    val auipc: UInt = WireInit(MEM_WB.io.PC_out + (MEM_WB.io.imm_out.asUInt << 12))
    val rd_data = WireInit(Mux(
        MEM_WB.io.jal_out || MEM_WB.io.jalr_out, MEM_WB.io.nPC_out.asSInt, Mux(
            MEM_WB.io.lui_out, lui.asSInt, Mux(
                MEM_WB.io.auipc_out, auipc.asSInt, WriteBack.io.out
            )
        )
    ))
    
    // Loading assembly instructions
    loadMemoryFromFile(inst_memory, "assembly/hex_file.txt")
    
    /********************************************************************
                            WIRING THE MODULES
     ********************************************************************/
    
    // ld_str_memory
    when (EX_MEM.io.str_en_out)
    {
        ld_str_memory.write(EX_MEM.io.alu_out(23, 0).asUInt, EX_MEM.io.rs2_data_out)
    }

    // ALU.io.rs2
    when (ID_EX.io.op2sel_out === 1.B)
    {
        ALU.io.rs2 := ID_EX.io.imm_out
        EX_MEM.io.rs2_data_in := MuxLookup(
            ForwardUnit.io.forward_op2, ID_EX.io.rs2_data_out, Array(
                1.U -> EX_MEM.io.alu_out,
                2.U -> rd_data
            )
        )
    }.otherwise
    {
        Seq(
            ALU.io.rs2,
            EX_MEM.io.rs2_data_in
        ) map (_ :=  MuxLookup(
            ForwardUnit.io.forward_op2, ID_EX.io.rs2_data_out, Array(
                1.U -> EX_MEM.io.alu_out,
                2.U -> rd_data
            )
        ))
    }
    
    Array(  // Inputs
        // IF_ID
        IF_ID.io.PC_in,                 IF_ID.io.nPC_in,                IF_ID.io.inst_in,
        
        // Decoder
        Decoder.io.in,
        
        // RegFile
        RegFile.io.rd_addr,             RegFile.io.rs1_addr,            RegFile.io.rs2_addr,
        RegFile.io.rd_data,             RegFile.io.write_en,

        // ID_EX
        ID_EX.io.PC_in,                 ID_EX.io.nPC_in,                ID_EX.io.rd_addr_in,                          ID_EX.io.func3_in,     ID_EX.io.rs1_addr_in,
        ID_EX.io.rs2_addr_in,           ID_EX.io.rs1_data_in,           ID_EX.io.rs2_data_in,                         ID_EX.io.func7_in,     ID_EX.io.imm_in,
        ID_EX.io.ld_en_in,              ID_EX.io.str_en_in,             ID_EX.io.op2sel_in,                           ID_EX.io.br_en_in,     ID_EX.io.jal_in,
        ID_EX.io.jalr_in,               ID_EX.io.lui_in,                ID_EX.io.auipc_in,                            ID_EX.io.id_in,        ID_EX.io.write_en_in,
        
        // Control Unit
        ControlUnit.io.id,
        
        // ALU
        ALU.io.rs1,                     ALU.io.imm,                     ALU.io.func3,
        ALU.io.func7,                   ALU.io.id,                      ALU.io.op2sel,
        
        // EX_MEM
        EX_MEM.io.ld_en_in,             EX_MEM.io.str_en_in,            EX_MEM.io.alu_in,                             EX_MEM.io.rs2_data_in, EX_MEM.io.rd_addr_in,
        EX_MEM.io.br_en_in,             EX_MEM.io.jal_in,               EX_MEM.io.jalr_in,                            EX_MEM.io.lui_in,      EX_MEM.io.auipc_in,
        EX_MEM.io.nPC_in,               EX_MEM.io.rs1_data_in,          EX_MEM.io.imm_in,                             EX_MEM.io.PC_in,       EX_MEM.io.write_en_in,
        
        // MEM_WB
        MEM_WB.io.rd_addr_in,           MEM_WB.io.alu_in,               MEM_WB.io.load_in,                            MEM_WB.io.ld_en_in,    MEM_WB.io.br_en_in,
        MEM_WB.io.jal_in,               MEM_WB.io.jalr_in,              MEM_WB.io.lui_in,                             MEM_WB.io.auipc_in,    MEM_WB.io.nPC_in,
        MEM_WB.io.rs1_data_in,          MEM_WB.io.imm_in,               MEM_WB.io.PC_in,                              MEM_WB.io.write_en_in,
        
        // WriteBack
        WriteBack.io.alu_in,            WriteBack.io.load_in,           WriteBack.io.ld_en,
        WriteBack.io.br_en,             WriteBack.io.nPC,               WriteBack.io.nPC_en,
        
        // Fetch
        Fetch.io.nPC_in,                Fetch.io.nPC_en,
        
        // Forward Unit
        ForwardUnit.io.EX_MEM_rd_addr,  ForwardUnit.io.EX_MEM_write_en, ForwardUnit.io.MEM_WB_rd_addr,
        ForwardUnit.io.MEM_WB_write_en, ForwardUnit.io.rs1_addr,        ForwardUnit.io.rs2_addr
    ) zip Array(  // Corresponding input wires
        // IF_ID
        Fetch.io.PC_out,                Fetch.io.nPC_out,               inst_memory.read(Fetch.io.inst_out),
        
        // Decoder
        IF_ID.io.inst_out,
        
        // RegFile
        MEM_WB.io.rd_addr_out,          Decoder.io.rs1,                 Decoder.io.rs2,
        rd_data,                        MEM_WB.io.write_en_out,

        // ID_EX
        IF_ID.io.PC_out,                IF_ID.io.nPC_out,               Decoder.io.rd,                                Decoder.io.func3,      Decoder.io.rs1,
        Decoder.io.rs2,                 RegFile.io.rs1_data,            RegFile.io.rs2_data,                          Decoder.io.func7,      Decoder.io.imm,
        ControlUnit.io.ld_en,           ControlUnit.io.str_en,          ControlUnit.io.op2sel,                        ControlUnit.io.br_en,  ControlUnit.io.jal,
        ControlUnit.io.jalr,            ControlUnit.io.lui,             ControlUnit.io.auipc,                         Decoder.io.id,         Decoder.io.write_en,
        
        // Control Unit
        Decoder.io.id,
        
        // ALU
        MuxLookup(ForwardUnit.io.forward_op1, ID_EX.io.rs1_data_out, Array(
            1.U -> EX_MEM.io.alu_out,
            2.U -> rd_data
        )),
        ID_EX.io.imm_out,               ID_EX.io.func3_out,             ID_EX.io.func7_out,
        ID_EX.io.id_out,                ID_EX.io.op2sel_out,
        
        // EX_MEM
        ID_EX.io.ld_en_out,             ID_EX.io.str_en_out,            ALU.io.out,                                   ID_EX.io.rs2_data_out, ID_EX.io.rd_addr_out,
        ID_EX.io.br_en_out,             ID_EX.io.jal_out,               ID_EX.io.jalr_out,                            ID_EX.io.lui_out,      ID_EX.io.auipc_out,
        ID_EX.io.nPC_out,               ID_EX.io.rs1_data_out,          ID_EX.io.imm_out,                             ID_EX.io.PC_out,       ID_EX.io.write_en_out,
        
        // MEM_WB
        EX_MEM.io.rd_addr_out,          EX_MEM.io.alu_out,              ld_str_memory.read(EX_MEM.io.alu_out.asUInt), EX_MEM.io.ld_en_out,   EX_MEM.io.br_en_out,
        EX_MEM.io.jal_out,              EX_MEM.io.jalr_out,             EX_MEM.io.lui_out,                            EX_MEM.io.auipc_out,   EX_MEM.io.nPC_out,
        EX_MEM.io.rs1_data_out,         EX_MEM.io.imm_out,              EX_MEM.io.PC_out,                             EX_MEM.io.write_en_out,
        
        // WriteBack
        MEM_WB.io.alu_out,              MEM_WB.io.load_out,             MEM_WB.io.ld_en_out,
        MEM_WB.io.br_en_out,            MEM_WB.io.PC_out,               MEM_WB.io.jal_out || MEM_WB.io.jalr_out,
        
        // Fetch
        nPC,                            MEM_WB.io.jal_out || MEM_WB.io.jalr_out || MEM_WB.io.br_en_out,
        
        // Forward Unit
        EX_MEM.io.rd_addr_out,          EX_MEM.io.write_en_out,         MEM_WB.io.rd_addr_out,
        MEM_WB.io.write_en_out,         ID_EX.io.rs1_addr_out,          ID_EX.io.rs2_addr_out
    ) foreach
    {
        x => x._1 := x._2
    }
}
