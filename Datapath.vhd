library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
library work;
use work.Microprocessor_project.all;

entity Datapath is
    port(
        R0,R1,R2,R3,R4,R5,R6,R7: out std_logic_vector(15 downto 0);
        clk,rst: in std_logic);
end entity;

architecture Mixed of Datapath is
    
    --PC
    signal pc_in,pc1_out,pc_alu_in,pc_alu_out,pc2_in,pc2_out: std_logic_vector(15 downto 0);
 
    --Instruction Memory
    signal Instr_Mem_A,Instr_Mem_B,Instr1_Mem_out,Instr2_Mem_out: std_logic_vector(15 downto 0);

    --register Pipeline1
    signal p11_instr_out,p11_instr_in,p11_pc_out,p11_pc_in,p12_instr_out,p12_instr_in,p12_pc_out,p12_pc_in: std_logic_vector(15 downto 0);
    signal p11_enable,p11_stall_out,p12_enable,p12_stall_out: std_logic;

    --Instruction Decoder
    signal id1_in,id2_in: std_logic_vector(15 downto 0);
    signal id1_mdr,id1_rs1,id1_rs2,id1_rd,id2_mdr,id2_rs1,id2_rs2,id2_rd: std_logic_vector (2 downto 0);
    signal id1_branch,id1_dec_brloc,id1_rr_brloc,id1_mr,id1_mw,id1_rfw: std_logic;
    signal id2_branch,id2_dec_brloc,id2_rr_brloc,id2_mr,id2_mw,id2_rfw: std_logic;
    signal id1_br_st,id2_br_st: std_logic_vector (1 downto 0);
    signal stall : std_logic;
  
    --Pipeline Register P2
    signal p21_in, p22_in, p21_out, p22_out : std_logic_vector(50 downto 0);
    signal valid1, valid2 : std_logic;		-- done1, done2 

    --Register File
    signal a1, a2, a3, a4, a5, a6, a7 : std_logic_vector(2 downto 0);
    signal d5, d6, d7, pci : std_logic_vector(15 downto 0);
    signal d1, d2, d3, d4 : std_logic_vector(15 downto 0);
    signal regWr1, regWr2, regWr3, pcWr : std_logic;

    --Pipeline Register P3
    signal p31_in, p32_in, p31_out, p32_out : std_logic_vector(82 downto 0);

    --ALU
    signal alux1, aluy1, alu_out1, alux2, aluy2, alu_out2 : std_logic_vector(15 downto 0);
    signal aluop1, aluc1, aluz1, aluop2, aluc2, aluz2 : std_logic;
    signal alux3, aluy3, alu_out3, alux4, aluy4, alu_out4 : std_logic_vector(15 downto 0);
    signal aluop3, aluc3, aluz3, aluop4, aluc4, aluz4 : std_logic;

    --Pipeline Register P4
    signal p41_in, p42_in, p41_out, p42_out : std_logic_vector(100 downto 0);

    --Pipeline Register P5
    signal p51_in, p52_in, p51_out, p52_out : std_logic_vector(100 downto 0);    

    constant one: std_logic_vector(15 downto 0) := "0000000000000001";
    constant zero: std_logic_vector(15 downto 0) := "0000000000000000";
    constant two: std_logic_vector(15 downto 0) := "0000000000000010";

begin

    --------------------------------
    --Fetch Stage
    --------------------------------
    --PC
    pc_in <= pc_alu_out;    
    pc: dataRegister generic map (data_width => 16)
        port map (Din => pc_in, Dout => pc1_out, enable => stall, clk => clk);

    --PC Incrementer1
    pc2_in <= pc1_out;
    incrementer1: ALU
    	port map (IP1=>pc2_in,IP2=>one,OP=>pc2_out,aluOP=>'0');

    --PC Incrementer2
    pc_alu_in <= pc1_out;
    incrementer2: ALU
    	port map (IP1=>pc_alu_in,IP2=>two,OP=>pc_alu_out,aluOP=>'0');

    --Instruction Memory
    Instr_Mem_A <= pc1_out;
    Instr_Mem_B <= pc2_out;
    instr_mem: instrMemory
    	port map(Instr_Mem_A,Instr_Mem_B,Instr1_Mem_out,Instr2_Mem_out,'0',clk);

    --Pipeline Register P1
    p11_instr_in <= Instr1_Mem_out;
    p11_enable <= stall;    
    p11_instr: dataRegister generic map (data_width => 16)
        port map (Din => p11_instr_in, Dout => p11_instr_out, enable => p11_enable, clk => clk);
    p11_pc_in <= pc1_out;    
    p11_pc: dataRegister generic map (data_width => 16)
        port map (Din => p11_pc_in, Dout => p11_pc_out, enable => p11_enable, clk => clk);
    
    p12_enable <= stall;
    p12_instr_in <= Instr2_Mem_out;    
    p12_instr: dataRegister generic map (data_width => 16)
        port map (Din => p12_instr_in, Dout => p12_instr_out, enable => p12_enable, clk => clk);
    p12_pc_in <= pc2_out;    
    p12_pc: dataRegister generic map (data_width => 16)
        port map (Din => p12_pc_in, Dout => p12_pc_out, enable => p12_enable, clk => clk);

    --------------------------------
    --Decode Stage
    --------------------------------
    --Instruction Decoder
    id1_in <= p11_instr_out;
    id2_in <= p12_instr_out;
    id1: InstructionDecoder
        port map(id1_in, id2_in, id1_mdr, id1_rs1, id1_rs2, id1_rd, id1_branch, id1_dec_brloc, id1_rr_brloc,
                id1_br_st, id1_mr, id1_mw, id1_rfw, id2_mdr, id2_rs1, id2_rs2, id2_rd, id2_branch, id2_dec_brloc,
		id2_rr_brloc, id2_br_st, id2_mr, id2_mw, id2_rfw, stall);    

    --Pipeline Register P2
    p21_in(15 downto 0) <= p11_instr_out;
    p21_in(31 downto 16) <= p11_pc_out;
    p21_in(34 downto 32) <= id1_rs1;
    p21_in(37 downto 35) <= id1_rs2;
    p21_in(40 downto 38) <= id1_rd;
    p21_in(41) <= id1_branch;
    p21_in(42) <= id1_dec_brloc;
    p21_in(43) <= id1_rr_brloc;
    p21_in(45 downto 44) <= id1_br_st;
    p21_in(46) <= id1_mr;
    p21_in(47) <= id1_mw;
    p21_in(48) <= id1_rfw;
    p21_in(49) <= valid1;
    p21_in(50) <= '0';
    p21: dataRegister generic map (data_width => 51)
	port map (Din => p21_in, Dout => p21_out, enable => '1', clk => clk);

    p22_in(15 downto 0) <= p12_instr_out;
    p22_in(31 downto 16) <= p12_pc_out;
    p22_in(34 downto 32) <= id2_rs1;
    p22_in(37 downto 35) <= id2_rs2;
    p22_in(40 downto 38) <= id2_rd;
    p22_in(41) <= id2_branch;
    p22_in(42) <= id2_dec_brloc;
    p22_in(43) <= id2_rr_brloc;
    p22_in(45 downto 44) <= id2_br_st;
    p22_in(46) <= id2_mr;
    p22_in(47) <= id2_mw;
    p22_in(48) <= id2_rfw;
    p22_in(49) <= valid2;
    p22_in(50) <= '0';
    p22: dataRegister generic map (data_width => 51)
	port map (Din => p22_in, Dout => p22_out, enable => '1', clk => clk);
    
    --------------------------------
    --Register Read Stage
    --------------------------------    
    --Register File                          (Inputs later)
    a1 <= p21_out(34 downto 32);
    a2 <= p21_out(37 downto 35);
    a3 <= p22_out(34 downto 32);
    a4 <= p22_out(37 downto 35);
    a5 <= p51_out(40 downto 38);
    a6 <= p52_out(40 downto 38);
    d5 <= p51_out(98 downto 83);
    d6 <= p52_out(98 downto 83);
    --a7
    --d7
    --pci
    --regWr1 <= rob_instr1(48);
    --regWr2 <= rob_instr2(48);
    --regWr3
    RF: regfile
	port map(a1,a2,a3,a4,a5,a6,a7,d5,d6,d7,pci,d1,d2,d3,d4,regWr1,regWr2,regWr3,pcWr,clk,rst);

    --Pipeline Register P3 
    p31_in(50 downto 0) <= p21_out;
    p31_in(66 downto 51) <= d1;
    p31_in(82 downto 67) <= d2;
    p31: dataRegister generic map (data_width => 83)
	port map (Din => p31_in, Dout => p31_out, enable => '1', clk => clk);

    p32_in(50 downto 0) <= p22_out;
    p32_in(66 downto 51) <= d3;
    p32_in(82 downto 67) <= d4;
    p32: dataRegister generic map (data_width => 83)
	port map (Din => p32_in, Dout => p32_out, enable => '1', clk => clk);

    --------------------------------
    --Execute1 Stage
    -------------------------------- 
    --ALU1
    alux1 <= p31_out(66 downto 51);
    aluy1 <= p31_out(82 downto 67);
    aluop1 <= p31_out(13);
    exec1_alu: ALU port map(alux1, aluy1, alu_out1, aluop1, aluc1, aluz1);

    --exexse2: SixBitSignExtender port map(p3_instr_out(5 downto 0), alu_ext);

    --ALU2
    alux2 <= p32_out(66 downto 51);
    aluy2 <= p32_out(82 downto 67);
    aluop2 <= p32_out(13);
    exec2_alu: ALU port map(alux2, aluy2, alu_out2, aluop2, aluc2, aluz2);

    --exexse2: SixBitSignExtender port map(p3_instr_out(5 downto 0), alu_ext);

    --Pipeline Register P4
    p41_in(82 downto 0) <= p31_out;
    p41_in(98 downto 83) <= alu_out1;
    p41_in(99) <= aluc1;
    p41_in(100) <= aluz1;
    p41: dataRegister generic map (data_width => 101)
	port map (Din => p41_in, Dout => p41_out, enable => '1', clk => clk);

    p42_in(82 downto 0) <= p32_out;
    p42_in(98 downto 83) <= alu_out2;
    p42_in(99) <= aluc2;
    p42_in(100) <= aluz2;
    p42: dataRegister generic map (data_width => 101)
	port map (Din => p42_in, Dout => p42_out, enable => '1', clk => clk);

    --------------------------------
    --Execute2 Stage
    -------------------------------- 
    --ALU1
    alux3 <= p41_out(66 downto 51);
    aluy3 <= p41_out(82 downto 67);
    aluop3 <= p41_out(13);
    exec3_alu: ALU port map(alux3, aluy3, alu_out3, aluop3, aluc3, aluz3);

    --exexse2: SixBitSignExtender port map(p3_instr_out(5 downto 0), alu_ext);

    --ALU2
    alux4 <= p42_out(66 downto 51);
    aluy4 <= p42_out(82 downto 67);
    aluop4 <= p42_out(13);
    exec4_alu: ALU port map(alux4, aluy4, alu_out4, aluop4, aluc4, aluz4);

    --exexse2: SixBitSignExtender port map(p3_instr_out(5 downto 0), alu_ext);

    --Pipeline Register P5
    p51_in(82 downto 0) <= p41_out(82 downto 0);
    p51_in(98 downto 83) <= alu_out3;
    p51_in(99) <= aluc3;
    p51_in(100) <= aluz3;
    p51: dataRegister generic map (data_width => 101)
	port map (Din => p51_in, Dout => p51_out, enable => '1', clk => clk);

    p52_in(82 downto 0) <= p42_out(82 downto 0);
    p52_in(98 downto 83) <= alu_out4;
    p52_in(99) <= aluc4;
    p52_in(100) <= aluz4;
    p52: dataRegister generic map (data_width => 101)
	port map (Din => p52_in, Dout => p52_out, enable => '1', clk => clk);

    --------------------------------
    --Register Write Stage
    --------------------------------      

end Mixed;
