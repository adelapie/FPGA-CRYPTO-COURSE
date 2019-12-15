----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:45:28 03/02/2015 
-- Design Name: 
-- Module Name:    reg_128 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_128 is
	port(clk : in std_logic;
	     rst : in std_logic;
		  data_in_0 : in std_logic_vector(31 downto 0);
		  data_in_1 : in std_logic_vector(31 downto 0);
		  data_in_2 : in std_logic_vector(31 downto 0);
		  data_in_3 : in std_logic_vector(31 downto 0);
		  data_out_0 : out std_logic_vector(31 downto 0);
		  data_out_1 : out std_logic_vector(31 downto 0);
		  data_out_2 : out std_logic_vector(31 downto 0);
		  data_out_3 : out std_logic_vector(31 downto 0));		  
end reg_128;

architecture Behavioral of reg_128 is
	signal reg_32_0_s : std_logic_vector(31 downto 0);
	signal reg_32_1_s : std_logic_vector(31 downto 0);
	signal reg_32_2_s : std_logic_vector(31 downto 0);
	signal reg_32_3_s : std_logic_vector(31 downto 0);
begin

	pr_reg: process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				reg_32_0_s <= (others => '0');
				reg_32_1_s <= (others => '0');
				reg_32_2_s <= (others => '0');
				reg_32_3_s <= (others => '0');
			else
				reg_32_0_s <= data_in_0;
				reg_32_1_s <= data_in_1;
				reg_32_2_s <= data_in_2;
				reg_32_3_s <= data_in_3;
			end if;
		end if;
	end process;

	data_out_0 <= reg_32_0_s;
	data_out_1 <= reg_32_1_s;
	data_out_2 <= reg_32_2_s;
	data_out_3 <= reg_32_3_s;

end Behavioral;

