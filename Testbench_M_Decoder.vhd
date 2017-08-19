library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;

entity Testbench_M_Decoder is
end entity;
architecture Behave of Testbench_M_Decoder is
component M_Decoder is
    port(instr: in std_logic_vector(15 downto 0);
        new_instr: out std_logic_vector (15 downto 0);
        reg: out std_logic_vector (2 downto 0);
        flag: out std_logic);
end component;

signal i1 : std_logic_vector(15 downto 0);
signal o1 : std_logic_vector(15 downto 0);
signal o2 : std_logic_vector(2 downto 0);
signal o3: std_logic;
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

function to_string(z: string) return string is
variable ret_val: string(1 to z'length);
alias lz : string (1 to z'length) is z;
begin
ret_val := lz;
return(ret_val);
end to_string;

begin
process
variable err_flag : boolean := false;
File INFILE: text open read_mode is "M_Decoder.txt";
FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";

---------------------------------------------------
-- edit the next two lines to customize
variable input_vector1: bit_vector ( 15 downto 0);
variable output_vector1: bit_vector ( 15 downto 0);
variable output_vector2: bit_vector ( 2 downto 0);
variable output3: bit;
----------------------------------------------------
variable INPUT_LINE: Line;
variable OUTPUT_LINE: Line;
variable LINE_COUNT: integer := 0;

begin

while not endfile(INFILE) loop
LINE_COUNT := LINE_COUNT + 1;

readLine (INFILE, INPUT_LINE);
read (INPUT_LINE, input_vector1);
read (INPUT_LINE, output_vector1);
read (INPUT_LINE, output_vector2);
read (INPUT_LINE, output3);

--------------------------------------
-- from input-vector to DUT inputs
--------------------------------------
i1 <= to_stdlogicvector(input_vector1);

-- let circuit respond.
wait for 5 ns;

--------------------------------------
-- check outputs.
if (o1 /= to_stdlogicvector(output_vector1) or o2 /= to_stdlogicvector(output_vector2)
            or o3 /= to_std_logic(output3)) then
write(OUTPUT_LINE,to_string("ERROR: in c1, line "));
write(OUTPUT_LINE, LINE_COUNT);
writeline(OUTFILE, OUTPUT_LINE);
err_flag := true;
end if;
--------------------------------------
end loop;

assert (err_flag) report "SUCCESS, all tests passed." severity note;
assert (not err_flag) report "FAILURE, some tests failed." severity error;

wait;
end process;

dut: M_Decoder
port map(instr => i1, new_instr => o1, reg => o2, flag => o3);

end Behave;
