library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity RFW_Decoder is
    port(instr: in std_logic_vector(15 downto 0);
        in_rfw ,condition: in std_logic;
        out_rfw: out std_logic);
end entity;

architecture Behave of RFW_Decoder is
begin
    process(instr, in_rfw, condition)
        variable x_out_rfw: std_logic;
    begin
        if(instr(15 downto 12) = "0000" or instr(15 downto 12) = "0010") then
            x_out_rfw := in_rfw and condition;
        else
            x_out_rfw := in_rfw;
        end if;
        out_rfw <= x_out_rfw;
    end process;

end Behave;
