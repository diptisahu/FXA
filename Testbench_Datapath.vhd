library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;
library work;
use work.EE224_Components.arr1;

entity Testbench_Datapath is
end entity;
architecture Behave of Testbench_Datapath is

    component Datapath is
        port(
        R0,R1,R2,R3,R4,R5,R6,R7: out std_logic_vector(15 downto 0);
        clk,rst: in std_logic);
    end component;

  signal clk: std_logic := '0';
  signal rst: std_logic;
  signal Ro0,Ro1,Ro2,Ro3,Ro4,Ro5,Ro6,Ro7: std_logic_vector(15 downto 0);
  

  function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;

  function to_std_logic(z: bit) return std_logic is
variable ret_val: std_logic;
begin
if (z = '1') then
ret_val := '1';
else
ret_val := '0';
end if;
return(ret_val);
end to_std_logic;

  function to_std_logic_vector(x: bit_vector) return std_logic_vector is
    alias lx: bit_vector(1 to x'length) is x;
    variable ret_var : std_logic_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
           ret_var(I) :=  '1';
        else 
           ret_var(I) :=  '0';
	end if;
     end loop;
     return(ret_var);
  end to_std_logic_vector;

begin
  clk <= not clk after 5 ns; -- assume 10ns clock.

    -- reset process
  process
  begin
     wait until clk = '1';
     rst <= '1';
     wait until clk = '0';
     wait until clk = '1';
     rst <= '0';
     wait;
  end process;


  dut: Datapath
     port map(
     R0 => Ro0, R1 => Ro1, R2 => Ro2, R3 => Ro3, R4 => Ro4, R5 => Ro5,R6=>Ro6,R7=> Ro7,
      clk => clk, rst => rst);

end Behave;
