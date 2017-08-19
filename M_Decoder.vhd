library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity M_Decoder is
    port(instr: in std_logic_vector(15 downto 0);
        new_instr: out std_logic_vector (15 downto 0);
        reg: out std_logic_vector (2 downto 0);
        flag: out std_logic);
end entity;

architecture Behave of M_Decoder is
    signal pe_s: std_logic_vector(2 downto 0);
    signal pe_N, flag_sig:  std_logic;
    signal pe_tnew: std_logic_vector (7 downto 0);
begin
    pe: PriorityEncoder port map(x => instr(7 downto 0), s => pe_s, N => pe_N, tnew => pe_tnew);
    new_instr <= "1" & instr(14 downto 8) & pe_tnew;
    reg <= pe_s;

    flag <= '0' when instr(14 downto 13) /= "11" else flag_sig;

    flag_sig <= pe_tnew(0) or pe_tnew(1) or pe_tnew(2) or pe_tnew(3) or pe_tnew(4) or
                pe_tnew(5) or pe_tnew(6) or pe_tnew(7);

end Behave;

