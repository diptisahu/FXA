library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;

entity Testbench_FlagDecoder is
end entity;
architecture Behave of Testbench_FlagDecoder is
component FlagDecoder is
        port(instr: in std_logic_vector(15 downto 0);
            o_z, o_c, stall,in_z, in_c: in std_logic;
            n_z,n_c,condition: out std_logic);
end component;

signal i1 : std_logic_vector(15 downto 0);
signal i2,i3,i4,i5,i6 : std_logic;
signal o1,o2,o3 : std_logic;

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
File INFILE: text open read_mode is "FlagDecoder.txt";
FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";

---------------------------------------------------
-- edit the next two lines to customize
variable in1 : bit_vector(15 downto 0);
variable in2,in3,in4,in5,in6 : bit;
variable out1,out2,out3 : bit;
----------------------------------------------------
variable INPUT_LINE: Line;
variable OUTPUT_LINE: Line;
variable LINE_COUNT: integer := 0;

begin

while not endfile(INFILE) loop
LINE_COUNT := LINE_COUNT + 1;

readLine (INFILE, INPUT_LINE);
read (INPUT_LINE, in1);
read (INPUT_LINE, in2);
read (INPUT_LINE, in3);
read (INPUT_LINE, in4);
read (INPUT_LINE, in5);
read (INPUT_LINE, in6);
read (INPUT_LINE, out1);
read (INPUT_LINE, out2);
read (INPUT_LINE, out3);


--------------------------------------
-- from input-vector to DUT inputs
--------------------------------------
i1 <= to_stdlogicvector(in1);
i2 <= to_std_logic(in2);
i3 <= to_std_logic(in3);
i4 <= to_std_logic(in4);
i5 <= to_std_logic(in5);
i6 <= to_std_logic(in6);

-- let circuit respond.
wait for 5 ns;

--------------------------------------
-- check outputs.
if (o1 /= to_std_logic(out1) or o2 /= to_std_logic(out2) or o3 /= to_std_logic(out3)) then
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

dut: FlagDecoder
port map(i1,i2,i3,i4,i5,i6,o1,o2,o3);

end Behave;
