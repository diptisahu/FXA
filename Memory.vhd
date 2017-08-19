library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.EE224_Components.all;
use work.mem_package.all;

entity Memory is
    port(Mem_write, Mem_read: in std_logic;
        Mem_ad, Mem_dat: in std_logic_vector (15 downto 0);
        edb: out std_logic_vector(15 downto 0);
        clk,rst: in std_logic);
end entity;

architecture Behave of Memory is
    
    --signal mem_byte: arr := MEM_INIT;
    signal mem_byte: arr := (others => (others => '0'));
    signal ad_of_lsb, ad_of_msb : std_logic_vector (15 downto 0);
begin
    --------------------------------------------------------
   -- mem_byte(0) <= "00110001";
    -- mem_byte(1) <= "00101010";
    --------------------------------------------------------
    ad_of_lsb <= Mem_ad(14 downto 0) & '0';
    ad_of_msb <= Mem_ad(14 downto 0) & '1';

    edb <=  (others => '0') when rst = '1' else
            mem_byte(to_integer(unsigned(ad_of_msb))) &
                        mem_byte(to_integer(unsigned(ad_of_lsb))) when Mem_read = '1' and
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

   -- edb <= "0011000100101010" when Mem_read = '1' else        --LHI
   --         "1111111111111111";
   -- edb <= "0000000001000010" when Mem_read = '1' else
   --         "1111111111111111";                                 --ADD
   -- edb <= "1100010000011011" when Mem_read = '1' else
   --         "1111111111111111";                                 --BEQ
   --edb <= "1000100011110101" when Mem_read = '1' else
   --         "1111111111111111";                                 --JAL
   -- edb <= "1001101101000000" when Mem_read = '1' else
   --         "1111111111111111";                                 --JLR
   --edb <= "0100110011110011" when Mem_read = '1' else
   --         "1111111111111111";                                 --LW
   -- edb <= "0110011000011001" when Mem_read = '1' else
   --         "1111111111111111";                                 --LM
            
    process(clk,Mem_write,rst)
    begin
        if(clk'event and (clk  = '1')) then
            if(rst = '0') then
                if(Mem_write = '1' and (ad_of_msb(0) = '0' or ad_of_msb(0) = '1') and
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
                                (ad_of_lsb(7) = '0' or ad_of_lsb(7) = '1')) then
                    mem_byte(to_integer(unsigned(ad_of_lsb))) <= Mem_dat(7 downto 0);
                    mem_byte(to_integer(unsigned(ad_of_msb))) <= Mem_dat(15 downto 8);
                end if;
            else

            end if;
        end if;


    end process;
end Behave;
