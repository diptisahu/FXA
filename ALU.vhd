library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.Microprocessor_project.all;

entity alu is
    port(
        IP1, IP2 : in std_logic_vector(15 downto 0);
        OP : out std_logic_vector(15 downto 0);
        aluOP : in std_logic;
	C,Z : out std_logic);
end entity;

architecture Behave of alu is
signal IP1_s : std_logic_vector(16 downto 0);
signal IP2_s : std_logic_vector(16 downto 0);
signal OP_s : std_logic_vector(16 downto 0);

begin
	IP1_s(16) <= '0';
	IP1_s(15 downto 0) <= IP1;
	IP2_s(16) <= '0';
	IP2_s(15 downto 0) <= IP2;
	
	OP_s <= std_logic_vector(unsigned(IP1_s) + unsigned(IP2_s));
	OP <= std_logic_vector(OP_s(15 downto 0)) when (aluOP='0') 
	        else (IP1 nand IP2);
	C <= OP_s(16) when (aluOP='0') else '0';
        Z <= '1' when (OP_s(15 downto 0)="0000000000000000") else '0';
end Behave;
