
-- Copyright (c) 2013 Antonio de la Piedra

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_theta IS
END tb_theta;
 
ARCHITECTURE behavior OF tb_theta IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT theta
    PORT(a_0_in : IN  std_logic_vector(31 downto 0);
         a_1_in : IN  std_logic_vector(31 downto 0);
         a_2_in : IN  std_logic_vector(31 downto 0);
         a_3_in : IN  std_logic_vector(31 downto 0);
         k_0_in : IN  std_logic_vector(31 downto 0);
         k_1_in : IN  std_logic_vector(31 downto 0);
         k_2_in : IN  std_logic_vector(31 downto 0);
         k_3_in : IN  std_logic_vector(31 downto 0);
         a_0_out : OUT  std_logic_vector(31 downto 0);
         a_1_out : OUT  std_logic_vector(31 downto 0);
         a_2_out : OUT  std_logic_vector(31 downto 0);
         a_3_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal a_0_in : std_logic_vector(31 downto 0) := (others => '0');
   signal a_1_in : std_logic_vector(31 downto 0) := (others => '0');
   signal a_2_in : std_logic_vector(31 downto 0) := (others => '0');
   signal a_3_in : std_logic_vector(31 downto 0) := (others => '0');
   signal k_0_in : std_logic_vector(31 downto 0) := (others => '0');
   signal k_1_in : std_logic_vector(31 downto 0) := (others => '0');
   signal k_2_in : std_logic_vector(31 downto 0) := (others => '0');
   signal k_3_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal a_0_out : std_logic_vector(31 downto 0);
   signal a_1_out : std_logic_vector(31 downto 0);
   signal a_2_out : std_logic_vector(31 downto 0);
   signal a_3_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: theta PORT MAP (
          a_0_in => a_0_in,
          a_1_in => a_1_in,
          a_2_in => a_2_in,
          a_3_in => a_3_in,
          k_0_in => k_0_in,
          k_1_in => k_1_in,
          k_2_in => k_2_in,
          k_3_in => k_3_in,
          a_0_out => a_0_out,
          a_1_out => a_1_out,
          a_2_out => a_2_out,
          a_3_out => a_3_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		a_0_in <= X"200d6ff9";
		a_1_in <= X"02667af7";
		a_2_in <= X"3a345347";		
		a_3_in <= X"2cd90d69";

		k_0_in <= X"fd178c4d";
		k_1_in <= X"fc0df5d7";
		k_2_in <= X"7a728549";		
		k_3_in <= X"eaa289dd";

		wait for clk_period;

		assert a_0_out = X"61396C13"
			report "THETA ERROR (a_0)" severity FAILURE;		

      assert a_1_out = X"637434B8"
			report "THETA ERROR (a_1)" severity FAILURE;		

      assert a_2_out = X"FC6559A9"
			report "THETA ERROR (a_2)" severity FAILURE;	

      assert a_3_out = X"5B643F2C"
			report "THETA ERROR (a_3)" severity FAILURE;	
			
      wait;
   end process;

END;
