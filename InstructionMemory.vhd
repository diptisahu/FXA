library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.EE224_Components.all;
use work.mem_package.all;

entity InstructionMemory is
    port(
        Mem_ad: in std_logic_vector (15 downto 0);
        edb: out std_logic_vector(15 downto 0);
        clk,rst: in std_logic);
end entity;

architecture Behave of InstructionMemory is
    
    signal mem_byte: arr := MEM_INIT;
    signal ad_of_lsb, ad_of_msb : std_logic_vector (15 downto 0);
begin
    ad_of_lsb <= Mem_ad(14 downto 0) & '0';
    ad_of_msb <= Mem_ad(14 downto 0) & '1';

    edb <=  (others => '0') when rst = '1' else
            mem_byte(to_integer(unsigned(ad_of_msb))) &
                        mem_byte(to_integer(unsigned(ad_of_lsb))) when
                            (ad_of_msb(0) = '0' or ad_of_msb(0) = '1') and
                            (ad_of_msb(1) = '0' or ad_of_msb(1) = '1') and
                            (ad_of_msb(2) = '0' or ad_of_msb(2) = '1') and
                            (ad_of_msb(3) = '0' or ad_of_msb(3) = '1') and
                            (ad_of_msb(4) = '0' or ad_of_msb(4) = '1') and
                            (ad_of_msb(5) = '0' or ad_of_msb(5) = '1') and
                            (ad_of_msb(6) = '0' or ad_of_msb(6) = '1') and
                            (ad_of_msb(7) = '0' or ad_of_msb(7) = '1') and
                            (ad_of_lsb(0) = '0' or ad_of_lsb(0) = '1') and
                            (ad_of_lsb(1) = '0' or ad_of_lsb(1) = '1') and
                            (ad_of_lsb(2) = '0' or ad_of_lsb(2) = '1') and
                            (ad_of_lsb(3) = '0' or ad_of_lsb(3) = '1') and
                            (ad_of_lsb(4) = '0' or ad_of_lsb(4) = '1') and
                            (ad_of_lsb(5) = '0' or ad_of_lsb(5) = '1') and
                            (ad_of_lsb(6) = '0' or ad_of_lsb(6) = '1') and
                            (ad_of_lsb(7) = '0' or ad_of_lsb(7) = '1')
                            else "1111111111111111";
end Behave;
