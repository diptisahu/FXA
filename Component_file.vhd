library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

package Microprocessor_project is
    type arr1 is array(natural range <>) of std_logic_vector(15 downto 0);

    --ALU for add, nand
    component ALU is
        port(
            IP1, IP2 : in std_logic_vector(15 downto 0);
            OP : out std_logic_vector(15 downto 0);
            aluOP : in std_logic;
	    C,Z : out std_logic);
    end component;
    
    --Memory for data
    component dataMemory is
        port(
            A,B,Din1,Din2 : in std_logic_vector(15 downto 0);
            Dout1,Dout2 : out std_logic_vector(15 downto 0);
            memWR1,memWR2 : in std_logic;
            clk : in std_logic);
    end component;

    --Memory for instruction
    component instrMemory is
        port(
            A,B : in std_logic_vector(15 downto 0);
	    Dout1,Dout2 : out std_logic_vector(15 downto 0);
	    memWR : in std_logic;
	    clk : in std_logic);
    end component;
    
    --Generic register
    component dataRegister is
        generic (data_width:integer);
        port(
            Din : in std_logic_vector(data_width-1 downto 0);
            Dout : out std_logic_vector(data_width-1 downto 0);
            clk, enable : in std_logic);
    end component;

    --Register File
    component regFile is
        port(
	a1, a2, a3, a4, a5, a6, a7 : in std_logic_vector(2 downto 0);
        d5, d6, d7, pci : in std_logic_vector(15 downto 0);
        d1, d2, d3, d4 : out std_logic_vector(15 downto 0);
        regWr1, regWr2, regWr3, pcWr : in std_logic;
        clk, reset : in std_logic);
    end component;

    component regRenameFile is
    port(
        a1, a2, a3, a4, a5, a6, a7 : in std_logic_vector(2 downto 0);
        d5, d6, d7 : in std_logic_vector(15 downto 0);
        d1, d2, d3, d4 : out std_logic_vector(15 downto 0);
        regWr1, regWr2, regWr3 : in std_logic;
        bit1, bit2, bit3, bit4 : out std_logic;
        clk, reset : in std_logic);
    end component;

    --Comparator
    component Comparator is
        port(
		    Comp_D1,Comp_D2: in std_logic_vector(15 downto 0);
			Comp_out: out std_logic);
    end component;

    --Nine Bit Sign Extender
    component NineBitSignExtender is
        port(x: in std_logic_vector (8 downto 0);
             y: out std_logic_vector (15 downto 0));
    end component;

    --Six Bit Sign Extender
    component SixBitSignExtender is
        port(x: in std_logic_vector (5 downto 0);
             y: out std_logic_vector (15 downto 0));
    end component;

    --Pad Nine Bit
    component PadNine is
    	port(x: in std_logic_vector (8 downto 0);
             y: out std_logic_vector (15 downto 0));
    end component;

    --Instruction Decoder
    component InstructionDecoder is
	port(	
	instr1, instr2: in std_logic_vector(15 downto 0);
	m_dec_reg1: in std_logic_vector(2 downto 0);
	rs11,rs12,rd1: out std_logic_vector(2 downto 0);
	branch1, decode_br_loc1, regread_br_loc1: out std_logic;
	branch1_state: out std_logic_vector (1 downto 0);
	mem_read1, mem_write1, rf_write1: out std_logic;
	m_dec_reg2: in std_logic_vector(2 downto 0);
	rs21,rs22,rd2: out std_logic_vector(2 downto 0);
	branch2, decode_br_loc2, regread_br_loc2: out std_logic;
	branch2_state: out std_logic_vector (1 downto 0);
	mem_read2, mem_write2, rf_write2: out std_logic;
	stall: out std_logic);
    end component;

    --Instruction Queue
    component InstructionQueue is
	port(
	instr1_in, instr2_in : in std_logic_vector(100 downto 0);
	instr1_out, instr2_out : out std_logic_vector(100 downto 0);
	clk, reset : in std_logic);
    end component;

    --ROB
    component ROB is
	port(
	rob_in1, rob_in2 : in std_logic_vector(100 downto 0);
	data1, data2, data3, pci : out std_logic_vector(15 downto 0);
	add1, add2, add3 : out std_logic_vector(2 downto 0);
	regWr1, regWr2, regWr3 : out std_logic;
	clk, reset : in std_logic);
    end component;

    --Look Table
    component LookTable is
    	port(
    	    pc_in1, pc_in2 : in std_logic_vector(15 downto 0);
	    pc_out1, pc_out2, pc_out3, pc_out4 : out std_logic_vector(15 downto 0);
	    retire1, retire2, retire3, retire4 : in std_logic;
	    clk, reset : in std_logic);
    end component;

end package;
