library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;

entity Testbench_CHD is
end entity;
architecture Behave of Testbench_CHD is

component ControlHazardDetector is
  port (
        output_branch_loc: out std_logic_vector(15 downto 0);
        output_branch_now,decode_stall,execute_stall,regread_stall: out std_logic;
        decode_branch_now,regread_branch_now,execute_branch_now,memory_branch_now: in std_logic;
        decode_branch_loc,regread_branch_loc,execute_branch_loc,memory_branch_loc: in std_logic_vector(15 downto 0)
       );
end component;

signal dm,rm,em,mm,om : std_logic_vector(15 downto 0);
signal onow,dnow,rnow,enow,mnow,o,d,e,r: std_logic;


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
File INFILE: text open read_mode is "CHD.txt";
FILE OUTFILE: text  open write_mode is "OUTPUTS_CHD.txt";

---------------------------------------------------
-- edit the next two lines to customize
variable input_vector1: bit_vector ( 15 downto 0);
variable input_vector2: bit_vector ( 15 downto 0);
variable input_vector3: bit_vector ( 15 downto 0);
variable input_vector4: bit_vector ( 15 downto 0);
variable input_op1: bit;
variable input_op2: bit;
variable input_op3: bit;
variable input_op4: bit;
variable output_vector: bit_vector ( 15 downto 0);
variable output_o: bit;
variable output_d: bit;
variable output_r: bit;
variable output_e: bit;
----------------------------------------------------

variable INPUT_LINE: Line;
variable OUTPUT_LINE: Line;
variable LINE_COUNT: integer := 0;

begin

while not endfile(INFILE) loop
LINE_COUNT := LINE_COUNT + 1;

readLine (INFILE, INPUT_LINE);
read (INPUT_LINE, input_vector1);
read (INPUT_LINE, input_vector2);
read (INPUT_LINE, input_vector3);
read (INPUT_LINE, input_vector4);
read (INPUT_LINE, input_op1);
read (INPUT_LINE, input_op2);
read (INPUT_LINE, input_op3);
read (INPUT_LINE, input_op4);
read (INPUT_LINE, output_vector);
read (INPUT_LINE, output_o);
read (INPUT_LINE, output_d);
read (INPUT_LINE, output_r);
read (INPUT_LINE, output_e);



--------------------------------------
-- from input-vector to DUT inputs
--------------------------------------
dm <= to_stdlogicvector(input_vector1);
rm <= to_stdlogicvector(input_vector2);
em <= to_stdlogicvector(input_vector3);
mm <= to_stdlogicvector(input_vector4);
dnow <= to_std_logic(input_op1);
rnow <= to_std_logic(input_op2);
enow <= to_std_logic(input_op3);
mnow <= to_std_logic(input_op4);


-- let circuit respond.
wait for 5 ns;

--------------------------------------
-- check outputs.
if (om /= to_stdlogicvector(output_vector) or o /= to_std_logic(output_o) or d /= to_std_logic(output_d) or r /= to_std_logic(output_r) or e /= to_std_logic(output_e)) then
write(OUTPUT_LINE,to_string("ERROR: in c1, line "));
write(OUTPUT_LINE,to_bitvector(om));
write(OUTPUT_LINE,to_string("  "));
write(OUTPUT_LINE,to_bit(o));
write(OUTPUT_LINE,to_string("  "));
write(OUTPUT_LINE,to_bit(d));
write(OUTPUT_LINE,to_string("  "));
write(OUTPUT_LINE,to_bit(r));
write(OUTPUT_LINE,to_string("  "));
write(OUTPUT_LINE,to_bit(e));
write(OUTPUT_LINE,to_string(" in line "));
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

dut: ControlHazardDetector
port map(output_branch_loc => om,output_branch_now => o,decode_stall => d,regread_stall => r,execute_stall => e,
        decode_branch_now => dnow,regread_branch_now => rnow,execute_branch_now => enow,memory_branch_now => mnow,
        decode_branch_loc => dm,regread_branch_loc => rm,execute_branch_loc => em,memory_branch_loc => mm);

end Behave;
