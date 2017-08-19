library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;

entity Testbench_DHD is
end entity;
architecture Behave of Testbench_DHD is
component DHD is
    port(ex_rfw, ex_stall, mem_rfw, mem_stall, wb_rfw, wb_stall: in std_logic;
	rr_rs1, rr_rs2, ex_rd, mem_rd, wb_rd: in std_logic_vector(2 downto 0);
	rr_data1, rr_data2, ex_data, mem_data, wb_data: in std_logic_vector(15 downto 0);
	data1_out, data2_out: out std_logic_vector(15 downto 0)	);
end component;

signal ex1,ex2,mem1,mem2,wb1,wb2 : std_logic;
signal exrd, memrd, wbrd, rrrs1, rrrs2 : std_logic_vector(2 downto 0);
signal exdata, wbdata, memdata, rrdata1, rrdata2 : std_logic_vector(15 downto 0);
signal out1, out2 : std_logic_vector(15 downto 0);



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


function to_bit_vector(x: std_logic_vector) return bit_vector is
    alias lx: std_logic_vector(1 to x'length) is x;
    variable ret_var : bit_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
           ret_var(I) :=  '1';
        else 
           ret_var(I) :=  '0';
	end if;
     end loop;
     return(ret_var);
  end to_bit_vector;



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
File INFILE: text open read_mode is "DHD.txt";
FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";

---------------------------------------------------
-- edit the next two lines to customize
variable v_ex1,v_ex2,v_mem1,v_mem2,v_wb1,v_wb2 : bit;
variable v_exrd, v_memrd, v_wbrd, v_rrrs1, v_rrrs2 : bit_vector(2 downto 0);
variable v_exdata, v_wbdata, v_memdata, v_rrdata1, v_rrdata2 : bit_vector(15 downto 0);
variable v_out1, v_out2 : bit_vector(15 downto 0);
----------------------------------------------------
variable INPUT_LINE: Line;
variable OUTPUT_LINE: Line;
variable LINE_COUNT: integer := 0;

begin

while not endfile(INFILE) loop
LINE_COUNT := LINE_COUNT + 1;

readLine (INFILE, INPUT_LINE);
read (INPUT_LINE, v_ex1);
read (INPUT_LINE, v_ex2);
read (INPUT_LINE, v_mem1);
read (INPUT_LINE, v_mem2);
read (INPUT_LINE, v_wb1);
read (INPUT_LINE, v_wb2);
read (INPUT_LINE, v_exrd);
read (INPUT_LINE, v_memrd);
read (INPUT_LINE, v_wbrd);
read (INPUT_LINE, v_rrrs1);
read (INPUT_LINE, v_rrrs2);
read (INPUT_LINE, v_exdata);
read (INPUT_LINE, v_memdata);
read (INPUT_LINE, v_wbdata);
read (INPUT_LINE, v_rrdata1);
read (INPUT_LINE, v_rrdata2);
read (INPUT_LINE, v_out1);
read (INPUT_LINE, v_out2);

--read (INPUT_LINE, v_od1);
--read (INPUT_LINE, v_od2);
--read (INPUT_LINE, v_opco);

--------------------------------------
-- from input-vector to DUT inputs
--------------------------------------
ex1 <= to_std_logic(v_ex1);
ex2 <= to_std_logic(v_ex2);
mem1 <= to_std_logic(v_mem1); 
mem2 <= to_std_logic(v_mem2); 
wb1 <= to_std_logic(v_wb1);
wb2 <= to_std_logic(v_wb2);
exrd <= to_stdlogicvector(v_exrd);
memrd <= to_stdlogicvector(v_memrd);
wbrd <= to_stdlogicvector(v_wbrd);
rrrs1 <= to_stdlogicvector(v_rrrs1);
rrrs2 <= to_stdlogicvector(v_rrrs2);
exdata <= to_stdlogicvector(v_exdata);
wbdata <= to_stdlogicvector(v_wbdata);
memdata <= to_stdlogicvector(v_memdata);
rrdata1 <= to_stdlogicvector(v_rrdata1);
rrdata2 <= to_stdlogicvector(v_rrdata2);


wait for 1 ns;
write(OUTPUT_LINE, to_bit_vector(out1));
write(OUTPUT_LINE, to_bit_vector(out2));
writeline(OUTFILE, OUTPUT_LINE);
if (v_out1 /= to_bit_vector(out1) or v_out2 /= to_bit_vector(out2)) then
 err_flag := true;
end if;
end loop;

assert (err_flag) report "SUCCESS, all tests passed." severity note;
assert (not err_flag) report "FAILURE, some tests failed." severity error;

wait;
end process;

dut: DHD
port map (ex_rfw => ex1, ex_stall => ex2, mem_rfw => mem1, mem_stall => mem2, wb_rfw => wb1, wb_stall => wb2,
	rr_rs1 => rrrs1, rr_rs2 => rrrs2, ex_rd => exrd, mem_rd => memrd, wb_rd => wbrd,
	rr_data1 => rrdata1, rr_data2 => rrdata2, ex_data => exdata, mem_data => memdata, wb_data => wbdata,
	data1_out => out1, data2_out => out2);

end Behave;
