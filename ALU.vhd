library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity ALU is
    port(x,y: in std_logic_vector (15 downto 0);
        op: in std_logic_vector (1 downto 0);
        s: out std_logic_vector(15 downto 0);
        c_out,z_out: out std_logic);
end entity;

architecture Behave of ALU is
    signal ao,so,no,tmp: std_logic_vector (15 downto 0);
    signal aco,sco: std_logic;

begin
    a1: SixteenBitAdder port map (x => x, y => y, s => ao, c_out => aco);
    s1: SixteenBitSubtractor port map(x => x, y => y, s => so, b => sco);
    n1: SixteenBitNand port map(x => x, y => y, s => no);

    mf1: MuxFour port map (i00 => ao, i01 => so, i10 => no, i11 => ao, s => op, o => tmp);

    c_out <= aco when op = "00" else
            '0';
            
    s <= tmp;
    z_out <= '1' when tmp = "0000000000000000" else '0';
end Behave;
