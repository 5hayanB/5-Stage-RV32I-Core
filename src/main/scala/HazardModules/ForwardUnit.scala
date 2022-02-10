//package HazardModules
//
//import chisel3._
//
//class ForwardUnit_IO extends Bundle
//{
//    // Input
//    val rd_addr: UInt = Input(UInt(5.W))
//    val rs1_addr: UInt = Input(UInt(5.W))
//    val rs2_addr: UInt = Input(UInt(5.W))
//    val write_en: Bool = Input(Bool())
//
//    // Output
//    val forward_op1: UInt = Output(UInt(2.W))
//    val forward_op2: UInt = Output(UInt(2.W))
//}
//class ForwardUnit extends Module
//{
//    // Initializing the wires and modules
//    val io: ForwardUnit_IO = IO(new ForwardUnit_IO)
//    val rd_addr: UInt = dontTouch(WireInit(io.rd_addr))
//    val rs1_addr: UInt = dontTouch(WireInit(io.rs1_addr))
//    val rs2_addr: UInt = dontTouch(WireInit(io.rs2_addr))
//    val write_en: Bool = dontTouch(WireInit(io.write_en))
//
//    // Wiring the outputs
//    io.forward_op1 := 0.U
//    io.forward_op2 := 0.U
//
//    // EX_MEM Hazard
//    when ((io.write_en === 1.B) && (io.rd_addr =/= 0.U) && (io.rd_addr === io.rs1_addr) && (io.rd_addr === io.rs2_addr))
//    {
//        io.forward_op1 := 1.U
//        io.forward_op2 := 1.U
//    }.elsewhen ((io.write_en === 1.B) && (io.rd_addr =/= 0.U) && (io.rd_addr === io.rs1_addr))
//    {
//        io.forward_op1 := 1.U
//    }.elsewhen ((io.write_en === 1.B) && (io.rd_addr =/= 0.U) && (io.rd_addr === io.rs2_addr))
//    {
//        io.forward_op2 := 1.U
//    }
//
//    // MEM_WB Hazard
//    when ()
//}
