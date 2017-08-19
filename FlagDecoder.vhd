library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity FlagDecoder is
    port(instr: in std_logic_vector(15 downto 0);
        o_z, o_c, stall,in_z, in_c: in std_logic;
        n_z,n_c,condition: out std_logic);
end entity;

architecture Behave of FlagDecoder is
begin
    process(instr, o_z, o_c, stall, in_z, in_c)
        variable x_n_z, x_n_c, x_condition: std_logic;
    begin
        x_n_z := o_z;
        x_n_c := o_c;
        x_condition := '0';
        if(stall = '1' or (instr(15 downto 12) /= "0000" and instr(15 downto 12) /= "0001"
            and instr(15 downto 12) /= "0010")) then
        else
            case instr(15 downto 12) is
                when "0000" =>
                    x_condition := (not instr(1) and not instr(0)) or (o_c and instr(1))
                                    or (o_z and instr(0));
                    if(x_condition = '1') then
                        x_n_z := in_z;
                        x_n_c := in_c;
                    end if;

                when "0010" =>
                    --x_n_z := in_z;
                    x_condition := (not instr(1) and not instr(0)) or (o_c and instr(1))
                                    or (o_z and instr(0));

                    if(x_condition = '1') then
                        x_n_z := in_z;
                    end if;

                when "0001" =>
                    x_condition := '1';
                    x_n_z := in_z;
                    x_n_c := in_c;

                when others =>
            end case;
        end if;
        n_z <= x_n_z; n_c <= x_n_c;condition <= x_condition;
    end process;
end Behave;


