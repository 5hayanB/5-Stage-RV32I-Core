circuit FiveStageCore :
  module Fetch :
    input clock : Clock
    input reset : UInt<1>
    input io_nPC_in : UInt<32>
    input io_nPC_en : UInt<1>
    output io_inst_out : UInt<24>
    output io_PC_out : UInt<32>
    output io_nPC_out : UInt<32>

    reg PC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), PC) @[Fetch.scala 21:37]
    node _nPC_T = add(PC, UInt<3>("h4")) @[Fetch.scala 24:43]
    node _nPC_T_1 = tail(_nPC_T, 1) @[Fetch.scala 24:43]
    node _inst_out_T = bits(PC, 25, 2) @[Fetch.scala 25:51]
    node _nPC_out_T = add(PC, UInt<3>("h4")) @[Fetch.scala 27:47]
    node _nPC_out_T_1 = tail(_nPC_out_T, 1) @[Fetch.scala 27:47]
    node nPC = _nPC_T_1
    node _PC_T = mux(io_nPC_en, io_nPC_in, nPC) @[Fetch.scala 35:14]
    node nPC_in = io_nPC_in
    node nPC_en = io_nPC_en
    node inst_out = _inst_out_T
    node PC_out = PC
    node nPC_out = _nPC_out_T_1
    io_inst_out <= inst_out @[Fetch.scala 30:17]
    io_PC_out <= PC_out @[Fetch.scala 31:15]
    io_nPC_out <= nPC @[Fetch.scala 32:16]
    PC <= mux(reset, UInt<32>("h0"), _PC_T) @[Fetch.scala 21:{37,37} 35:8]

  module R_Type :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<25>
    input io_en : UInt<1>
    output io_rd : UInt<5>
    output io_func3 : UInt<3>
    output io_rs1 : UInt<5>
    output io_rs2 : UInt<5>
    output io_func7 : UInt<7>

    node _rd_T = bits(io_in, 4, 0) @[R_Type.scala 23:44]
    node _func3_T = bits(io_in, 7, 5) @[R_Type.scala 24:47]
    node _rs1_T = bits(io_in, 12, 8) @[R_Type.scala 25:45]
    node _rs2_T = bits(io_in, 17, 13) @[R_Type.scala 26:45]
    node _func7_T = bits(io_in, 24, 18) @[R_Type.scala 27:47]
    node en = io_en
    node rd = _rd_T
    node _GEN_0 = mux(en, rd, UInt<1>("h0")) @[R_Type.scala 31:5 46:27 63:27]
    node func3 = _func3_T
    node _GEN_1 = mux(en, func3, UInt<1>("h0")) @[R_Type.scala 31:5 46:27 63:27]
    node rs1 = _rs1_T
    node _GEN_2 = mux(en, rs1, UInt<1>("h0")) @[R_Type.scala 31:5 46:27 63:27]
    node rs2 = _rs2_T
    node _GEN_3 = mux(en, rs2, UInt<1>("h0")) @[R_Type.scala 31:5 46:27 63:27]
    node func7 = _func7_T
    node _GEN_4 = mux(en, func7, UInt<1>("h0")) @[R_Type.scala 31:5 46:27 63:27]
    io_rd <= _GEN_0
    io_func3 <= _GEN_1
    io_rs1 <= _GEN_2
    io_rs2 <= _GEN_3
    io_func7 <= _GEN_4

  module I_Type :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<25>
    input io_en : UInt<1>
    output io_rd : UInt<5>
    output io_func3 : UInt<3>
    output io_rs1 : UInt<5>
    output io_imm : SInt<32>

    node _rd_T = bits(io_in, 4, 0) @[I_Type.scala 22:44]
    node _func3_T = bits(io_in, 7, 5) @[I_Type.scala 23:47]
    node _rs1_T = bits(io_in, 12, 8) @[I_Type.scala 24:45]
    node _imm_T = bits(io_in, 24, 13) @[I_Type.scala 25:45]
    node _imm_T_1 = asSInt(_imm_T) @[I_Type.scala 25:54]
    node en = io_en
    node rd = _rd_T
    node _GEN_0 = mux(en, rd, UInt<1>("h0")) @[I_Type.scala 29:5 42:27 57:27]
    node func3 = _func3_T
    node _GEN_1 = mux(en, func3, UInt<1>("h0")) @[I_Type.scala 29:5 42:27 57:27]
    node rs1 = _rs1_T
    node _GEN_2 = mux(en, rs1, UInt<1>("h0")) @[I_Type.scala 29:5 42:27 57:27]
    node imm = _imm_T_1
    node _GEN_3 = mux(en, imm, asSInt(UInt<1>("h0"))) @[I_Type.scala 29:5 42:27 57:27]
    io_rd <= _GEN_0
    io_func3 <= _GEN_1
    io_rs1 <= _GEN_2
    io_imm <= pad(_GEN_3, 32)

  module S_Type :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<25>
    input io_en : UInt<1>
    output io_func3 : UInt<3>
    output io_rs1 : UInt<5>
    output io_rs2 : UInt<5>
    output io_imm : SInt<32>

    node _func3_T = bits(io_in, 7, 5) @[S_Type.scala 23:47]
    node _rs1_T = bits(io_in, 12, 8) @[S_Type.scala 24:45]
    node _rs2_T = bits(io_in, 17, 13) @[S_Type.scala 25:45]
    node _imm_T = bits(io_in, 24, 18) @[S_Type.scala 28:14]
    node _imm_T_1 = bits(io_in, 4, 0) @[S_Type.scala 29:14]
    node _imm_T_2 = cat(_imm_T, _imm_T_1) @[Cat.scala 31:58]
    node _imm_T_3 = asSInt(_imm_T_2) @[S_Type.scala 30:7]
    node en = io_en
    node func3 = _func3_T
    node _GEN_0 = mux(en, func3, UInt<1>("h0")) @[S_Type.scala 34:5 47:27 62:27]
    node rs1 = _rs1_T
    node _GEN_1 = mux(en, rs1, UInt<1>("h0")) @[S_Type.scala 34:5 47:27 62:27]
    node rs2 = _rs2_T
    node _GEN_2 = mux(en, rs2, UInt<1>("h0")) @[S_Type.scala 34:5 47:27 62:27]
    node imm = _imm_T_3
    node _GEN_3 = mux(en, imm, asSInt(UInt<1>("h0"))) @[S_Type.scala 34:5 47:27 62:27]
    io_func3 <= _GEN_0
    io_rs1 <= _GEN_1
    io_rs2 <= _GEN_2
    io_imm <= pad(_GEN_3, 32)

  module SB_Type :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<25>
    input io_en : UInt<1>
    output io_func3 : UInt<3>
    output io_rs1 : UInt<5>
    output io_rs2 : UInt<5>
    output io_imm : SInt<32>

    node _func3_T = bits(io_in, 7, 5) @[SB_Type.scala 23:47]
    node _rs1_T = bits(io_in, 12, 8) @[SB_Type.scala 24:45]
    node _rs2_T = bits(io_in, 17, 13) @[SB_Type.scala 25:45]
    node _imm_T = bits(io_in, 24, 24) @[SB_Type.scala 28:14]
    node _imm_T_1 = bits(io_in, 0, 0) @[SB_Type.scala 29:14]
    node _imm_T_2 = bits(io_in, 23, 18) @[SB_Type.scala 30:14]
    node _imm_T_3 = bits(io_in, 4, 1) @[SB_Type.scala 31:14]
    node imm_lo = cat(_imm_T_3, UInt<1>("h0")) @[Cat.scala 31:58]
    node imm_hi_hi = cat(_imm_T, _imm_T_1) @[Cat.scala 31:58]
    node imm_hi = cat(imm_hi_hi, _imm_T_2) @[Cat.scala 31:58]
    node _imm_T_4 = cat(imm_hi, imm_lo) @[Cat.scala 31:58]
    node _imm_T_5 = asSInt(_imm_T_4) @[SB_Type.scala 33:7]
    node en = io_en
    node func3 = _func3_T
    node _GEN_0 = mux(en, func3, UInt<1>("h0")) @[SB_Type.scala 37:5 50:27 65:27]
    node rs1 = _rs1_T
    node _GEN_1 = mux(en, rs1, UInt<1>("h0")) @[SB_Type.scala 37:5 50:27 65:27]
    node rs2 = _rs2_T
    node _GEN_2 = mux(en, rs2, UInt<1>("h0")) @[SB_Type.scala 37:5 50:27 65:27]
    node imm = _imm_T_5
    node _GEN_3 = mux(en, imm, asSInt(UInt<1>("h0"))) @[SB_Type.scala 37:5 50:27 65:27]
    io_func3 <= _GEN_0
    io_rs1 <= _GEN_1
    io_rs2 <= _GEN_2
    io_imm <= pad(_GEN_3, 32)

  module U_Type :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<25>
    input io_en : UInt<1>
    output io_rd : UInt<5>
    output io_imm : SInt<20>

    node _rd_T = bits(io_in, 4, 0) @[U_Type.scala 21:44]
    node _imm_T = bits(io_in, 24, 5) @[U_Type.scala 22:45]
    node _imm_T_1 = asSInt(_imm_T) @[U_Type.scala 22:53]
    node en = io_en
    node rd = _rd_T
    node _GEN_0 = mux(en, rd, UInt<1>("h0")) @[U_Type.scala 26:5 35:27 46:27]
    node imm = _imm_T_1
    node _GEN_1 = mux(en, imm, asSInt(UInt<1>("h0"))) @[U_Type.scala 26:5 35:27 46:27]
    io_rd <= _GEN_0
    io_imm <= _GEN_1

  module UJ_Type :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<25>
    input io_en : UInt<1>
    output io_rd : UInt<5>
    output io_imm : SInt<20>

    node _rd_T = bits(io_in, 4, 0) @[UJ_Type.scala 21:44]
    node _imm_T = bits(io_in, 24, 24) @[UJ_Type.scala 24:14]
    node _imm_T_1 = bits(io_in, 12, 5) @[UJ_Type.scala 25:14]
    node _imm_T_2 = bits(io_in, 13, 13) @[UJ_Type.scala 26:14]
    node _imm_T_3 = bits(io_in, 23, 14) @[UJ_Type.scala 27:14]
    node imm_lo = cat(_imm_T_3, UInt<1>("h0")) @[Cat.scala 31:58]
    node imm_hi_hi = cat(_imm_T, _imm_T_1) @[Cat.scala 31:58]
    node imm_hi = cat(imm_hi_hi, _imm_T_2) @[Cat.scala 31:58]
    node _imm_T_4 = cat(imm_hi, imm_lo) @[Cat.scala 31:58]
    node _imm_T_5 = asSInt(_imm_T_4) @[UJ_Type.scala 29:7]
    node en = io_en
    node rd = _rd_T
    node _GEN_0 = mux(en, rd, UInt<1>("h0")) @[UJ_Type.scala 33:5 42:27 53:27]
    node imm = _imm_T_5
    node _GEN_1 = mux(en, imm, asSInt(UInt<1>("h0"))) @[UJ_Type.scala 33:5 42:27 53:27]
    io_rd <= _GEN_0
    io_imm <= asSInt(bits(_GEN_1, 19, 0))

  module Decoder :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<32>
    output io_rd : UInt<5>
    output io_func3 : UInt<3>
    output io_rs1 : UInt<5>
    output io_rs2 : UInt<5>
    output io_func7 : UInt<7>
    output io_imm : SInt<32>
    output io_id : UInt<5>

    inst r of R_Type @[Decoder.scala 25:27]
    inst i of I_Type @[Decoder.scala 26:27]
    inst s of S_Type @[Decoder.scala 27:27]
    inst sb of SB_Type @[Decoder.scala 28:29]
    inst u of U_Type @[Decoder.scala 29:27]
    inst uj of UJ_Type @[Decoder.scala 30:29]
    node _inst_T = bits(io_in, 31, 7) @[Decoder.scala 23:30]
    node _id_T = bits(io_in, 6, 2) @[Decoder.scala 24:44]
    node _rd_T = or(r.io_rd, i.io_rd) @[Decoder.scala 31:47]
    node _rd_T_1 = or(_rd_T, u.io_rd) @[Decoder.scala 31:57]
    node _rd_T_2 = or(_rd_T_1, uj.io_rd) @[Decoder.scala 31:67]
    node _func3_T = or(r.io_func3, i.io_func3) @[Decoder.scala 32:53]
    node _func3_T_1 = or(_func3_T, s.io_func3) @[Decoder.scala 32:66]
    node _func3_T_2 = or(_func3_T_1, sb.io_func3) @[Decoder.scala 32:79]
    node _rs1_T = or(r.io_rs1, i.io_rs1) @[Decoder.scala 33:49]
    node _rs1_T_1 = or(_rs1_T, s.io_rs1) @[Decoder.scala 33:60]
    node _rs1_T_2 = or(_rs1_T_1, sb.io_rs1) @[Decoder.scala 33:71]
    node _rs2_T = or(r.io_rs2, s.io_rs2) @[Decoder.scala 34:49]
    node _rs2_T_1 = or(_rs2_T, sb.io_rs2) @[Decoder.scala 34:60]
    node _imm_T = or(i.io_imm, s.io_imm) @[Decoder.scala 36:49]
    node _imm_T_1 = asSInt(_imm_T) @[Decoder.scala 36:49]
    node _imm_T_2 = or(_imm_T_1, sb.io_imm) @[Decoder.scala 36:60]
    node _imm_T_3 = asSInt(_imm_T_2) @[Decoder.scala 36:60]
    node _imm_T_4 = or(_imm_T_3, u.io_imm) @[Decoder.scala 36:72]
    node _imm_T_5 = asSInt(_imm_T_4) @[Decoder.scala 36:72]
    node _imm_T_6 = or(_imm_T_5, uj.io_imm) @[Decoder.scala 36:83]
    node _imm_T_7 = asSInt(_imm_T_6) @[Decoder.scala 36:83]
    node id = _id_T
    node _T = eq(id, UInt<4>("hc")) @[Decoder.scala 59:14]
    node _T_1 = eq(id, UInt<4>("he")) @[Decoder.scala 59:29]
    node _T_2 = or(_T, _T_1) @[Decoder.scala 59:23]
    node _T_3 = eq(id, UInt<1>("h0")) @[Decoder.scala 79:20]
    node _T_4 = eq(id, UInt<3>("h4")) @[Decoder.scala 79:34]
    node _T_5 = or(_T_3, _T_4) @[Decoder.scala 79:28]
    node _T_6 = eq(id, UInt<5>("h19")) @[Decoder.scala 79:48]
    node _T_7 = or(_T_5, _T_6) @[Decoder.scala 79:42]
    node _T_8 = eq(id, UInt<4>("h8")) @[Decoder.scala 99:20]
    node _T_9 = eq(id, UInt<5>("h18")) @[Decoder.scala 119:20]
    node _T_10 = eq(id, UInt<3>("h5")) @[Decoder.scala 139:19]
    node _T_11 = eq(id, UInt<4>("hd")) @[Decoder.scala 139:33]
    node _T_12 = or(_T_10, _T_11) @[Decoder.scala 139:27]
    node _T_13 = eq(id, UInt<5>("h1b")) @[Decoder.scala 159:20]
    node _GEN_0 = mux(_T_13, UInt<1>("h0"), UInt<1>("h0")) @[Decoder.scala 160:5 177:27 196:27]
    node _GEN_1 = mux(_T_13, UInt<1>("h1"), UInt<1>("h0")) @[Decoder.scala 160:5 177:27 196:27]
    node _GEN_2 = mux(_T_12, UInt<1>("h0"), _GEN_0) @[Decoder.scala 140:5 157:27]
    node _GEN_3 = mux(_T_12, UInt<1>("h1"), _GEN_0) @[Decoder.scala 140:5 157:27]
    node _GEN_4 = mux(_T_12, UInt<1>("h0"), _GEN_1) @[Decoder.scala 140:5 157:27]
    node _GEN_5 = mux(_T_9, UInt<1>("h0"), _GEN_2) @[Decoder.scala 120:5 137:27]
    node _GEN_6 = mux(_T_9, UInt<1>("h1"), _GEN_2) @[Decoder.scala 120:5 137:27]
    node _GEN_7 = mux(_T_9, UInt<1>("h0"), _GEN_3) @[Decoder.scala 120:5 137:27]
    node _GEN_8 = mux(_T_9, UInt<1>("h0"), _GEN_4) @[Decoder.scala 120:5 137:27]
    node _GEN_9 = mux(_T_8, UInt<1>("h0"), _GEN_5) @[Decoder.scala 100:5 117:27]
    node _GEN_10 = mux(_T_8, UInt<1>("h1"), _GEN_5) @[Decoder.scala 100:5 117:27]
    node _GEN_11 = mux(_T_8, UInt<1>("h0"), _GEN_6) @[Decoder.scala 100:5 117:27]
    node _GEN_12 = mux(_T_8, UInt<1>("h0"), _GEN_7) @[Decoder.scala 100:5 117:27]
    node _GEN_13 = mux(_T_8, UInt<1>("h0"), _GEN_8) @[Decoder.scala 100:5 117:27]
    node _GEN_14 = mux(_T_7, UInt<1>("h0"), _GEN_9) @[Decoder.scala 80:5 97:27]
    node _GEN_15 = mux(_T_7, UInt<1>("h1"), _GEN_9) @[Decoder.scala 80:5 97:27]
    node _GEN_16 = mux(_T_7, UInt<1>("h0"), _GEN_10) @[Decoder.scala 80:5 97:27]
    node _GEN_17 = mux(_T_7, UInt<1>("h0"), _GEN_11) @[Decoder.scala 80:5 97:27]
    node _GEN_18 = mux(_T_7, UInt<1>("h0"), _GEN_12) @[Decoder.scala 80:5 97:27]
    node _GEN_19 = mux(_T_7, UInt<1>("h0"), _GEN_13) @[Decoder.scala 80:5 97:27]
    node _GEN_20 = mux(_T_2, UInt<1>("h1"), _GEN_14) @[Decoder.scala 60:5 77:23]
    node _GEN_21 = mux(_T_2, UInt<1>("h0"), _GEN_15) @[Decoder.scala 60:5 77:23]
    node _GEN_22 = mux(_T_2, UInt<1>("h0"), _GEN_16) @[Decoder.scala 60:5 77:23]
    node _GEN_23 = mux(_T_2, UInt<1>("h0"), _GEN_17) @[Decoder.scala 60:5 77:23]
    node _GEN_24 = mux(_T_2, UInt<1>("h0"), _GEN_18) @[Decoder.scala 60:5 77:23]
    node _GEN_25 = mux(_T_2, UInt<1>("h0"), _GEN_19) @[Decoder.scala 60:5 77:23]
    node inst = _inst_T
    node rd = _rd_T_2
    node func3 = _func3_T_2
    node rs1 = _rs1_T_2
    node rs2 = _rs2_T_1
    node func7 = r.io_func7
    node imm = _imm_T_7
    io_rd <= rd @[Decoder.scala 219:19]
    io_func3 <= func3 @[Decoder.scala 219:19]
    io_rs1 <= rs1 @[Decoder.scala 219:19]
    io_rs2 <= rs2 @[Decoder.scala 219:19]
    io_func7 <= func7 @[Decoder.scala 219:19]
    io_imm <= imm @[Decoder.scala 219:19]
    io_id <= id @[Decoder.scala 219:19]
    r.clock <= clock
    r.reset <= reset
    r.io_in <= inst @[Decoder.scala 55:19]
    r.io_en <= _GEN_20
    i.clock <= clock
    i.reset <= reset
    i.io_in <= inst @[Decoder.scala 55:19]
    i.io_en <= _GEN_21
    s.clock <= clock
    s.reset <= reset
    s.io_in <= inst @[Decoder.scala 55:19]
    s.io_en <= _GEN_22
    sb.clock <= clock
    sb.reset <= reset
    sb.io_in <= inst @[Decoder.scala 55:19]
    sb.io_en <= _GEN_23
    u.clock <= clock
    u.reset <= reset
    u.io_in <= inst @[Decoder.scala 55:19]
    u.io_en <= _GEN_24
    uj.clock <= clock
    uj.reset <= reset
    uj.io_in <= inst @[Decoder.scala 55:19]
    uj.io_en <= _GEN_25

  module RegFile :
    input clock : Clock
    input reset : UInt<1>
    input io_rd_addr : UInt<5>
    input io_rs1_addr : UInt<5>
    input io_rs2_addr : UInt<5>
    input io_rd_data : SInt<32>
    output io_rs1_data : SInt<32>
    output io_rs2_data : SInt<32>

    mem regFile : @[RegFile.scala 21:33]
      data-type => SInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => rs1_data_MPORT
      reader => rs2_data_MPORT
      writer => MPORT
      read-under-write => undefined
    node rs1_addr = io_rs1_addr
    node _rs1_data_T = or(rs1_addr, UInt<10>("h0")) @[RegFile.scala 26:57]
    node _rs1_data_T_1 = bits(_rs1_data_T, 9, 0) @[RegFile.scala 26:57]
    node rs2_addr = io_rs2_addr
    node _rs2_data_T = or(rs2_addr, UInt<10>("h0")) @[RegFile.scala 27:57]
    node _rs2_data_T_1 = bits(_rs2_data_T, 9, 0) @[RegFile.scala 27:57]
    node rd_addr = io_rd_addr
    node _T = or(rd_addr, UInt<10>("h0"))
    node _T_1 = bits(_T, 9, 0)
    node _T_2 = eq(rs1_addr, UInt<1>("h0")) @[RegFile.scala 34:20]
    node rs1_data = regFile.rs1_data_MPORT.data
    node _GEN_0 = mux(_T_2, asSInt(UInt<1>("h0")), rs1_data) @[RegFile.scala 35:5 36:21 39:21]
    node _T_3 = eq(rs2_addr, UInt<1>("h0")) @[RegFile.scala 41:20]
    node rs2_data = regFile.rs2_data_MPORT.data
    node _GEN_1 = mux(_T_3, asSInt(UInt<1>("h0")), rs2_data) @[RegFile.scala 42:5 43:21 46:21]
    node rd_data = io_rd_data
    node x0 = UInt<32>("h0")
    io_rs1_data <= _GEN_0
    io_rs2_data <= _GEN_1
    regFile.rs1_data_MPORT.addr <= _rs1_data_T_1 @[RegFile.scala 26:57]
    regFile.rs1_data_MPORT.en <= UInt<1>("h1") @[RegFile.scala 26:57]
    regFile.rs1_data_MPORT.clk <= clock @[RegFile.scala 26:57]
    regFile.rs2_data_MPORT.addr <= _rs2_data_T_1 @[RegFile.scala 27:57]
    regFile.rs2_data_MPORT.en <= UInt<1>("h1") @[RegFile.scala 27:57]
    regFile.rs2_data_MPORT.clk <= clock @[RegFile.scala 27:57]
    regFile.MPORT.addr <= _T_1
    regFile.MPORT.en <= UInt<1>("h1")
    regFile.MPORT.clk <= clock
    regFile.MPORT.data <= rd_data
    regFile.MPORT.mask <= UInt<1>("h1")

  module ALU :
    input clock : Clock
    input reset : UInt<1>
    input io_rs1 : SInt<32>
    input io_rs2 : SInt<32>
    input io_imm : SInt<32>
    input io_func3 : UInt<3>
    input io_func7 : UInt<7>
    input io_id : UInt<5>
    input io_op2sel : UInt<1>
    output io_out : SInt<32>

    node _op2_T = mux(io_op2sel, io_imm, io_rs2) @[ALU.scala 24:43]
    node _opSel_T = bits(io_id, 2, 2) @[ALU.scala 25:51]
    node _opSel_T_1 = bits(io_func7, 5, 5) @[ALU.scala 25:64]
    node opSel_hi = cat(_opSel_T, _opSel_T_1) @[Cat.scala 31:58]
    node _opSel_T_2 = cat(opSel_hi, io_func3) @[Cat.scala 31:58]
    node op2 = _op2_T
    node _add_T = add(io_rs1, op2) @[ALU.scala 26:47]
    node _add_T_1 = tail(_add_T, 1) @[ALU.scala 26:47]
    node _add_T_2 = asSInt(_add_T_1) @[ALU.scala 26:47]
    node _sub_T = sub(io_rs1, op2) @[ALU.scala 27:47]
    node _sub_T_1 = tail(_sub_T, 1) @[ALU.scala 27:47]
    node _sub_T_2 = asSInt(_sub_T_1) @[ALU.scala 27:47]
    node _sll_T = bits(op2, 18, 0) @[ALU.scala 28:54]
    node _sll_T_1 = dshl(io_rs1, _sll_T) @[ALU.scala 28:48]
    node _lt_T = lt(io_rs1, op2) @[ALU.scala 29:50]
    node _lt_T_1 = mux(_lt_T, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[ALU.scala 29:42]
    node _ltu_T = asUInt(io_rs1) @[ALU.scala 30:51]
    node _ltu_T_1 = asUInt(op2) @[ALU.scala 30:64]
    node _ltu_T_2 = lt(_ltu_T, _ltu_T_1) @[ALU.scala 30:58]
    node _ltu_T_3 = mux(_ltu_T_2, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[ALU.scala 30:43]
    node _xor_T = xor(io_rs1, op2) @[ALU.scala 31:47]
    node _xor_T_1 = asSInt(_xor_T) @[ALU.scala 31:47]
    node _srl_T = bits(op2, 18, 0) @[ALU.scala 32:54]
    node _srl_T_1 = dshr(io_rs1, _srl_T) @[ALU.scala 32:48]
    node _sra_T = bits(op2, 18, 0) @[ALU.scala 33:54]
    node _sra_T_1 = dshr(io_rs1, _sra_T) @[ALU.scala 33:48]
    node _or_T = or(io_rs1, op2) @[ALU.scala 34:46]
    node _or_T_1 = asSInt(_or_T) @[ALU.scala 34:46]
    node _and_T = and(io_rs1, op2) @[ALU.scala 35:47]
    node _and_T_1 = asSInt(_and_T) @[ALU.scala 35:47]
    node _beq_T = eq(io_rs1, op2) @[ALU.scala 36:51]
    node _beq_T_1 = mux(_beq_T, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[ALU.scala 36:43]
    node _bge_T = geq(io_rs1, op2) @[ALU.scala 37:48]
    node _bge_T_1 = asSInt(_bge_T) @[ALU.scala 37:56]
    node _bgeu_T = asUInt(io_rs1) @[ALU.scala 38:49]
    node _bgeu_T_1 = asUInt(op2) @[ALU.scala 38:63]
    node _bgeu_T_2 = geq(_bgeu_T, _bgeu_T_1) @[ALU.scala 38:56]
    node _bgeu_T_3 = asSInt(_bgeu_T_2) @[ALU.scala 38:71]
    node _bne_T = neq(io_rs1, op2) @[ALU.scala 39:51]
    node _bne_T_1 = mux(_bne_T, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[ALU.scala 39:43]
    node opSel = _opSel_T_2
    node _io_out_T = eq(opSel, UInt<2>("h2")) @[ALU.scala 45:20]
    node _io_out_T_1 = eq(opSel, UInt<5>("h10")) @[ALU.scala 45:37]
    node _io_out_T_2 = or(_io_out_T, _io_out_T_1) @[ALU.scala 45:28]
    node _io_out_T_3 = eq(opSel, UInt<5>("h18")) @[ALU.scala 46:20]
    node _io_out_T_4 = eq(opSel, UInt<5>("h11")) @[ALU.scala 47:20]
    node _io_out_T_5 = eq(opSel, UInt<3>("h4")) @[ALU.scala 48:20]
    node _io_out_T_6 = eq(opSel, UInt<5>("h12")) @[ALU.scala 48:37]
    node _io_out_T_7 = or(_io_out_T_5, _io_out_T_6) @[ALU.scala 48:28]
    node _io_out_T_8 = eq(opSel, UInt<3>("h6")) @[ALU.scala 49:20]
    node _io_out_T_9 = eq(opSel, UInt<5>("h13")) @[ALU.scala 49:37]
    node _io_out_T_10 = or(_io_out_T_8, _io_out_T_9) @[ALU.scala 49:28]
    node _io_out_T_11 = eq(opSel, UInt<5>("h14")) @[ALU.scala 50:20]
    node _io_out_T_12 = eq(opSel, UInt<5>("h15")) @[ALU.scala 51:20]
    node _io_out_T_13 = eq(opSel, UInt<5>("h1d")) @[ALU.scala 52:20]
    node _io_out_T_14 = eq(opSel, UInt<5>("h16")) @[ALU.scala 53:20]
    node _io_out_T_15 = eq(opSel, UInt<5>("h17")) @[ALU.scala 54:20]
    node _io_out_T_16 = eq(opSel, UInt<1>("h0")) @[ALU.scala 55:20]
    node _io_out_T_17 = eq(opSel, UInt<3>("h5")) @[ALU.scala 56:20]
    node _io_out_T_18 = eq(opSel, UInt<3>("h7")) @[ALU.scala 57:20]
    node _io_out_T_19 = eq(opSel, UInt<1>("h1")) @[ALU.scala 58:20]
    node bne = _bne_T_1
    node _io_out_T_20 = mux(_io_out_T_19, bne, asSInt(UInt<1>("h0"))) @[Mux.scala 101:16]
    node bgeu = _bgeu_T_3
    node _io_out_T_21 = mux(_io_out_T_18, bgeu, _io_out_T_20) @[Mux.scala 101:16]
    node bge = _bge_T_1
    node _io_out_T_22 = mux(_io_out_T_17, bge, _io_out_T_21) @[Mux.scala 101:16]
    node beq = _beq_T_1
    node _io_out_T_23 = mux(_io_out_T_16, beq, _io_out_T_22) @[Mux.scala 101:16]
    node and = _and_T_1
    node _io_out_T_24 = mux(_io_out_T_15, and, _io_out_T_23) @[Mux.scala 101:16]
    node or = _or_T_1
    node _io_out_T_25 = mux(_io_out_T_14, or, _io_out_T_24) @[Mux.scala 101:16]
    node sra = _sra_T_1
    node _io_out_T_26 = mux(_io_out_T_13, sra, _io_out_T_25) @[Mux.scala 101:16]
    node srl = _srl_T_1
    node _io_out_T_27 = mux(_io_out_T_12, srl, _io_out_T_26) @[Mux.scala 101:16]
    node xor = _xor_T_1
    node _io_out_T_28 = mux(_io_out_T_11, xor, _io_out_T_27) @[Mux.scala 101:16]
    node ltu = _ltu_T_3
    node _io_out_T_29 = mux(_io_out_T_10, ltu, _io_out_T_28) @[Mux.scala 101:16]
    node lt = _lt_T_1
    node _io_out_T_30 = mux(_io_out_T_7, lt, _io_out_T_29) @[Mux.scala 101:16]
    node sll = _sll_T_1
    node _io_out_T_31 = mux(_io_out_T_4, sll, _io_out_T_30) @[Mux.scala 101:16]
    node sub = _sub_T_2
    node _io_out_T_32 = mux(_io_out_T_3, sub, _io_out_T_31) @[Mux.scala 101:16]
    node add = _add_T_2
    node _io_out_T_33 = mux(_io_out_T_2, add, _io_out_T_32) @[Mux.scala 101:16]
    io_out <= asSInt(bits(_io_out_T_33, 31, 0)) @[ALU.scala 42:12]

  module ControlUnit :
    input clock : Clock
    input reset : UInt<1>
    input io_id : UInt<5>
    output io_ld_en : UInt<1>
    output io_str_en : UInt<1>
    output io_op2sel : UInt<1>
    output io_br_en : UInt<1>
    output io_jal : UInt<1>
    output io_jalr : UInt<1>
    output io_lui : UInt<1>
    output io_auipc : UInt<1>

    node _ld_en_T = eq(io_id, UInt<1>("h0")) @[ControlUnit.scala 24:48]
    node _str_en_T = eq(io_id, UInt<4>("h8")) @[ControlUnit.scala 25:49]
    node _op2sel_T = eq(io_id, UInt<1>("h0")) @[ControlUnit.scala 26:49]
    node _op2sel_T_1 = eq(io_id, UInt<3>("h4")) @[ControlUnit.scala 26:66]
    node _op2sel_T_2 = or(_op2sel_T, _op2sel_T_1) @[ControlUnit.scala 26:57]
    node _op2sel_T_3 = eq(io_id, UInt<4>("h8")) @[ControlUnit.scala 26:83]
    node _op2sel_T_4 = or(_op2sel_T_2, _op2sel_T_3) @[ControlUnit.scala 26:74]
    node _br_en_T = eq(io_id, UInt<5>("h18")) @[ControlUnit.scala 27:48]
    node _jal_T = eq(io_id, UInt<5>("h1b")) @[ControlUnit.scala 28:46]
    node _jalr_T = eq(io_id, UInt<5>("h19")) @[ControlUnit.scala 29:47]
    node _auipc_T = eq(io_id, UInt<3>("h5")) @[ControlUnit.scala 30:48]
    node _lui_T = eq(io_id, UInt<4>("hd")) @[ControlUnit.scala 31:46]
    node ld_en = _ld_en_T
    node str_en = _str_en_T
    node op2sel = _op2sel_T_4
    node br_en = _br_en_T
    node jal = _jal_T
    node jalr = _jalr_T
    node auipc = _auipc_T
    node lui = _lui_T
    io_ld_en <= ld_en @[ControlUnit.scala 53:19]
    io_str_en <= str_en @[ControlUnit.scala 53:19]
    io_op2sel <= op2sel @[ControlUnit.scala 53:19]
    io_br_en <= br_en @[ControlUnit.scala 53:19]
    io_jal <= jal @[ControlUnit.scala 53:19]
    io_jalr <= jalr @[ControlUnit.scala 53:19]
    io_lui <= lui @[ControlUnit.scala 53:19]
    io_auipc <= auipc @[ControlUnit.scala 53:19]

  module WriteBack :
    input clock : Clock
    input reset : UInt<1>
    input io_alu_in : SInt<32>
    input io_nPC : UInt<32>
    input io_nPC_en : UInt<1>
    input io_load_in : SInt<32>
    input io_ld_en : UInt<1>
    input io_br_en : UInt<1>
    output io_out : SInt<32>
    output io_br_out : UInt<1>

    node alu_in = io_alu_in
    node _T = bits(alu_in, 0, 0) @[WriteBack.scala 35:19]
    node _T_1 = bits(_T, 0, 0) @[WriteBack.scala 35:23]
    node nPC = io_nPC
    node _T_2 = add(nPC, UInt<3>("h4")) @[WriteBack.scala 48:30]
    node _T_3 = tail(_T_2, 1) @[WriteBack.scala 48:30]
    node _T_4 = asSInt(_T_3) @[WriteBack.scala 48:37]
    node _T_5 = mux(io_ld_en, io_load_in, io_alu_in) @[WriteBack.scala 48:48]
    node nPC_en = io_nPC_en
    node _T_6 = mux(nPC_en, _T_4, _T_5) @[WriteBack.scala 47:16]
    node br_en = io_br_en
    node _GEN_0 = mux(br_en, _T_1, UInt<1>("h0")) @[WriteBack.scala 30:5 39:23 55:23]
    node _GEN_1 = mux(br_en, asSInt(UInt<1>("h0")), _T_6) @[WriteBack.scala 30:5 39:23 55:23]
    io_out <= _GEN_1
    io_br_out <= _GEN_0

  module IF_ID :
    input clock : Clock
    input reset : UInt<1>
    input io_PC_in : UInt<32>
    input io_nPC_in : UInt<32>
    input io_inst_in : UInt<32>
    output io_PC_out : UInt<32>
    output io_nPC_out : UInt<32>
    output io_inst_out : UInt<32>

    reg PC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), PC) @[IF_ID.scala 21:37]
    reg nPC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), nPC) @[IF_ID.scala 22:38]
    reg inst : UInt<32>, clock with :
      reset => (UInt<1>("h0"), inst) @[IF_ID.scala 23:39]
    io_PC_out <= PC @[IF_ID.scala 36:19]
    io_nPC_out <= nPC @[IF_ID.scala 36:19]
    io_inst_out <= inst @[IF_ID.scala 36:19]
    PC <= mux(reset, io_PC_in, PC) @[IF_ID.scala 21:{37,37,37}]
    nPC <= mux(reset, io_nPC_in, nPC) @[IF_ID.scala 22:{38,38,38}]
    inst <= mux(reset, io_inst_in, inst) @[IF_ID.scala 23:{39,39,39}]

  module ID_EX :
    input clock : Clock
    input reset : UInt<1>
    input io_PC_in : UInt<32>
    input io_nPC_in : UInt<32>
    input io_rd_addr_in : UInt<5>
    input io_func3_in : UInt<3>
    input io_rs1_addr_in : UInt<5>
    input io_rs2_addr_in : UInt<5>
    input io_rs1_data_in : SInt<32>
    input io_rs2_data_in : SInt<32>
    input io_func7_in : UInt<7>
    input io_imm_in : SInt<32>
    input io_ld_en_in : UInt<1>
    input io_str_en_in : UInt<1>
    input io_op2sel_in : UInt<1>
    input io_br_en_in : UInt<1>
    input io_jal_in : UInt<1>
    input io_jalr_in : UInt<1>
    input io_lui_in : UInt<1>
    input io_auipc_in : UInt<1>
    input io_id_in : UInt<5>
    output io_PC_out : UInt<32>
    output io_nPC_out : UInt<32>
    output io_rd_addr_out : UInt<5>
    output io_func3_out : UInt<3>
    output io_rs1_addr_out : UInt<5>
    output io_rs2_addr_out : UInt<5>
    output io_rs1_data_out : SInt<32>
    output io_rs2_data_out : SInt<32>
    output io_func7_out : UInt<7>
    output io_imm_out : SInt<32>
    output io_ld_en_out : UInt<1>
    output io_str_en_out : UInt<1>
    output io_op2sel_out : UInt<1>
    output io_br_en_out : UInt<1>
    output io_jal_out : UInt<1>
    output io_jalr_out : UInt<1>
    output io_lui_out : UInt<1>
    output io_auipc_out : UInt<1>
    output io_id_out : UInt<5>

    reg PC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), PC) @[ID_EX.scala 53:37]
    reg nPC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), nPC) @[ID_EX.scala 54:38]
    reg rd_addr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rd_addr) @[ID_EX.scala 55:42]
    reg func3 : UInt<3>, clock with :
      reset => (UInt<1>("h0"), func3) @[ID_EX.scala 56:40]
    reg rs1_addr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs1_addr) @[ID_EX.scala 57:43]
    reg rs2_addr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rs2_addr) @[ID_EX.scala 58:43]
    reg rs1_data : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs1_data) @[ID_EX.scala 59:43]
    reg rs2_data : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs2_data) @[ID_EX.scala 60:43]
    reg func7 : UInt<7>, clock with :
      reset => (UInt<1>("h0"), func7) @[ID_EX.scala 61:40]
    reg imm : SInt<32>, clock with :
      reset => (UInt<1>("h0"), imm) @[ID_EX.scala 62:38]
    reg ld_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ld_en) @[ID_EX.scala 63:40]
    reg str_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), str_en) @[ID_EX.scala 64:41]
    reg op2sel : UInt<1>, clock with :
      reset => (UInt<1>("h0"), op2sel) @[ID_EX.scala 65:41]
    reg br_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), br_en) @[ID_EX.scala 66:40]
    reg jal : UInt<1>, clock with :
      reset => (UInt<1>("h0"), jal) @[ID_EX.scala 67:38]
    reg jalr : UInt<1>, clock with :
      reset => (UInt<1>("h0"), jalr) @[ID_EX.scala 68:39]
    reg lui : UInt<1>, clock with :
      reset => (UInt<1>("h0"), lui) @[ID_EX.scala 69:38]
    reg auipc : UInt<1>, clock with :
      reset => (UInt<1>("h0"), auipc) @[ID_EX.scala 70:40]
    reg id : UInt<5>, clock with :
      reset => (UInt<1>("h0"), id) @[ID_EX.scala 71:37]
    io_PC_out <= PC @[ID_EX.scala 116:19]
    io_nPC_out <= nPC @[ID_EX.scala 116:19]
    io_rd_addr_out <= rd_addr @[ID_EX.scala 116:19]
    io_func3_out <= func3 @[ID_EX.scala 116:19]
    io_rs1_addr_out <= rs1_addr @[ID_EX.scala 116:19]
    io_rs2_addr_out <= rs2_addr @[ID_EX.scala 116:19]
    io_rs1_data_out <= rs1_data @[ID_EX.scala 116:19]
    io_rs2_data_out <= rs2_data @[ID_EX.scala 116:19]
    io_func7_out <= func7 @[ID_EX.scala 116:19]
    io_imm_out <= imm @[ID_EX.scala 116:19]
    io_ld_en_out <= ld_en @[ID_EX.scala 116:19]
    io_str_en_out <= str_en @[ID_EX.scala 116:19]
    io_op2sel_out <= op2sel @[ID_EX.scala 116:19]
    io_br_en_out <= br_en @[ID_EX.scala 116:19]
    io_jal_out <= jal @[ID_EX.scala 116:19]
    io_jalr_out <= jalr @[ID_EX.scala 116:19]
    io_lui_out <= lui @[ID_EX.scala 116:19]
    io_auipc_out <= auipc @[ID_EX.scala 116:19]
    io_id_out <= id @[ID_EX.scala 116:19]
    PC <= mux(reset, io_PC_in, PC) @[ID_EX.scala 53:{37,37,37}]
    nPC <= mux(reset, io_nPC_in, nPC) @[ID_EX.scala 54:{38,38,38}]
    rd_addr <= mux(reset, io_rd_addr_in, rd_addr) @[ID_EX.scala 55:{42,42,42}]
    func3 <= mux(reset, io_func3_in, func3) @[ID_EX.scala 56:{40,40,40}]
    rs1_addr <= mux(reset, io_rs1_addr_in, rs1_addr) @[ID_EX.scala 57:{43,43,43}]
    rs2_addr <= mux(reset, io_rs2_addr_in, rs2_addr) @[ID_EX.scala 58:{43,43,43}]
    rs1_data <= mux(reset, io_rs1_data_in, rs1_data) @[ID_EX.scala 59:{43,43,43}]
    rs2_data <= mux(reset, io_rs2_data_in, rs2_data) @[ID_EX.scala 60:{43,43,43}]
    func7 <= mux(reset, io_func7_in, func7) @[ID_EX.scala 61:{40,40,40}]
    imm <= mux(reset, io_imm_in, imm) @[ID_EX.scala 62:{38,38,38}]
    ld_en <= mux(reset, io_ld_en_in, ld_en) @[ID_EX.scala 63:{40,40,40}]
    str_en <= mux(reset, io_str_en_in, str_en) @[ID_EX.scala 64:{41,41,41}]
    op2sel <= mux(reset, io_op2sel_in, op2sel) @[ID_EX.scala 65:{41,41,41}]
    br_en <= mux(reset, io_br_en_in, br_en) @[ID_EX.scala 66:{40,40,40}]
    jal <= mux(reset, io_jal_in, jal) @[ID_EX.scala 67:{38,38,38}]
    jalr <= mux(reset, io_jalr_in, jalr) @[ID_EX.scala 68:{39,39,39}]
    lui <= mux(reset, io_lui_in, lui) @[ID_EX.scala 69:{38,38,38}]
    auipc <= mux(reset, io_auipc_in, auipc) @[ID_EX.scala 70:{40,40,40}]
    id <= mux(reset, io_id_in, id) @[ID_EX.scala 71:{37,37,37}]

  module EX_MEM :
    input clock : Clock
    input reset : UInt<1>
    input io_ld_en_in : UInt<1>
    input io_str_en_in : UInt<1>
    input io_rd_addr_in : UInt<5>
    input io_rs1_data_in : SInt<32>
    input io_rs2_data_in : SInt<32>
    input io_imm_in : SInt<32>
    input io_alu_in : SInt<32>
    input io_br_en_in : UInt<1>
    input io_jal_in : UInt<1>
    input io_jalr_in : UInt<1>
    input io_lui_in : UInt<1>
    input io_auipc_in : UInt<1>
    input io_PC_in : UInt<32>
    input io_nPC_in : UInt<32>
    output io_ld_en_out : UInt<1>
    output io_str_en_out : UInt<1>
    output io_rd_addr_out : UInt<5>
    output io_rs1_data_out : SInt<32>
    output io_rs2_data_out : SInt<32>
    output io_imm_out : SInt<32>
    output io_alu_out : SInt<32>
    output io_br_en_out : UInt<1>
    output io_jal_out : UInt<1>
    output io_jalr_out : UInt<1>
    output io_lui_out : UInt<1>
    output io_auipc_out : UInt<1>
    output io_PC_out : UInt<32>
    output io_nPC_out : UInt<32>

    reg ld_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ld_en) @[EX_MEM.scala 43:40]
    reg str_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), str_en) @[EX_MEM.scala 44:41]
    reg rd_addr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rd_addr) @[EX_MEM.scala 45:42]
    reg rs1_data : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs1_data) @[EX_MEM.scala 46:43]
    reg rs2_data : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs2_data) @[EX_MEM.scala 47:43]
    reg imm : SInt<32>, clock with :
      reset => (UInt<1>("h0"), imm) @[EX_MEM.scala 48:38]
    reg alu : SInt<32>, clock with :
      reset => (UInt<1>("h0"), alu) @[EX_MEM.scala 49:38]
    reg br_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), br_en) @[EX_MEM.scala 50:40]
    reg jal : UInt<1>, clock with :
      reset => (UInt<1>("h0"), jal) @[EX_MEM.scala 51:38]
    reg jalr : UInt<1>, clock with :
      reset => (UInt<1>("h0"), jalr) @[EX_MEM.scala 52:39]
    reg lui : UInt<1>, clock with :
      reset => (UInt<1>("h0"), lui) @[EX_MEM.scala 53:38]
    reg auipc : UInt<1>, clock with :
      reset => (UInt<1>("h0"), auipc) @[EX_MEM.scala 54:40]
    reg PC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), PC) @[EX_MEM.scala 55:37]
    reg nPC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), nPC) @[EX_MEM.scala 56:38]
    io_ld_en_out <= ld_en @[EX_MEM.scala 91:19]
    io_str_en_out <= str_en @[EX_MEM.scala 91:19]
    io_rd_addr_out <= rd_addr @[EX_MEM.scala 91:19]
    io_rs1_data_out <= rs1_data @[EX_MEM.scala 91:19]
    io_rs2_data_out <= rs2_data @[EX_MEM.scala 91:19]
    io_imm_out <= imm @[EX_MEM.scala 91:19]
    io_alu_out <= alu @[EX_MEM.scala 91:19]
    io_br_en_out <= br_en @[EX_MEM.scala 91:19]
    io_jal_out <= jal @[EX_MEM.scala 91:19]
    io_jalr_out <= jalr @[EX_MEM.scala 91:19]
    io_lui_out <= lui @[EX_MEM.scala 91:19]
    io_auipc_out <= auipc @[EX_MEM.scala 91:19]
    io_PC_out <= PC @[EX_MEM.scala 91:19]
    io_nPC_out <= nPC @[EX_MEM.scala 91:19]
    ld_en <= mux(reset, io_ld_en_in, ld_en) @[EX_MEM.scala 43:{40,40,40}]
    str_en <= mux(reset, io_str_en_in, str_en) @[EX_MEM.scala 44:{41,41,41}]
    rd_addr <= mux(reset, io_rd_addr_in, rd_addr) @[EX_MEM.scala 45:{42,42,42}]
    rs1_data <= mux(reset, io_rs1_data_in, rs1_data) @[EX_MEM.scala 46:{43,43,43}]
    rs2_data <= mux(reset, io_rs2_data_in, rs2_data) @[EX_MEM.scala 47:{43,43,43}]
    imm <= mux(reset, io_imm_in, imm) @[EX_MEM.scala 48:{38,38,38}]
    alu <= mux(reset, io_alu_in, alu) @[EX_MEM.scala 49:{38,38,38}]
    br_en <= mux(reset, io_br_en_in, br_en) @[EX_MEM.scala 50:{40,40,40}]
    jal <= mux(reset, io_jal_in, jal) @[EX_MEM.scala 51:{38,38,38}]
    jalr <= mux(reset, io_jalr_in, jalr) @[EX_MEM.scala 52:{39,39,39}]
    lui <= mux(reset, io_lui_in, lui) @[EX_MEM.scala 53:{38,38,38}]
    auipc <= mux(reset, io_auipc_in, auipc) @[EX_MEM.scala 54:{40,40,40}]
    PC <= mux(reset, io_PC_in, PC) @[EX_MEM.scala 55:{37,37,37}]
    nPC <= mux(reset, io_nPC_in, nPC) @[EX_MEM.scala 56:{38,38,38}]

  module MEM_WB :
    input clock : Clock
    input reset : UInt<1>
    input io_rd_addr_in : UInt<5>
    input io_rs1_data_in : SInt<32>
    input io_imm_in : SInt<32>
    input io_alu_in : SInt<32>
    input io_load_in : SInt<32>
    input io_ld_en_in : UInt<1>
    input io_br_en_in : UInt<1>
    input io_jal_in : UInt<1>
    input io_jalr_in : UInt<1>
    input io_lui_in : UInt<1>
    input io_auipc_in : UInt<1>
    input io_PC_in : UInt<32>
    input io_nPC_in : UInt<32>
    output io_rd_addr_out : UInt<5>
    output io_rs1_data_out : SInt<32>
    output io_imm_out : SInt<32>
    output io_alu_out : SInt<32>
    output io_load_out : SInt<32>
    output io_ld_en_out : UInt<1>
    output io_br_en_out : UInt<1>
    output io_jal_out : UInt<1>
    output io_jalr_out : UInt<1>
    output io_lui_out : UInt<1>
    output io_auipc_out : UInt<1>
    output io_PC_out : UInt<32>
    output io_nPC_out : UInt<32>

    reg rd_addr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rd_addr) @[MEM_WB.scala 41:42]
    reg rs1_data : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs1_data) @[MEM_WB.scala 42:43]
    reg imm : SInt<32>, clock with :
      reset => (UInt<1>("h0"), imm) @[MEM_WB.scala 43:38]
    reg alu : SInt<32>, clock with :
      reset => (UInt<1>("h0"), alu) @[MEM_WB.scala 44:38]
    reg load : SInt<32>, clock with :
      reset => (UInt<1>("h0"), load) @[MEM_WB.scala 45:39]
    reg load_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), load_en) @[MEM_WB.scala 46:42]
    reg br_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), br_en) @[MEM_WB.scala 47:40]
    reg jal : UInt<1>, clock with :
      reset => (UInt<1>("h0"), jal) @[MEM_WB.scala 48:38]
    reg jalr : UInt<1>, clock with :
      reset => (UInt<1>("h0"), jalr) @[MEM_WB.scala 49:39]
    reg lui : UInt<1>, clock with :
      reset => (UInt<1>("h0"), lui) @[MEM_WB.scala 50:38]
    reg auipc : UInt<1>, clock with :
      reset => (UInt<1>("h0"), auipc) @[MEM_WB.scala 51:40]
    reg PC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), PC) @[MEM_WB.scala 52:37]
    reg nPC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), nPC) @[MEM_WB.scala 53:38]
    io_rd_addr_out <= rd_addr @[MEM_WB.scala 86:19]
    io_rs1_data_out <= rs1_data @[MEM_WB.scala 86:19]
    io_imm_out <= imm @[MEM_WB.scala 86:19]
    io_alu_out <= alu @[MEM_WB.scala 86:19]
    io_load_out <= load @[MEM_WB.scala 86:19]
    io_ld_en_out <= load_en @[MEM_WB.scala 86:19]
    io_br_en_out <= br_en @[MEM_WB.scala 86:19]
    io_jal_out <= jal @[MEM_WB.scala 86:19]
    io_jalr_out <= jalr @[MEM_WB.scala 86:19]
    io_lui_out <= lui @[MEM_WB.scala 86:19]
    io_auipc_out <= auipc @[MEM_WB.scala 86:19]
    io_PC_out <= PC @[MEM_WB.scala 86:19]
    io_nPC_out <= nPC @[MEM_WB.scala 86:19]
    rd_addr <= mux(reset, io_rd_addr_in, rd_addr) @[MEM_WB.scala 41:{42,42,42}]
    rs1_data <= mux(reset, io_rs1_data_in, rs1_data) @[MEM_WB.scala 42:{43,43,43}]
    imm <= mux(reset, io_imm_in, imm) @[MEM_WB.scala 43:{38,38,38}]
    alu <= mux(reset, io_alu_in, alu) @[MEM_WB.scala 44:{38,38,38}]
    load <= mux(reset, io_load_in, load) @[MEM_WB.scala 45:{39,39,39}]
    load_en <= mux(reset, io_ld_en_in, load_en) @[MEM_WB.scala 46:{42,42,42}]
    br_en <= mux(reset, io_br_en_in, br_en) @[MEM_WB.scala 47:{40,40,40}]
    jal <= mux(reset, io_jal_in, jal) @[MEM_WB.scala 48:{38,38,38}]
    jalr <= mux(reset, io_jalr_in, jalr) @[MEM_WB.scala 49:{39,39,39}]
    lui <= mux(reset, io_lui_in, lui) @[MEM_WB.scala 50:{38,38,38}]
    auipc <= mux(reset, io_auipc_in, auipc) @[MEM_WB.scala 51:{40,40,40}]
    PC <= mux(reset, io_PC_in, PC) @[MEM_WB.scala 52:{37,37,37}]
    nPC <= mux(reset, io_nPC_in, nPC) @[MEM_WB.scala 53:{38,38,38}]

  module FiveStageCore :
    input clock : Clock
    input reset : UInt<1>

    inst Fetch of Fetch @[FiveStageCore.scala 17:30]
    inst Decoder of Decoder @[FiveStageCore.scala 18:34]
    inst RegFile of RegFile @[FiveStageCore.scala 19:34]
    inst ALU of ALU @[FiveStageCore.scala 20:26]
    inst ControlUnit of ControlUnit @[FiveStageCore.scala 21:42]
    inst WriteBack of WriteBack @[FiveStageCore.scala 22:38]
    inst IF_ID of IF_ID @[FiveStageCore.scala 23:30]
    inst ID_EX of ID_EX @[FiveStageCore.scala 24:30]
    inst EX_MEM of EX_MEM @[FiveStageCore.scala 25:32]
    inst MEM_WB of MEM_WB @[FiveStageCore.scala 26:32]
    mem inst_memory : @[FiveStageCore.scala 27:37]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => MPORT_1
      read-under-write => undefined
    mem ld_str_memory : @[FiveStageCore.scala 28:39]
      data-type => SInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => MPORT_2
      writer => MPORT
      read-under-write => undefined
    node _nPC_T = add(MEM_WB.io_rs1_data_out, MEM_WB.io_imm_out) @[FiveStageCore.scala 31:33]
    node _nPC_T_1 = tail(_nPC_T, 1) @[FiveStageCore.scala 31:33]
    node _nPC_T_2 = asSInt(_nPC_T_1) @[FiveStageCore.scala 31:33]
    node _nPC_T_3 = asUInt(_nPC_T_2) @[FiveStageCore.scala 31:54]
    node _nPC_T_4 = bits(MEM_WB.io_imm_out, 31, 1) @[FiveStageCore.scala 32:49]
    node _nPC_T_5 = cat(_nPC_T_4, UInt<1>("h0")) @[Cat.scala 31:58]
    node _nPC_T_6 = add(MEM_WB.io_PC_out, _nPC_T_5) @[FiveStageCore.scala 32:26]
    node _nPC_T_7 = tail(_nPC_T_6, 1) @[FiveStageCore.scala 32:26]
    node _nPC_T_8 = mux(MEM_WB.io_jalr_out, _nPC_T_3, _nPC_T_7) @[FiveStageCore.scala 29:33]
    node _lui_T = shl(MEM_WB.io_imm_out, 12) @[FiveStageCore.scala 34:42]
    node _auipc_T = asUInt(MEM_WB.io_imm_out) @[FiveStageCore.scala 35:70]
    node _auipc_T_1 = shl(_auipc_T, 12) @[FiveStageCore.scala 35:77]
    node _auipc_T_2 = add(MEM_WB.io_PC_out, _auipc_T_1) @[FiveStageCore.scala 35:49]
    node _auipc_T_3 = tail(_auipc_T_2, 1) @[FiveStageCore.scala 35:49]
    node _T = bits(EX_MEM.io_alu_out, 23, 0) @[FiveStageCore.scala 47:46]
    node _T_1 = bits(_T, 9, 0)
    node _GEN_0 = validif(EX_MEM.io_str_en_out, _T_1) @[FiveStageCore.scala 46:5]
    node _GEN_1 = validif(EX_MEM.io_str_en_out, clock) @[FiveStageCore.scala 46:5]
    node _GEN_2 = mux(EX_MEM.io_str_en_out, UInt<1>("h1"), UInt<1>("h0")) @[FiveStageCore.scala 28:39 46:5]
    node _GEN_3 = validif(EX_MEM.io_str_en_out, UInt<1>("h1")) @[FiveStageCore.scala 46:5]
    node _GEN_4 = validif(EX_MEM.io_str_en_out, EX_MEM.io_rs2_data_out) @[FiveStageCore.scala 46:5]
    node _T_2 = bits(Fetch.io_inst_out, 9, 0) @[FiveStageCore.scala 144:25]
    node _T_3 = or(MEM_WB.io_jal_out, MEM_WB.io_jalr_out) @[FiveStageCore.scala 175:31]
    node _T_4 = asSInt(MEM_WB.io_nPC_out) @[FiveStageCore.scala 175:72]
    node auipc = _auipc_T_3
    node _T_5 = asSInt(auipc) @[FiveStageCore.scala 177:48]
    node _T_6 = mux(MEM_WB.io_auipc_out, _T_5, WriteBack.io_out) @[FiveStageCore.scala 176:51]
    node lui = _lui_T
    node _T_7 = mux(MEM_WB.io_lui_out, lui, _T_6) @[FiveStageCore.scala 175:83]
    node _T_8 = mux(_T_3, _T_4, _T_7) @[FiveStageCore.scala 174:12]
    node _T_9 = asUInt(EX_MEM.io_alu_out) @[FiveStageCore.scala 213:46]
    node _T_10 = bits(_T_9, 9, 0) @[FiveStageCore.scala 213:27]
    node _T_11 = or(MEM_WB.io_jal_out, MEM_WB.io_jalr_out) @[FiveStageCore.scala 231:27]
    node _T_12 = or(MEM_WB.io_jal_out, MEM_WB.io_jalr_out) @[FiveStageCore.scala 235:27]
    node _T_13 = or(_T_12, MEM_WB.io_br_en_out) @[FiveStageCore.scala 235:49]
    node nPC = _nPC_T_8
    Fetch.clock <= clock
    Fetch.reset <= reset
    Fetch.io_nPC_in <= nPC @[FiveStageCore.scala 238:23]
    Fetch.io_nPC_en <= _T_13 @[FiveStageCore.scala 238:23]
    Decoder.clock <= clock
    Decoder.reset <= reset
    Decoder.io_in <= IF_ID.io_inst_out @[FiveStageCore.scala 238:23]
    RegFile.clock <= clock
    RegFile.reset <= reset
    RegFile.io_rd_addr <= MEM_WB.io_rd_addr_out @[FiveStageCore.scala 238:23]
    RegFile.io_rs1_addr <= Decoder.io_rs1 @[FiveStageCore.scala 238:23]
    RegFile.io_rs2_addr <= Decoder.io_rs2 @[FiveStageCore.scala 238:23]
    RegFile.io_rd_data <= asSInt(bits(_T_8, 31, 0)) @[FiveStageCore.scala 238:23]
    ALU.clock <= clock
    ALU.reset <= reset
    ALU.io_rs1 <= ID_EX.io_rs1_data_out @[FiveStageCore.scala 238:23]
    ALU.io_rs2 <= ID_EX.io_rs2_data_out @[FiveStageCore.scala 238:23]
    ALU.io_imm <= ID_EX.io_imm_out @[FiveStageCore.scala 238:23]
    ALU.io_func3 <= ID_EX.io_func3_out @[FiveStageCore.scala 238:23]
    ALU.io_func7 <= ID_EX.io_func7_out @[FiveStageCore.scala 238:23]
    ALU.io_id <= ID_EX.io_id_out @[FiveStageCore.scala 238:23]
    ALU.io_op2sel <= ID_EX.io_op2sel_out @[FiveStageCore.scala 238:23]
    ControlUnit.clock <= clock
    ControlUnit.reset <= reset
    ControlUnit.io_id <= Decoder.io_id @[FiveStageCore.scala 238:23]
    WriteBack.clock <= clock
    WriteBack.reset <= reset
    WriteBack.io_alu_in <= MEM_WB.io_alu_out @[FiveStageCore.scala 238:23]
    WriteBack.io_nPC <= MEM_WB.io_PC_out @[FiveStageCore.scala 238:23]
    WriteBack.io_nPC_en <= _T_11 @[FiveStageCore.scala 238:23]
    WriteBack.io_load_in <= MEM_WB.io_load_out @[FiveStageCore.scala 238:23]
    WriteBack.io_ld_en <= MEM_WB.io_ld_en_out @[FiveStageCore.scala 238:23]
    WriteBack.io_br_en <= MEM_WB.io_br_en_out @[FiveStageCore.scala 238:23]
    IF_ID.clock <= clock
    IF_ID.reset <= reset
    IF_ID.io_PC_in <= Fetch.io_PC_out @[FiveStageCore.scala 238:23]
    IF_ID.io_nPC_in <= Fetch.io_nPC_out @[FiveStageCore.scala 238:23]
    IF_ID.io_inst_in <= inst_memory.MPORT_1.data @[FiveStageCore.scala 238:23]
    ID_EX.clock <= clock
    ID_EX.reset <= reset
    ID_EX.io_PC_in <= IF_ID.io_PC_out @[FiveStageCore.scala 238:23]
    ID_EX.io_nPC_in <= IF_ID.io_nPC_out @[FiveStageCore.scala 238:23]
    ID_EX.io_rd_addr_in <= Decoder.io_rd @[FiveStageCore.scala 238:23]
    ID_EX.io_func3_in <= Decoder.io_func3 @[FiveStageCore.scala 238:23]
    ID_EX.io_rs1_addr_in <= Decoder.io_rs1 @[FiveStageCore.scala 238:23]
    ID_EX.io_rs2_addr_in <= Decoder.io_rs2 @[FiveStageCore.scala 238:23]
    ID_EX.io_rs1_data_in <= RegFile.io_rs1_data @[FiveStageCore.scala 238:23]
    ID_EX.io_rs2_data_in <= RegFile.io_rs2_data @[FiveStageCore.scala 238:23]
    ID_EX.io_func7_in <= Decoder.io_func7 @[FiveStageCore.scala 238:23]
    ID_EX.io_imm_in <= Decoder.io_imm @[FiveStageCore.scala 238:23]
    ID_EX.io_ld_en_in <= ControlUnit.io_ld_en @[FiveStageCore.scala 238:23]
    ID_EX.io_str_en_in <= ControlUnit.io_str_en @[FiveStageCore.scala 238:23]
    ID_EX.io_op2sel_in <= ControlUnit.io_op2sel @[FiveStageCore.scala 238:23]
    ID_EX.io_br_en_in <= ControlUnit.io_br_en @[FiveStageCore.scala 238:23]
    ID_EX.io_jal_in <= ControlUnit.io_jal @[FiveStageCore.scala 238:23]
    ID_EX.io_jalr_in <= ControlUnit.io_jalr @[FiveStageCore.scala 238:23]
    ID_EX.io_lui_in <= ControlUnit.io_lui @[FiveStageCore.scala 238:23]
    ID_EX.io_auipc_in <= ControlUnit.io_auipc @[FiveStageCore.scala 238:23]
    ID_EX.io_id_in <= Decoder.io_id @[FiveStageCore.scala 238:23]
    EX_MEM.clock <= clock
    EX_MEM.reset <= reset
    EX_MEM.io_ld_en_in <= ID_EX.io_ld_en_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_str_en_in <= ID_EX.io_str_en_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_rd_addr_in <= ID_EX.io_rd_addr_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_rs1_data_in <= ID_EX.io_rs1_data_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_rs2_data_in <= ID_EX.io_rs2_data_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_imm_in <= ID_EX.io_imm_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_alu_in <= ALU.io_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_br_en_in <= ID_EX.io_br_en_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_jal_in <= ID_EX.io_jal_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_jalr_in <= ID_EX.io_jalr_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_lui_in <= ID_EX.io_lui_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_auipc_in <= ID_EX.io_auipc_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_PC_in <= ID_EX.io_PC_out @[FiveStageCore.scala 238:23]
    EX_MEM.io_nPC_in <= ID_EX.io_nPC_out @[FiveStageCore.scala 238:23]
    MEM_WB.clock <= clock
    MEM_WB.reset <= reset
    MEM_WB.io_rd_addr_in <= EX_MEM.io_rd_addr_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_rs1_data_in <= EX_MEM.io_rs1_data_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_imm_in <= EX_MEM.io_imm_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_alu_in <= EX_MEM.io_alu_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_load_in <= ld_str_memory.MPORT_2.data @[FiveStageCore.scala 238:23]
    MEM_WB.io_ld_en_in <= EX_MEM.io_ld_en_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_br_en_in <= EX_MEM.io_br_en_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_jal_in <= EX_MEM.io_jal_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_jalr_in <= EX_MEM.io_jalr_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_lui_in <= EX_MEM.io_lui_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_auipc_in <= EX_MEM.io_auipc_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_PC_in <= EX_MEM.io_PC_out @[FiveStageCore.scala 238:23]
    MEM_WB.io_nPC_in <= EX_MEM.io_nPC_out @[FiveStageCore.scala 238:23]
    inst_memory.MPORT_1.addr <= _T_2 @[FiveStageCore.scala 144:25]
    inst_memory.MPORT_1.en <= UInt<1>("h1") @[FiveStageCore.scala 144:25]
    inst_memory.MPORT_1.clk <= clock @[FiveStageCore.scala 144:25]
    ld_str_memory.MPORT_2.addr <= _T_10 @[FiveStageCore.scala 213:27]
    ld_str_memory.MPORT_2.en <= UInt<1>("h1") @[FiveStageCore.scala 213:27]
    ld_str_memory.MPORT_2.clk <= clock @[FiveStageCore.scala 213:27]
    ld_str_memory.MPORT.addr <= _GEN_0
    ld_str_memory.MPORT.en <= _GEN_2
    ld_str_memory.MPORT.clk <= _GEN_1
    ld_str_memory.MPORT.data <= _GEN_4
    ld_str_memory.MPORT.mask <= _GEN_3
