library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity LoadHazard is
    port(instr_dec, instr_read: in std_logic_vector(15 downto 0);
        rs1_dec,rs2_dec,rd_read: in std_logic_vector(2 downto 0);
        dec_stall, read_stall: in std_logic;
        flag: out std_logic);
end entity;

architecture Behave of LoadHazard is

begin
    process(instr_dec, instr_read, rs1_dec, rs2_dec, rd_read, dec_stall, read_stall)
        variable x_flag: std_logic;
        variable x_instr_nib : std_logic_vector(3 downto 0);
    begin
        x_instr_nib := instr_dec(15 downto 12);
        x_flag := '0';
        if((instr_read(15 downto 12) /= "0100" and instr_read(15 downto 12) /= "0110" and
                    instr_read(15 downto 12) /= "1110") or (dec_stall = '1' or read_stall = '1')
                    or rd_read = "111") then
            x_flag := '0';
        else
            case x_instr_nib is

                when "0000" =>      --ADD
                    --if(instr_read(1 downto 0) = "01") then
                    --    x_flag := '1';
                    --else
                        if((rs1_dec = rd_read) or (rs2_dec = rd_read)) then
                            x_flag := '1';
                        end if;
                    --end if;

                when "0010" =>      --NAND
                    --if(instr_read(1 downto 0) = "01") then
                    --    x_flag := '1';
                    --else
                        if((rs1_dec = rd_read) or (rs2_dec = rd_read)) then
                            x_flag := '1';
                        end if;
                    --end if;

                when "0001" =>      --ADI
                    if((rs1_dec = rd_read)) then
                        x_flag := '1';
                    end if;

                when "0011" =>      --LHI


                when "0100" =>      --LW
                    if((rs1_dec = rd_read)) then
                        x_flag := '1';
                    end if;

                when "0101" =>      --SW
                    if((rs1_dec = rd_read) or (rs2_dec = rd_read)) then
                        x_flag := '1';
                    end if;

                when "0110" =>      --LM
                    if((rs1_dec = rd_read)) then
                        x_flag := '1';
                    end if;

                when "1110" =>      --LM_fake


                when "0111" =>      --SM
                    if((rs1_dec = rd_read) or (rs2_dec = rd_read)) then
                        x_flag := '1';
                    end if;

                when "1111" =>      --SM_fake


                when "1100" =>      --BEQ
                    if((rs1_dec = rd_read) or (rs2_dec = rd_read)) then
                        x_flag := '1';
                    end if;

                when "1000" =>      --JAL


                when "1001" =>      --JLR
                    if((rs1_dec = rd_read)) then
                        x_flag := '1';
                    end if;

                when others =>
            end case;
        end if;
        flag <= x_flag;
    end process;
end Behave;
