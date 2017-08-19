library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity ControlHazardDetector is
	port (
		output_branch_loc: out std_logic_vector(15 downto 0);
        output_branch_now,decode_stall,execute_stall,regread_stall: out std_logic;
        decode_branch_now,regread_branch_now,execute_branch_now,memory_branch_now: in std_logic;
        decode_branch_loc,regread_branch_loc,execute_branch_loc,memory_branch_loc: in std_logic_vector(15 downto 0)
	     );
end entity;

architecture Behave of ControlHazardDetector is
begin

   process(decode_branch_loc,regread_branch_loc,execute_branch_loc,memory_branch_loc,decode_branch_now,regread_branch_now,execute_branch_now,memory_branch_now)
      variable x_output_branch_now,x_decode_stall,x_execute_stall,x_regread_stall: std_logic;
      variable x_output_branch_loc: std_logic_vector(15 downto 0);

   begin
       -- defaults
       x_output_branch_now := '0';
       x_decode_stall := '0';
       x_execute_stall := '0';
       x_regread_stall := '0';
       x_output_branch_now := '0';
       x_output_branch_loc := (others => '0');

       if decode_branch_now='1' then
       x_output_branch_loc := decode_branch_loc;  
       x_output_branch_now := '1';    
       end if ;

       if regread_branch_now='1' then
       x_output_branch_loc := regread_branch_loc;
       x_output_branch_now := '1';
       x_decode_stall := '1';
       end if ;
       
       if execute_branch_now='1' then
       x_output_branch_loc := execute_branch_loc;
       x_output_branch_now := '1';
       x_decode_stall := '1';
       x_regread_stall := '1';     
       end if ;

       if memory_branch_now='1' then
       x_output_branch_loc := memory_branch_loc;
       x_output_branch_now := '1';
       x_decode_stall := '1';
       x_regread_stall := '1';
       x_execute_stall := '1';       
       end if ;

       output_branch_loc <= x_output_branch_loc;
       output_branch_now <= x_output_branch_now;
       decode_stall <= x_decode_stall;
       regread_stall <= x_regread_stall;
       execute_stall <= x_execute_stall;
    
    end process;
end Behave;
