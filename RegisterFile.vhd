library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity RF is
    port(RF_write, PC_write: in std_logic;
        A1,A2,A3: in std_logic_vector (2 downto 0);
        D3,PC_in: in std_logic_vector(15 downto 0);
        D1,D2,PC_out: out std_logic_vector(15 downto 0);
        R0,R1,R2,R3,R4,R5,R6,R7: out std_logic_vector(15 downto 0);
        rst, clk: in std_logic);
end entity;

architecture Struct of RF is
    signal R_out, R_in: arr1(7 downto 0);
    signal R_enable : std_logic_vector (7 downto 0);

begin
    R0 <= R_out(0);
    R1 <= R_out(1);
    R2 <= R_out(2);
    R3 <= R_out(3);
    R4 <= R_out(4);
    R5 <= R_out(5);
    R6 <= R_out(6);
    R7 <= R_out(7);
    --Read related logic
    D1 <= R_out(0) when A1 = "000" else
        R_out(1) when A1 = "001" else
        R_out(2) when A1 = "010" else
        R_out(3) when A1 = "011" else
        R_out(4) when A1 = "100" else
        R_out(5) when A1 = "101" else
        R_out(6) when A1 = "110" else
        R_out(7) when A1 = "111" else
        R_out(0);

    D2 <= R_out(0) when A2 = "000" else
        R_out(1) when A2 = "001" else
        R_out(2) when A2 = "010" else
        R_out(3) when A2 = "011" else
        R_out(4) when A2 = "100" else
        R_out(5) when A2 = "101" else
        R_out(6) when A2 = "110" else
        R_out(7) when A2 = "111" else
        R_out(0);


    --Write related logic
    ----------------------
    --R0 related logic
    ----------------------
    R_in(0) <= (others => '0') when rst = '1' else D3;
    R_enable(0) <= (RF_write and ( not(A3(2)) and not(A3(1)) and not(A3(0)) )) or rst;
    Reg0: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R_in(0), Dout => R_out(0),
				Enable => R_enable(0), clk => clk);

     ----------------------
    --R1 related logic
    ----------------------
    R_in(1) <= "0000000000000000" when rst = '1' else D3;
    R_enable(1) <= (RF_write and ( not(A3(2)) and not(A3(1)) and A3(0) )) or rst;
    Reg1: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R_in(1), Dout => R_out(1),
				Enable => R_enable(1), clk => clk);


    ----------------------
    --R2 related logic
    ----------------------
    R_in(2) <= "0000000000000000"  when rst = '1' else D3;
    R_enable(2) <= (RF_write and ( not(A3(2)) and A3(1) and not(A3(0)) )) or rst;
    Reg2: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R_in(2), Dout => R_out(2),
				Enable => R_enable(2), clk => clk);

    ----------------------
    --R3 related logic
    ----------------------
    R_in(3) <= "0000000000000000" when rst = '1' else D3;
    R_enable(3) <= (RF_write and ( not(A3(2)) and A3(1) and A3(0) )) or rst;
    Reg3: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R_in(3), Dout => R_out(3),
				Enable => R_enable(3), clk => clk);

    ----------------------
    --R4 related logic
    ----------------------
    R_in(4) <= "0000000000000000" when rst = '1' else D3;
    R_enable(4) <= (RF_write and ( A3(2) and not(A3(1)) and not(A3(0)) )) or rst;
    Reg4: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R_in(4), Dout => R_out(4),
				Enable => R_enable(4), clk => clk);

    ----------------------
    --R5 related logic
    ----------------------
    R_in(5) <= "0000000000000000" when rst = '1' else D3;
    R_enable(5) <= (RF_write and ( A3(2) and not(A3(1)) and A3(0) )) or rst;
    Reg5: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R_in(5), Dout => R_out(5),
				Enable => R_enable(5), clk => clk);

    ----------------------
    --R6 related logic
    ----------------------
    R_in(6) <= "0000000000000000" when rst = '1' else D3;
    R_enable(6) <= (RF_write and ( A3(2) and A3(1) and not(A3(0)) )) or rst;
    Reg6: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R_in(6), Dout => R_out(6),
				Enable => R_enable(6), clk => clk);

    ----------------------
    --R7 related logic
    ----------------------
    R_in(7) <= (others => '0') when rst = '1' else PC_in when PC_write = '1' else D3;
    R_enable(7) <= (PC_write or (  RF_write and ( A3(2) and A3(1) and A3(0))  )) or rst;
    Reg7: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => R_in(7), Dout => R_out(7),
				Enable => R_enable(7), clk => clk);

     ----------------------
    --PC related logic
    ----------------------
    PC_out <= R_out(7);


end Struct;
