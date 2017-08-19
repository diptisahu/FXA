library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity InstructionDecoder is
    port(instr: in std_logic_vector(15 downto 0);
        m_dec_reg: in std_logic_vector(2 downto 0);
        rs1,rs2,rd: out std_logic_vector(2 downto 0);
        branch, decode_br_loc, regread_br_loc: out std_logic;
        branch_state: out std_logic_vector (1 downto 0);
        mem_read, mem_write, rf_write: out std_logic);
end entity;

architecture Behave of InstructionDecoder is

begin

    process(instr, m_dec_reg)
        variable x_rs1, x_rs2, x_rd: std_logic_vector(2 downto 0);
        variable x_instr_nib: std_logic_vector ( 3 downto 0);

        variable x_branch, x_decode_br_loc, x_regread_br_loc,
                x_mem_read, x_mem_write, x_rf_write: std_logic ;
        variable x_branch_state: std_logic_vector (1 downto 0);


    begin
        x_rs1 := "000";x_rs2 := "000";x_rd := "000";
        x_branch := '0'; x_decode_br_loc := '0'; x_regread_br_loc := '0';
        x_mem_read := '0'; x_mem_write := '0'; x_rf_write := '0';
        x_branch_state := "00";
        x_instr_nib := instr(15 downto 12);
        case x_instr_nib is

            when "0000" =>      --ADD
                x_rs1 := instr(11 downto 9);
                x_rs2 := instr(8 downto 6);
                x_rd := instr(5 downto 3);

                if(x_rd = "111") then
                    x_branch := '1';
                    x_branch_state := "10";
                end if;

                if(x_branch = '0') then
                    x_rf_write := '1';
                end if;

            when "0010" =>      --NAND
                x_rs1 := instr(11 downto 9);
                x_rs2 := instr(8 downto 6);
                x_rd := instr(5 downto 3);

                if(x_rd = "111") then
                    x_branch := '1';
                    x_branch_state := "10";
                end if;

                if(x_branch = '0') then
                    x_rf_write := '1';
                end if;

            when "0001" =>      --ADI
                x_rs1 := instr(11 downto 9);
                x_rd := instr(8 downto 6);

                if(x_rd = "111") then
                    x_branch := '1';
                    x_branch_state := "10";
                end if;

                if(x_branch = '0') then
                    x_rf_write := '1';
                end if;

            when "0011" =>      --LHI
                x_rd := instr(11 downto 9);

                if(x_rd = "111") then
                    x_branch := '1';
                    x_branch_state := "00";
                end if;

                x_decode_br_loc := '0';

                if(x_branch = '0') then
                    x_rf_write := '1';
                end if;

            when "0100" =>      --LW
                x_rs1 := instr(8 downto 6);
                x_rd := instr( 11 downto 9);

                if(x_rd = "111") then
                    x_branch := '1';
                    x_branch_state := "11";
                end if;

                x_mem_read := '1';

                if(x_branch = '0') then
                    x_rf_write := '1';
                end if;

            when "0101" =>      --SW
                x_rs1 := instr(8 downto 6);
                x_rs2 := instr(11 downto 9);

                x_mem_write := '1';

            when "0110" =>      --LM
                x_rs1 := instr(11 downto 9);
                x_rd := m_dec_reg;

                if(x_rd = "111") then
                    x_branch := '1';
                    x_branch_state := "11";
                end if;

                x_mem_read := '1';

                if(x_branch = '0') then
                    x_rf_write := '1';
                end if;

            when "1110" =>      --LM_fake
                x_rd := m_dec_reg;

                if(x_rd = "111") then
                    x_branch := '1';
                    x_branch_state := "11";
                end if;

                x_mem_read := '1';

                if(x_branch = '0') then
                    x_rf_write := '1';
                end if;

            when "0111" =>      --SM
                x_rs1 := instr(11 downto 9);
                x_rs2 := m_dec_reg;

                x_mem_write := '1';

            when "1111" =>      --SM_fake
                x_rs2 := m_dec_reg;

                x_mem_write := '1';

            when "1100" =>      --BEQ
                x_rs1 := instr(11 downto 9);
                x_rs2 := instr(8 downto 6);

                x_branch := '1';
                x_branch_state := "01";

                x_regread_br_loc := '0';

            when "1000" =>      --JAL
                x_rd := instr(11 downto 9);

                x_branch := '1';
                x_branch_state := "00";

                x_decode_br_loc := '1';

                x_rf_write := '1';

            when "1001" =>      --JLR
                x_rs1 := instr(8 downto 6);
                x_rd := instr(11 downto 9);

                x_branch := '1';
                x_branch_state := "01";

                x_regread_br_loc := '1';

                x_rf_write := '1';

            when others =>
        end case;
        rs1 <= x_rs1; rs2 <= x_rs2; rd <= x_rd;
        mem_read <= x_mem_read;mem_write <= x_mem_write; rf_write <= x_rf_write;
        branch <= x_branch; decode_br_loc <= x_decode_br_loc;
        regread_br_loc <= x_regread_br_loc;
        branch_state <= x_branch_state;
    end process;
end Behave;
