library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;

entity Comparator is
	port(
        Comp_D1,Comp_D2: in std_logic_vector(15 downto 0);
	    Comp_out: out std_logic);
end entity;

architecture Behave of Comparator is
begin
    process(Comp_D1,Comp_D2)
	begin
        if(Comp_D1=Comp_D2) then
            Comp_out<='1';
        else
        	Comp_out<='0';
		end if;
    end process;
end Behave;
