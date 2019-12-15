--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:34:02 02/24/2015
-- Design Name:   
-- Module Name:   C:/Users/vmr/Desktop/noekeon_loop/noekeon_loop/tb_rc_shr.vhd
-- Project Name:  noekeon_loop
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: rc_shr
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_rc_shr IS
END tb_rc_shr;
 
ARCHITECTURE behavior OF tb_rc_shr IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rc_shr
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         rc_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal rc_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rc_shr PORT MAP (
          clk => clk,
          rst => rst,
          rc_out => rc_out
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
		wait for clk_period;
		rst <= '1';
		wait for clk_period;
		rst <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
