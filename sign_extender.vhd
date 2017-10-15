--Six Bit Sign Extender
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;

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
use work.Microprocessor_project.all;

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
use work.Microprocessor_project.all;

entity PadNine is
    port(x: in std_logic_vector (8 downto 0);
        y: out std_logic_vector (15 downto 0));
end entity;

architecture Struct of PadNine is
begin
y <= x & "0000000";
end Struct;
