library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.Microprocessor_project.all;

entity regRenameFile is
    port(
        a1, a2, a3, a4, a5, a6, a7 : in std_logic_vector(2 downto 0);
        d5, d6, d7 : in std_logic_vector(15 downto 0);
        d1, d2, d3, d4 : out std_logic_vector(15 downto 0);
        regWr1, regWr2, regWr3 : in std_logic;
        bit1, bit2, bit3, bit4 : out std_logic;
        clk, reset : in std_logic);
end entity;

architecture Behave of regRenameFile is
    type vec16 is array(natural range <>) of std_logic_vector(15 downto 0);
    type vec1 is array(natural range <>) of std_logic;
    signal reg : vec16(0 to 7) := (others => (others => '0'));
    signal dirty : vec1(0 to 7) := (others => '0');
begin

    d1 <= reg(to_integer(unsigned(a1)));
    d2 <= reg(to_integer(unsigned(a2)));
    d3 <= reg(to_integer(unsigned(a3)));
    d4 <= reg(to_integer(unsigned(a4)));

    bit1 <= dirty(to_integer(unsigned(a1)));
    bit2 <= dirty(to_integer(unsigned(a2)));
    bit3 <= dirty(to_integer(unsigned(a3)));
    bit4 <= dirty(to_integer(unsigned(a4)));
    
    process(clk)
        variable wrAddr1, wrAddr2, wrAddr3: integer := 0;
    begin
        wrAddr1 := to_integer(unsigned(a5));
	wrAddr2 := to_integer(unsigned(a6));
	wrAddr3 := to_integer(unsigned(a7));
        if(rising_edge(Clk)) then
            if(reset='1') then
                reg <= (others => (others => '0'));
            else 
                if(regWr1='1') then
                    reg(wrAddr1) <= d5;
                end if;
		if(regWr2='1') then
                    reg(wrAddr2) <= d6;
                end if;
		if(regWr3='1') then
                    reg(wrAddr3) <= d7;
                end if;
            end if;
        end if; 
    end process;
end Behave;
