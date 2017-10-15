library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.Microprocessor_project.all;

--without dispatching logic
entity ROB is
    port(
        rob_in1, rob_in2 : in std_logic_vector(100 downto 0);
	data1, data2, data3, pci : out std_logic_vector(15 downto 0);
	add1, add2, add3 : out std_logic_vector(2 downto 0);
	regWr1, regWr2, regWr3 : out std_logic;
	clk, reset : in std_logic);
end entity;

architecture Behave of ROB is
    type vec102 is array(natural range <>) of std_logic_vector(101 downto 0);
    signal reg : vec102(0 to 15) := (others => (others => '0'));
    signal temp1, temp2: std_logic_vector(101 downto 0);
begin

    temp1(100 downto 0) <= rob_in1;
    temp1(101) <= '1';			--occupied
  
    temp2(100 downto 0) <= rob_in2;
    temp2(101) <= '1';			--occupied
  
    process(clk)
        variable wrAddr1,wrAddr2 : integer := 16;
	variable temp : std_logic_vector(101 downto 0);
	variable stall_in_1, stall_in_2 : std_logic;
    begin
    	stall_in_1 := '1';
    	stall_in_2 := '1';

	temp := reg(15);
	if(temp(101)='0') then
	    wrAddr1 := 15;
	    stall_in_1 := '0';
	end if;
	temp :=reg(14);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 14;
	    	stall_in_1 := '0';
	    else
		wrAddr2 := 14;
		stall_in_2 := '0';
	    end if;
	end if;
	temp :=reg(13);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 13;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 13;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(12);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 12;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 12;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(11);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 11;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 11;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(10);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 10;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 10;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(9);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 9;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 9;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(8);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 8;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 8;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(7);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 7;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 7;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(6);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 6;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 6;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(5);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 5;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 5;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(4);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 4;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 4;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(3);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 3;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 3;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(2);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 2;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 2;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(1);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 1;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 1;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;
	temp :=reg(0);
	if(temp(101)='0') then
	    if (stall_in_1='1') then
	    	wrAddr1 := 0;
	    	stall_in_1 := '0';
	    else
		if (stall_in_2='1') then
		    wrAddr2 := 0;
		    stall_in_2 := '0';
		end if;
	    end if;
	end if;

        if(rising_edge(Clk)) then
            if(reset='1') then
                reg <= (others => (others => '0'));
            else 					
                reg(wrAddr1) <= temp1;
                reg(wrAddr2) <= temp2;
            end if;
        end if; 
    end process;

end Behave;
