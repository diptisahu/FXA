--Two bit input XOR gate
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity XORTwo is
	port(a,b: in std_logic;
		c: out std_logic);
end entity;

architecture Struct of XORTwo is
	signal na, nb, t1, t2: std_logic;
begin
	n1: INVERTER port map (a => a, b=> na);
	n2: INVERTER port map (a => b, b=> nb);
	
	a1: ANDTwo port map (a => a, b => nb, c => t1);
	a2: ANDTwo port map (a => na, b => b, c => t2);

	o1: ORTwo port map (a => t1, b => t2, c => c);

end Struct;

--------------------------------------------------------------------------
-- Two bit input full adder
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity FullAdder is
	port(x,y,ci: in std_logic;
		s, co: out std_logic);
end entity;

architecture Struct of FullAdder is
	signal s1, c1, c2 : std_logic;
begin
	x1: XORTwo port map (a => x, b => y, c => s1);
	x2: XORTwo port map (a => s1, b => ci, c => s);

	a1: ANDTwo port map (a => x, b => y, c => c1);
	a2: ANDTwo port map (a => ci, b => s1, c => c2);

	o1: ORTwo port map (a => c1, b => c2, c => co);
end Struct;

-------------------------------------------------------------------------------
--Two's Complement of a sixteen bit vector
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity TwosComplementSixteen is
port (x: in std_logic_vector (15 downto 0);
t: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of TwosComplementSixteen is
signal i: std_logic_vector (15 downto 0);
signal o: std_logic_vector (15 downto 0) := "0000000000000001";
signal c: std_logic;
begin
n0: INVERTER port map (a => x(0), b => i(0));
n1: INVERTER port map (a => x(1), b => i(1));
n2: INVERTER port map (a => x(2), b => i(2));
n3: INVERTER port map (a => x(3), b => i(3));
n4: INVERTER port map (a => x(4), b => i(4));
n5: INVERTER port map (a => x(5), b => i(5));
n6: INVERTER port map (a => x(6), b => i(6));
n7: INVERTER port map (a => x(7), b => i(7));
n8: INVERTER port map (a => x(8), b => i(8));
n9: INVERTER port map (a => x(9), b => i(9));
n10: INVERTER port map (a => x(10), b => i(10));
n11: INVERTER port map (a => x(11), b => i(11));
n12: INVERTER port map (a => x(12), b => i(12));
n13: INVERTER port map (a => x(13), b => i(13));
n14: INVERTER port map (a => x(14), b => i(14));
n15: INVERTER port map (a => x(15), b => i(15));

f0: SixteenBitAdder port map (x => i, y => o, s => t, c_out => c);
end Struct;

----------------------------------------------------------------------------
-- 2:1 Multiplexer
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity Multiplexer is
	port(a, b, s: in std_logic; c: out std_logic);
end entity;

architecture Struct of Multiplexer is
	signal t1, t2, t3: std_logic;
begin
	i1: INVERTER port map (a => s, b => t1);
	
	a1: ANDTwo port map (a => t1, b => a, c => t2);
	a2: ANDTwo port map (a => s, b => b, c => t3);

	o1: ORTwo port map (a => t2, b => t3, c => c);
end Struct;

-----------------------------------------------------------------------------
--4:1 Multiplexer
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity FourOneMux is
	port (a, b, c, d: in std_logic; s: in std_logic_vector (1 downto 0);
		o: out std_logic);
end entity;

architecture Struct of FourOneMux is
	signal t1, t2: std_logic;
begin
	m1: Multiplexer port map (a => a, b => b, s => s(0), c => t1);
	m2: Multiplexer port map (a => d, b => c, s => s(0), c => t2);

	m3: Multiplexer port map (a => t1, b => t2, s => s(1), c => o);
end Struct;

----------------------------------------------------------------------------
-- 2:1 Multiplexer for 16 bit Vector
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity MuxTwo is
	port(i0, i1: in std_logic_vector (15 downto 0);
        s: in std_logic;
        o: out std_logic_vector(15 downto 0));
end entity;

architecture Struct of MuxTwo is
begin
	o <= i0 when s = '0' else
        i1 when s = '1' else
        i0;
end Struct;

-----------------------------------------------------------------------------
--4:1 Multiplexer for 16 bit Vector
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity MuxFour is
	port (i00, i01, i10, i11: in std_logic_vector(15 downto 0);
        s: in std_logic_vector (1 downto 0);
		o: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of MuxFour is
begin
	o <= i00 when s = "00" else
        i01 when s = "01" else
        i10 when s = "10" else
        i11 when s = "11" else
        i00;

end Struct;

-----------------------------------------------------------------------------
--8:1 Multiplexer for 16 bit Vector
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity MuxEight is
	port (i000, i001, i010, i011, i100, i101, i110, i111: in std_logic_vector(15 downto 0);
        s: in std_logic_vector (2 downto 0);
		o: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of MuxEight is
begin
	o <= i000 when s = "000" else
        i001 when s = "001" else
        i010 when s = "010" else
        i011 when s = "011" else
        i100 when s = "100" else
        i101 when s = "101" else
        i110 when s = "110" else
        i111 when s = "111" else
        i000;

end Struct;


-----------------------------------------------------------------------------
--Two input NAND gate
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity NANDTwo is
    port (a, b: in std_logic;
        c: out std_logic);
end entity;

architecture Struct of NANDTwo is
    signal t1: std_logic;
begin
    a1: ANDTwo port map(a => a, b => b, c => t1);
    n1: INVERTER port map (a => t1, b => c);
end Struct;

----------------------------------------------------------------------------
--DataRegister
library ieee;
use ieee.std_logic_1164.all;

entity DataRegister is
    generic (data_width:integer);
    port (Din: in std_logic_vector(data_width-1 downto 0);
        Dout: out std_logic_vector(data_width-1 downto 0);
        clk, enable: in std_logic);
end entity;

architecture Behave of DataRegister is
begin
    process(clk)
    begin
        if(clk'event and (clk  = '1')) then
            if(enable = '1') then
                Dout <= Din;
            end if;
        end if;
    end process;
end Behave;
-----------------------------------------------------------------------------
--RF_outMUX
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity out_Mux is
    port(r0, r1, r2, r3, r4, r5, r6, r7: in std_logic_vector(15 downto 0);
        a: in std_logic_vector(2 downto 0);
        o: out std_logic_vector(15 downto 0));
end entity;
architecture Behave of out_Mux is
begin
    process(a,r0,r1,r2,r3,r4,r5,r6,r7)
    begin
        if(a = "000") then o <= r0;
        elsif(a = "001") then o <= r1;
        elsif(a = "010") then o <= r2;
        elsif(a = "011") then o <= r3;
        elsif(a = "100") then o <= r4;
        elsif(a = "101") then o <= r5;
        elsif(a = "110") then o <= r6;
        elsif(a = "111") then o <= r7;
        else o <= "XXXXXXXXXXXXXXXX";
        end if;
    end process;
end Behave;

-------------------------------------------------------------------------------
--Priority Decoder

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity PriorityDecoder is
    port(x: in std_logic_vector (7 downto 0);
        s: in std_logic_vector(2 downto 0);
        y: out std_logic_vector(7 downto 0));
end entity;

architecture Behave of PriorityDecoder is
begin
    y(0) <= x(0) and (not(not s(2) and not s(1) and not s(0)));
    y(1) <= x(1) and (not(not s(2) and not s(1) and s(0)));
    y(2) <= x(2) and (not(not s(2) and s(1) and not s(0)));
    y(3) <= x(3) and (not(not s(2) and s(1) and s(0)));
    y(4) <= x(4) and (not( s(2) and not s(1) and not s(0)));
    y(5) <= x(5) and (not( s(2) and not s(1) and s(0)));
    y(6) <= x(6) and (not( s(2) and s(1) and not s(0)));
    y(7) <= x(7) and (not( s(2) and s(1) and s(0)));
end Behave;

-------------------------------------------------------------------------------
--Comparator
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity Comparator is
    port(x,y: in std_logic_vector (15 downto 0);
    z_out: out std_logic);
end entity;

architecture Behave of Comparator is

begin
    z_out <= '1' when x = y else
            '0';
end Behave;
-------------------------------------------------------------------------------
--Zero Comparator
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity ZeroComparator is
    port(x: in std_logic_vector (15 downto 0);
    z_out: out std_logic);
end entity;

architecture Behave of ZeroComparator is

begin
    z_out <= '1' when x = "0000000000000000" else
            '0';
end Behave;

-------------------------------------------------------------------------------
--Six Bit Sign Extender
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity SixBitSignExtender is
    port(x: in std_logic_vector (5 downto 0);
        y: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of SixBitSignExtender is
    signal m: std_logic;
begin
    m <= x(5);
    y(5 downto 0) <= x(5 downto 0);
    y(6) <= m;
    y(7) <= m;
    y(8) <= m;
    y(9) <= m;
    y(10) <= m;
    y(11) <= m;
    y(12) <= m;
    y(13) <= m;
    y(14) <= m;
    y(15) <= m;
end Struct;

-------------------------------------------------------------------------------
--Nine Bit Sign Extender
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity NineBitSignExtender is
    port(x: in std_logic_vector (8 downto 0);
        y: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of NineBitSignExtender is
signal m: std_logic;
begin
m <= x(8);
y(8 downto 0) <= x(8 downto 0);
y(9) <= m;
y(10) <= m;
y(11) <= m;
y(12) <= m;
y(13) <= m;
y(14) <= m;
y(15) <= m;
end Struct;

-------------------------------------------------------------------------------
--Pad Nine
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity PadNine is
    port(x: in std_logic_vector (8 downto 0);
        y: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of PadNine is
begin
y <= x & "0000000";
end Struct;

-------------------------------------------------------------------------------
--Priority Encoder
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity PriorityEncoder is
    port(x: in std_logic_vector (7 downto 0);
        s: out std_logic_vector(2 downto 0);
        N: out std_logic;
        tnew: out std_logic_vector (7 downto 0));
end entity;

architecture Struct of PriorityEncoder is
    signal tmp: std_logic_vector (2 downto 0);
begin
    N <= not(x(7) or x(6) or x(5) or x(4) or x(3) or x(2) or x(1) or x(0));

    tmp(0) <= (x(1) and not x(0)) or
            (x(3) and not x(2) and not x(1) and not x(0)) or (x(5) and not x(4) and not x(3) and not x(2) and
            not x(1) and not x(0)) or (x(7) and not x(6) and not x(5) and not x(4) and not x(3) and not
            x(2) and not x(1));

    tmp(1) <= (x(2) and not x(1) and not x(0)) or (x(3) and not x(2) and not x(1) and not x(0)) or
            (x(6) and not x(5) and not x(4) and not x(3) and not x(2) and not x(1) and not x(0)) or
            (x(7) and not x(6) and not x(5) and not x(4) and not x(3) and not x(2) and not x(1) and not x(0));

    tmp(2) <= (x(4) and not x(3) and not x(2) and not x(1) and not x(0)) or
            (x(5) and not x(4) and not x(3) and not x(2) and not x(1) and not x(0)) or
            (x(6) and not x(5) and not x(4) and not x(3) and not x(2) and not x(1) and not x(0)) or
            (x(7) and not x(6) and not x(5) and not x(4) and not x(3) and not x(2) and not x(1) and not x(0));

    s <= tmp;
    pe: PriorityDecoder port map (x => x, s => tmp, y => tnew);

end Struct;

-------------------------------------------------------------------------------
--Sixteen Bit Adder
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity SixteenBitAdder is
    port(x,y: in std_logic_vector (15 downto 0);
    s: out std_logic_vector(15 downto 0);
    c_out: out std_logic);
end entity;

architecture Struct of SixteenBitAdder is
    signal m: std_logic := '0';
    signal c: std_logic_vector (14 downto 0);
begin
    f0: FullAdder port map (x => x(0), y => y(0), ci => m, s => s(0), co => c(0));
    f1: FullAdder port map (x => x(1), y => y(1), ci => c(0), s => s(1), co => c(1));
    f2: FullAdder port map (x => x(2), y => y(2), ci => c(1), s => s(2), co => c(2));
    f3: FullAdder port map (x => x(3), y => y(3), ci => c(2), s => s(3), co => c(3));
    f4: FullAdder port map (x => x(4), y => y(4), ci => c(3), s => s(4), co => c(4));
    f5: FullAdder port map (x => x(5), y => y(5), ci => c(4), s => s(5), co => c(5));
    f6: FullAdder port map (x => x(6), y => y(6), ci => c(5), s => s(6), co => c(6));
    f7: FullAdder port map (x => x(7), y => y(7), ci => c(6), s => s(7), co => c(7));
    f8: FullAdder port map (x => x(8), y => y(8), ci => c(7), s => s(8), co => c(8));
    f9: FullAdder port map (x => x(9), y => y(9), ci => c(8), s => s(9), co => c(9));
    f10: FullAdder port map (x => x(10), y => y(10), ci => c(9), s => s(10), co => c(10));
    f11: FullAdder port map (x => x(11), y => y(11), ci => c(10), s => s(11), co => c(11));
    f12: FullAdder port map (x => x(12), y => y(12), ci => c(11), s => s(12), co => c(12));
    f13: FullAdder port map (x => x(13), y => y(13), ci => c(12), s => s(13), co => c(13));
    f14: FullAdder port map (x => x(14), y => y(14), ci => c(13), s => s(14), co => c(14));
    f15: FullAdder port map (x => x(15), y => y(15), ci => c(14), s => s(15), co => c_out);
end Struct;

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity SixteenBitNand is
    port(x,y: in std_logic_vector (15 downto 0);
    s: out std_logic_vector(15 downto 0));
end entity;

-------------------------------------------------------------------------------
--Sixteen Bit Nand
architecture Struct of SixteenBitNand is
begin
    nn0: NANDTwo port map (a => x(0), b => y(0), c => s(0));
    nn1: NANDTwo port map (a => x(1), b => y(1), c => s(1));
    nn2: NANDTwo port map (a => x(2), b => y(2), c => s(2));
    nn3: NANDTwo port map (a => x(3), b => y(3), c => s(3));
    nn4: NANDTwo port map (a => x(4), b => y(4), c => s(4));
    nn5: NANDTwo port map (a => x(5), b => y(5), c => s(5));
    nn6: NANDTwo port map (a => x(6), b => y(6), c => s(6));
    nn7: NANDTwo port map (a => x(7), b => y(7), c => s(7));
    nn8: NANDTwo port map (a => x(8), b => y(8), c => s(8));
    nn9: NANDTwo port map (a => x(9), b => y(9), c => s(9));
    nn10: NANDTwo port map (a => x(10), b => y(10), c => s(10));
    nn11: NANDTwo port map (a => x(11), b => y(11), c => s(11));
    nn12: NANDTwo port map (a => x(12), b => y(12), c => s(12));
    nn13: NANDTwo port map (a => x(13), b => y(13), c => s(13));
    nn14: NANDTwo port map (a => x(14), b => y(14), c => s(14));
    nn15: NANDTwo port map (a => x(15), b => y(15), c => s(15));
end Struct;

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

-------------------------------------------------------------------------------
--Sixteen Bit Subtractor
entity SixteenBitSubtractor is
    port(x,y: in std_logic_vector (15 downto 0);
        s: out std_logic_vector(15 downto 0);
        b: out std_logic);
end entity;

architecture Struct of SixteenBitSubtractor is
    signal t: std_logic_vector (15 downto 0);
begin
t0: TwosComplementSixteen port map (x => y, t => t);

e1: SixteenBitAdder port map (x => x, y => t, s => s, c_out => b);
end Struct;
-------------------------------------------------------------------------------
--RFW Decoder
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity RFW_Decoder is
    port(instr: in std_logic_vector(15 downto 0);
        in_rfw ,condition: in std_logic;
        out_rfw: out std_logic);
end entity;

architecture Behave of RFW_Decoder is
begin
    process(instr, in_rfw, condition)
        variable x_out_rfw: std_logic;
    begin
        if(instr(15 downto 12) /= "0000" and instr(15 downto 12) /= "0010") then
            x_out_rfw := in_rfw;
        else
            x_out_rfw := in_rfw and condition;
        end if;
        out_rfw <= x_out_rfw;
    end process;

end Behave;



