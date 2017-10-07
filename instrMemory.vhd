library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.Microprocessor_project.all;
use work.mem_package.all;

entity instrMemory is
    port( 
        A,B : in std_logic_vector(15 downto 0);
        Dout1,Dout2 : out std_logic_vector(15 downto 0);
        memWR : in std_logic;
        clk : in std_logic);
end entity;

architecture Behave of instrMemory is
    signal ram : ram_t := MEM_INIT;
    signal a_sync: std_logic_vector(15 downto 0);
    signal b_sync: std_logic_vector(15 downto 0);
begin
    Dout1 <= ram(to_integer(unsigned(a_sync)));
    Dout2 <= ram(to_integer(unsigned(b_sync)));
end Behave;
