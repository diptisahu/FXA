library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.Microprocessor_project.all;
use work.mem_package.all;

entity dataMemory is
    port( 
        A,B,Din1,Din2 : in std_logic_vector(15 downto 0);
        Dout1,Dout2 : out std_logic_vector(15 downto 0);
        memWR1,memWR2 : in std_logic;
        clk : in std_logic);
end entity;

architecture Behave of dataMemory is
    signal ram : ram_t := MEM_INIT;
    signal a_sync: std_logic_vector(15 downto 0);
    signal b_sync: std_logic_vector(15 downto 0);
begin
    Dout1 <= ram(to_integer(unsigned(a_sync)));
    Dout2 <= ram(to_integer(unsigned(b_sync)));
    process(clk)
    begin
        if(rising_edge(Clk)) then
            if(memWR1='1') then
                ram(to_integer(unsigned(A))) <= Din1;
            end if;
	    if(memWR2='1') then
                ram(to_integer(unsigned(B))) <= Din2;
            end if;
            a_sync <= a;
            b_sync <= b;
        end if;
        
    end process;
end Behave;
