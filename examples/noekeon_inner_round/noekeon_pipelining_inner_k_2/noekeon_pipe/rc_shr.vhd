----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:26:46 02/24/2015 
-- Design Name: 
-- Module Name:    rc_shr - Behavioral 
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

entity rc_shr is
	port(clk : in std_logic;
		  rst : in std_logic;
		  rc_in : in std_logic_vector(407 downto 0);
		  rc_out : out std_logic_vector(7 downto 0));
end rc_shr;

architecture Behavioral of rc_shr is
	signal sh_reg : std_logic_vector(407 downto 0);
begin

	pr_shr: process(clk, rst)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				sh_reg <= rc_in;
			else
				sh_reg <= sh_reg(399 downto 0) & sh_reg(407 downto 400);
			end if;		
		end if;
	end process;

	rc_out <= sh_reg(407 downto 400);

end Behavioral;

