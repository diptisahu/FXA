library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
library work;
use work.Microprocessor_project.all;

--retire mechanism not included
entity LookTable is
    port(
        pc_in1, pc_in2 : in std_logic_vector(15 downto 0);
	pc_out1, pc_out2, pc_out3, pc_out4 : out std_logic_vector(15 downto 0);
	retire1, retire2, retire3, retire4 : in std_logic;
	clk, reset : in std_logic);
end entity;

architecture Behave of LookTable is
    type vec16 is array(natural range <>) of std_logic_vector(15 downto 0);
    signal reg : vec16(0 to 31) := (others => (others => '0'));
    constant zero: std_logic_vector(15 downto 0) := "0000000000000000";
begin

    pc_out1 <= reg(0);
    pc_out2 <= reg(1);
    pc_out3 <= reg(2);
    pc_out4 <= reg(3);

    process (clk)
	variable wrAddr1, wrAddr2 : integer := 16;
    	variable dirty1, dirty2 : std_logic;
    begin
	dirty1 := '1';
	dirty2 := '1';

	if (reg(0)=zero) then
	    wrAddr1 := 0;
	    dirty1 := '0';
	end if;

	if (reg(1)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 1;
		dirty1 := '0';
	    else
		wrAddr2 := 1;
		dirty2 := '0';
	    end if;
	end if;

	if (reg(2)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 2;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 2;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(3)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 3;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 3;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(4)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 4;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 4;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(5)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 5;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 5;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(6)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 6;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 6;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(7)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 7;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 7;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(8)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 8;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 8;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(9)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 9;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 9;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(10)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 10;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 10;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(11)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 11;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 11;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(12)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 12;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 12;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(13)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 13;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 13;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(14)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 14;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 14;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(15)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 15;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 15;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(16)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 16;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 16;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(17)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 17;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 17;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(18)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 18;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 18;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(19)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 19;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 19;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(20)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 20;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 20;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(21)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 21;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 21;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(22)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 22;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 22;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(23)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 23;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 23;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(24)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 24;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 24;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(24)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 24;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 24;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(25)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 25;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 25;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(26)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 26;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 26;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(27)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 27;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 27;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(28)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 28;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 28;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(29)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 29;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 29;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(30)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 30;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 30;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

	if (reg(31)=zero) then
	    if (dirty1 = '1') then
		wrAddr1 := 31;
		dirty1 := '0';
	    else
		if (dirty2 = '1') then
		    wrAddr2 := 31;
		    dirty2 := '0';
		end if;
	    end if;
	end if;

        if(rising_edge(Clk)) then
            if(reset='1') then
                reg <= (others => (others => '0'));
            else 					
                reg(wrAddr1) <= pc_in1;
                reg(wrAddr2) <= pc_in2;
            end if;
        end if;
    end process;
end Behave;
