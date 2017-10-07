library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Microprocessor_project.all;

entity instructionDecoder is
    port(instr1, instr2: in std_logic_vector(15 downto 0);
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
end entity;

architecture Behave of instructionDecoder is

begin

    process(instr1, m_dec_reg1)
        variable x_rs11, x_rs12, x_rd1: std_logic_vector(2 downto 0);
        variable x_instr1_nib: std_logic_vector ( 3 downto 0);

        variable x_branch1, x_decode_br_loc1, x_regread_br_loc1,
                x_mem_read1, x_mem_write1, x_rf_write1: std_logic ;
        variable x_branch1_state: std_logic_vector (1 downto 0);

    begin
        x_rs11 := "000";x_rs12 := "000";x_rd1 := "000";
        x_branch1 := '0'; x_decode_br_loc1 := '0'; x_regread_br_loc1 := '0';
        x_mem_read1 := '0'; x_mem_write1 := '0'; x_rf_write1 := '0';
        x_branch1_state := "00";
        x_instr1_nib := instr1(15 downto 12);
        case x_instr1_nib is

            when "0000" =>      --ADD
                x_rs11 := instr1(11 downto 9);
                x_rs12 := instr1(8 downto 6);
                x_rd1 := instr1(5 downto 3);

                if(x_rd1 = "111") then
                    x_branch1 := '1';
                    x_branch1_state := "10";
                end if;

                if(x_branch1 = '0') then
                    x_rf_write1 := '1';
                end if;

            when "0010" =>      --NAND
                x_rs11 := instr1(11 downto 9);
                x_rs12 := instr1(8 downto 6);
                x_rd1 := instr1(5 downto 3);

                if(x_rd1 = "111") then
                    x_branch1 := '1';
                    x_branch1_state := "10";
                end if;

                if(x_branch1 = '0') then
                    x_rf_write1 := '1';
                end if;

            when "0001" =>      --ADI
                x_rs11 := instr1(11 downto 9);
                x_rd1 := instr1(8 downto 6);

                if(x_rd1 = "111") then
                    x_branch1 := '1';
                    x_branch1_state := "10";
                end if;

                if(x_branch1 = '0') then
                    x_rf_write1 := '1';
                end if;

            when "0011" =>      --LHI
                x_rd1 := instr1(11 downto 9);

                if(x_rd1 = "111") then
                    x_branch1 := '1';
                    x_branch1_state := "00";
                end if;

                x_decode_br_loc1 := '0';

                if(x_branch1 = '0') then
                    x_rf_write1 := '1';
                end if;

            when "0100" =>      --LW
                x_rs11 := instr1(8 downto 6);
                x_rd1 := instr1( 11 downto 9);

                if(x_rd1 = "111") then
                    x_branch1 := '1';
                    x_branch1_state := "11";
                end if;

                x_mem_read1 := '1';

                if(x_branch1 = '0') then
                    x_rf_write1 := '1';
                end if;

            when "0101" =>      --SW
                x_rs11 := instr1(8 downto 6);
                x_rs12 := instr1(11 downto 9);

                x_mem_write1 := '1';

            when "0110" =>      --LM
                x_rs11 := instr1(11 downto 9);
                x_rd1 := m_dec_reg1;

                if(x_rd1 = "111") then
                    x_branch1 := '1';
                    x_branch1_state := "11";
                end if;

                x_mem_read1 := '1';

                if(x_branch1 = '0') then
                    x_rf_write1 := '1';
                end if;

            when "1110" =>      --LM_fake
                x_rd1 := m_dec_reg1;

                if(x_rd1 = "111") then
                    x_branch1 := '1';
                    x_branch1_state := "11";
                end if;

                x_mem_read1 := '1';

                if(x_branch1 = '0') then
                    x_rf_write1 := '1';
                end if;

            when "0111" =>      --SM
                x_rs11 := instr1(11 downto 9);
                x_rs12 := m_dec_reg1;

                x_mem_write1 := '1';

            when "1111" =>      --SM_fake
                x_rs12 := m_dec_reg1;

                x_mem_write1 := '1';

            when "1100" =>      --BEQ
                x_rs11 := instr1(11 downto 9);
                x_rs12 := instr1(8 downto 6);

                x_branch1 := '1';
                x_branch1_state := "01";

                x_regread_br_loc1 := '0';

            when "1000" =>      --JAL
                x_rd1 := instr1(11 downto 9);

                x_branch1 := '1';
                x_branch1_state := "00";

                x_decode_br_loc1 := '1';

                x_rf_write1 := '1';

            when "1001" =>      --JLR
                x_rs11 := instr1(8 downto 6);
                x_rd1 := instr1(11 downto 9);

                x_branch1 := '1';
                x_branch1_state := "01";

                x_regread_br_loc1 := '1';

                x_rf_write1 := '1';

            when others =>
        end case;
        rs11 <= x_rs11; rs12 <= x_rs12; rd1 <= x_rd1;
        mem_read1 <= x_mem_read1;mem_write1 <= x_mem_write1; rf_write1 <= x_rf_write1;
        branch1 <= x_branch1; decode_br_loc1 <= x_decode_br_loc1;
        regread_br_loc1 <= x_regread_br_loc1;
        branch1_state <= x_branch1_state;
    end process;


    process(instr2, m_dec_reg2)
        variable x_rs21, x_rs22, x_rd2: std_logic_vector(2 downto 0);
        variable x_instr2_nib: std_logic_vector ( 3 downto 0);

        variable x_branch2, x_decode_br_loc2, x_regread_br_loc2,
                x_mem_read2, x_mem_write2, x_rf_write2: std_logic ;
        variable x_branch2_state: std_logic_vector (1 downto 0);

    begin
        x_rs21 := "000";x_rs22 := "000";x_rd2 := "000";
        x_branch2 := '0'; x_decode_br_loc2 := '0'; x_regread_br_loc2 := '0';
        x_mem_read2 := '0'; x_mem_write2 := '0'; x_rf_write2 := '0';
        x_branch2_state := "00";
        x_instr2_nib := instr2(15 downto 12);
        case x_instr2_nib is

            when "0000" =>      --ADD
                x_rs21 := instr2(11 downto 9);
                x_rs22 := instr2(8 downto 6);
                x_rd2 := instr2(5 downto 3);

                if(x_rd2 = "111") then
                    x_branch2 := '1';
                    x_branch2_state := "10";
                end if;

                if(x_branch2 = '0') then
                    x_rf_write2 := '1';
                end if;

            when "0010" =>      --NAND
                x_rs21 := instr2(11 downto 9);
                x_rs22 := instr2(8 downto 6);
                x_rd2 := instr2(5 downto 3);

                if(x_rd2 = "111") then
                    x_branch2 := '1';
                    x_branch2_state := "10";
                end if;

                if(x_branch2 = '0') then
                    x_rf_write2 := '1';
                end if;

            when "0001" =>      --ADI
                x_rs21 := instr2(11 downto 9);
                x_rd2 := instr2(8 downto 6);

                if(x_rd2 = "111") then
                    x_branch2 := '1';
                    x_branch2_state := "10";
                end if;

                if(x_branch2 = '0') then
                    x_rf_write2 := '1';
                end if;

            when "0011" =>      --LHI
                x_rd2 := instr2(11 downto 9);

                if(x_rd2 = "111") then
                    x_branch2 := '1';
                    x_branch2_state := "00";
                end if;

                x_decode_br_loc2 := '0';

                if(x_branch2 = '0') then
                    x_rf_write2 := '1';
                end if;

            when "0100" =>      --LW
                x_rs21 := instr2(8 downto 6);
                x_rd2 := instr2( 11 downto 9);

                if(x_rd2 = "111") then
                    x_branch2 := '1';
                    x_branch2_state := "11";
                end if;

                x_mem_read2 := '1';

                if(x_branch2 = '0') then
                    x_rf_write2 := '1';
                end if;

            when "0101" =>      --SW
                x_rs21 := instr2(8 downto 6);
                x_rs22 := instr2(11 downto 9);

                x_mem_write2 := '1';

            when "0110" =>      --LM
                x_rs21 := instr2(11 downto 9);
                x_rd2 := m_dec_reg2;

                if(x_rd2 = "111") then
                    x_branch2 := '1';
                    x_branch2_state := "11";
                end if;

                x_mem_read2 := '1';

                if(x_branch2 = '0') then
                    x_rf_write2 := '1';
                end if;

            when "1110" =>      --LM_fake
                x_rd2 := m_dec_reg2;

                if(x_rd2 = "111") then
                    x_branch2 := '1';
                    x_branch2_state := "11";
                end if;

                x_mem_read2 := '1';

                if(x_branch2 = '0') then
                    x_rf_write2 := '1';
                end if;

            when "0111" =>      --SM
                x_rs21 := instr2(11 downto 9);
                x_rs22 := m_dec_reg2;

                x_mem_write2 := '1';

            when "1111" =>      --SM_fake
                x_rs22 := m_dec_reg2;

                x_mem_write2 := '1';

            when "1100" =>      --BEQ
                x_rs21 := instr2(11 downto 9);
                x_rs22 := instr2(8 downto 6);

                x_branch2 := '1';
                x_branch2_state := "01";

                x_regread_br_loc2 := '0';

            when "1000" =>      --JAL
                x_rd2 := instr2(11 downto 9);

                x_branch2 := '1';
                x_branch2_state := "00";

                x_decode_br_loc2 := '1';

                x_rf_write2 := '1';

            when "1001" =>      --JLR
                x_rs21 := instr2(8 downto 6);
                x_rd2 := instr2(11 downto 9);

                x_branch2 := '1';
                x_branch2_state := "01";

                x_regread_br_loc2 := '1';

                x_rf_write2 := '1';

            when others =>
        end case;
        rs21 <= x_rs21; rs22 <= x_rs22; rd2 <= x_rd2;
        mem_read2 <= x_mem_read2;mem_write2 <= x_mem_write2; rf_write2 <= x_rf_write2;
        branch2 <= x_branch2; decode_br_loc2 <= x_decode_br_loc2;
        regread_br_loc2 <= x_regread_br_loc2;
        branch2_state <= x_branch2_state;
    end process;

end Behave;
