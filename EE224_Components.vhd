library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

package EE224_Components is
    type arr1 is array(natural range <>) of std_logic_vector(15 downto 0);
    
	component INVERTER is
		port (a: in std_logic; b : out std_logic);
   	end component;

  	component ANDTwo is
		port (a, b: in std_logic; c : out std_logic);
   	end component;

	component ORTwo is
		port (a, b: in std_logic; c : out std_logic);
   	end component;

	component XORTwo is 
		port (a,b: in std_logic; c: out std_logic);
	end component;

    component NANDTwo is
        port (a, b: in std_logic; c: out std_logic);
    end component;

	component FullAdder is
		port (x, y, ci: in std_logic; s, co: out std_logic);
	end component;

    component TwosComplementSixteen is
        port (x: in std_logic_vector (15 downto 0);
            t: out std_logic_vector (15 downto 0));
    end component;

	component Multiplexer is
		port(a, b, s: in std_logic; c: out std_logic);
	end component;

	component FourOneMux is
		port (a, b, c, d: in std_logic; s: in std_logic_vector (1 downto 0);
			o: out std_logic);
	end component;

    component SixteenBitAdder is
        port(x,y: in std_logic_vector (15 downto 0);
            s: out std_logic_vector(15 downto 0);
            c_out: out std_logic);
    end component;

    component SixteenBitSubtractor is
        port(x,y: in std_logic_vector (15 downto 0);
            s: out std_logic_vector(15 downto 0);
            b: out std_logic);
    end component;

    component SixteenBitNand is
        port(x,y: in std_logic_vector (15 downto 0);
            s: out std_logic_vector(15 downto 0));
    end component;

    component PriorityEncoder is
        port(x: in std_logic_vector (7 downto 0);
            s: out std_logic_vector(2 downto 0);
            N: out std_logic;
            tnew: out std_logic_vector (7 downto 0));
    end component;

    component PriorityDecoder is
        port(x: in std_logic_vector (7 downto 0);
            s: in std_logic_vector(2 downto 0);
            y: out std_logic_vector(7 downto 0));
    end component;

    component SixBitSignExtender is
        port(x: in std_logic_vector (5 downto 0);
            y: out std_logic_vector (15 downto 0));
    end component;

    component NineBitSignExtender is
        port(x: in std_logic_vector (8 downto 0);
            y: out std_logic_vector (15 downto 0));
    end component;

    component DataRegister is
        generic (data_width:integer);
        port (Din: in std_logic_vector(data_width-1 downto 0);
            Dout: out std_logic_vector(data_width-1 downto 0);
            clk, enable: in std_logic);
    end component DataRegister;

    component out_Mux is
        port(r0, r1, r2, r3, r4, r5, r6, r7: in std_logic_vector(15 downto 0);
            a: in std_logic_vector(2 downto 0);
            o: out std_logic_vector(15 downto 0));
    end component;

    component MuxTwo is
        port(i0, i1: in std_logic_vector (15 downto 0);
            s: in std_logic;
            o: out std_logic_vector(15 downto 0));
    end component;

    component MuxFour is
        port (i00, i01, i10, i11: in std_logic_vector(15 downto 0);
            s: in std_logic_vector (1 downto 0);
            o: out std_logic_vector (15 downto 0));
    end component;

    component MuxEight is
        port (i000, i001, i010, i011, i100, i101, i110, i111: in std_logic_vector(15 downto 0);
            s: in std_logic_vector (2 downto 0);
            o: out std_logic_vector (15 downto 0));
    end component;

    component ALU is
        port(x,y: in std_logic_vector (15 downto 0);
            op: in std_logic_vector (1 downto 0);
            s: out std_logic_vector(15 downto 0);
            c_out,z_out: out std_logic);
    end component;

    component RF is
        port(RF_write, PC_write: in std_logic;
            A1,A2,A3: in std_logic_vector (2 downto 0);
            D3,PC_in: in std_logic_vector(15 downto 0);
            D1,D2,PC_out: out std_logic_vector(15 downto 0);
            R0,R1,R2,R3,R4,R5,R6,R7: out std_logic_vector(15 downto 0);
            rst, clk: in std_logic);
    end component;

    component Memory is
        port(Mem_write, Mem_read: in std_logic;
            Mem_ad, Mem_dat: in std_logic_vector (15 downto 0);
            edb: out std_logic_vector(15 downto 0);
            clk,rst: in std_logic);
    end component;

    component Comparator is
        port(x,y: in std_logic_vector (15 downto 0);
        z_out: out std_logic);
    end component;

    component ZeroComparator is
        port(x: in std_logic_vector (15 downto 0);
        z_out: out std_logic);
    end component;

    component PadNine is
        port(x: in std_logic_vector (8 downto 0);
            y: out std_logic_vector (15 downto 0));
    end component;

    component RF2 is
        port(RF_write, PC_write, flag, force: in std_logic;
            A1,A2,A3: in std_logic_vector (2 downto 0);
            D3,PC_in, PC_old: in std_logic_vector(15 downto 0);
            D1,D2,PC_out: out std_logic_vector(15 downto 0);
             Ro: out arr1(8 downto 0);
            RF_comp: out std_logic;
            rst, clk: in std_logic);
    end component;

    component M_Decoder is
        port(instr: in std_logic_vector(15 downto 0);
            new_instr: out std_logic_vector (15 downto 0);
            reg: out std_logic_vector (2 downto 0);
            flag: out std_logic);
    end component;

    component InstructionDecoder is
        port(instr: in std_logic_vector(15 downto 0);
            m_dec_reg: in std_logic_vector(2 downto 0);
            rs1,rs2,rd: out std_logic_vector(2 downto 0);
            branch, decode_br_loc, regread_br_loc: out std_logic;
            branch_state: out std_logic_vector (1 downto 0);
            mem_read, mem_write, rf_write: out std_logic);
    end component;

    component LoadHazard is
        port(instr_dec, instr_read: in std_logic_vector(15 downto 0);
            rs1_dec,rs2_dec,rd_read: in std_logic_vector(2 downto 0);
            dec_stall, read_stall: in std_logic;
            flag: out std_logic);
    end component;

    component FlagDecoder is
        port(instr: in std_logic_vector(15 downto 0);
            o_z, o_c, stall,in_z, in_c: in std_logic;
            n_z,n_c,condition: out std_logic);
    end component;

    component RFW_Decoder is
        port(instr: in std_logic_vector(15 downto 0);
            in_rfw ,condition: in std_logic;
            out_rfw: out std_logic);
    end component;

    component ControlHazardDetector is
	port (
		output_branch_loc: out std_logic_vector(15 downto 0);
        output_branch_now,decode_stall,execute_stall,regread_stall: out std_logic;
        decode_branch_now,regread_branch_now,execute_branch_now,memory_branch_now: in std_logic;
        decode_branch_loc,regread_branch_loc,execute_branch_loc,
        memory_branch_loc: in std_logic_vector(15 downto 0)
	     );
    end component;

    component DHD is
        port( ex_rfw, ex_stall, mem_rfw, mem_stall, wb_rfw, wb_stall: in std_logic;
            rr_rs1, rr_rs2, ex_rd, mem_rd, wb_rd: in std_logic_vector(2 downto 0);
            rr_data1, rr_data2, ex_data, mem_data, wb_data: in std_logic_vector(15 downto 0);
            data1_out, data2_out: out std_logic_vector(15 downto 0)	      
            );
    end component;

    component InstructionMemory is
        port(
            Mem_ad: in std_logic_vector (15 downto 0);
            edb: out std_logic_vector(15 downto 0);
            clk,rst: in std_logic);
    end component;
end EE224_Components;

