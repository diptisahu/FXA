library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;

entity DHD is
  port( ex_rfw, ex_stall, mem_rfw, mem_stall, wb_rfw, wb_stall: in std_logic;
	rr_rs1, rr_rs2, ex_rd, mem_rd, wb_rd: in std_logic_vector(2 downto 0);
	rr_data1, rr_data2, ex_data, mem_data, wb_data: in std_logic_vector(15 downto 0);
	data1_out, data2_out: out std_logic_vector(15 downto 0)	      
);
end entity;

architecture Struct of DHD is

begin
	process(ex_rfw, ex_stall, mem_rfw, mem_stall, wb_rfw, wb_stall, ex_rd, mem_rd, wb_rd, rr_rs1, rr_rs2, 
		rr_data1, rr_data2, ex_data, mem_data, wb_data)
		variable ex_pot, mem_pot, wb_pot: std_logic;
		variable rr_rs1_a, rr_rs2_a, ex_rd_a, mem_rd_a, wb_rd_a: std_logic_vector(2 downto 0);
		variable rr_data1_a, rr_data2_a, ex_data_a, mem_data_a, wb_data_a: std_logic_vector(15 downto 0);
		variable data1_out_a, data2_out_a: std_logic_vector(15 downto 0);
		variable flag: std_logic;
		begin
		flag := '1';
		ex_pot := ex_rfw and (not ex_stall) ;
		mem_pot := mem_rfw and (not mem_stall) ;
		wb_pot := wb_rfw and (not wb_stall) ;
		ex_rd_a := ex_rd ;
		mem_rd_a := mem_rd ;
		wb_rd_a := wb_rd ;
		rr_rs1_a := rr_rs1 ;
		rr_rs2_a := rr_rs2 ;
		rr_data1_a := rr_data1 ;
		rr_data2_a := rr_data2 ;
		ex_data_a := ex_data ;
		mem_data_a := mem_data ;
		wb_data_a := wb_data ;
        data1_out_a := (others => '0');
        data2_out_a := (others => '0');
		if (ex_pot = '1') then
		    if (ex_rd_a = rr_rs1_a) then
			data1_out_a := ex_data_a;
			--report "execute";
			flag := '0';
		    end if;
		end if;
		if (mem_pot = '1' and flag = '1') then
		    if (mem_rd_a = rr_rs1_a) then
			data1_out_a := mem_data_a;
			--report "Mota";
			flag := '0';
		    end if;
		end if;
		if (wb_pot = '1' and flag = '1') then
		    if (wb_rd_a = rr_rs1_a) then
			data1_out_a := wb_data_a;
			--report "Mota2much";
			flag := '0';
		    end if;
		end if;
		if (flag = '1') then
		    --report "3";
		    data1_out_a := rr_data1_a;
		end if;
		flag := '1';


		if (ex_pot = '1') then
		    if (ex_rd_a = rr_rs2_a) then
			data2_out_a := ex_data_a;
			flag := '0';
		    end if;
		end if;
		if (mem_pot = '1' and flag = '1') then
		    if (mem_rd_a = rr_rs2_a) then
			data2_out_a := mem_data_a;
			flag := '0';
		    end if;
		end if;
		if (wb_pot = '1' and flag = '1') then
		    if (wb_rd_a = rr_rs2_a) then
			data2_out_a := wb_data_a;
			flag := '0';
		    end if;
		end if;
		if (flag = '1') then
		    data2_out_a := rr_data2_a;
		end if;		
	data1_out <= data1_out_a;
	data2_out <= data2_out_a;
	end process;
	
end Struct;
