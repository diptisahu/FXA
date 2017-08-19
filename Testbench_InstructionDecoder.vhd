library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;

entity Testbench_InstructionDecoder is
end entity;
architecture Behave of Testbench_InstructionDecoder is
component InstructionDecoder is
    port(instr: in std_logic_vector(15 downto 0);
        m_dec_reg: in std_logic_vector(2 downto 0);
        rs1,rs2,rd: out std_logic_vector(2 downto 0);
        branch, decode_br_loc, regread_br_loc: out std_logic;
        branch_state: out std_logic_vector (1 downto 0);
        mem_read, mem_write, rf_write: out std_logic);
end component;

signal i1 : std_logic_vector(15 downto 0);
signal i2 : std_logic_vector(2 downto 0);
signal o1,o2,o3 : std_logic_vector(2 downto 0);
signal o4,o5,o6 : std_logic;
signal o7: std_logic_vector(1 downto 0);
signal o8,o9,o10: std_logic;
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
File INFILE: text open read_mode is "InstructionDecoder.txt";
FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";

---------------------------------------------------
-- edit the next two lines to customize
variable in1 : bit_vector(15 downto 0);
variable in2 : bit_vector(2 downto 0);
variable out1,out2,out3 : bit_vector(2 downto 0);
variable out4,out5,out6 : bit;
variable out7: bit_vector(1 downto 0);
variable out8,out9,out10: bit;
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
read (INPUT_LINE, out1);
read (INPUT_LINE, out2);
read (INPUT_LINE, out3);
read (INPUT_LINE, out4);
read (INPUT_LINE, out5);
read (INPUT_LINE, out6);
read (INPUT_LINE, out7);
read (INPUT_LINE, out8);
read (INPUT_LINE, out9);
read (INPUT_LINE, out10);

--------------------------------------
-- from input-vector to DUT inputs
--------------------------------------
i1 <= to_stdlogicvector(in1);
i2 <= to_stdlogicvector(in2);

-- let circuit respond.
wait for 5 ns;

--------------------------------------
-- check outputs.
if (o1 /= to_stdlogicvector(out1) or o2 /= to_stdlogicvector(out2) or
    o3 /= to_stdlogicvector(out3) or o7 /= to_stdlogicvector(out7) or
    o4 /= to_std_logic(out4) or o5 /= to_std_logic(out5) or
    o6 /= to_std_logic(out6) or o8 /= to_std_logic(out8) or
    o9 /= to_std_logic(out9) or o10 /= to_std_logic(out10)) then
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

dut: InstructionDecoder
port map(i1,i2,o1,o2,o3,o4,o5,o6,o7,o8,o9,o10);

end Behave;
