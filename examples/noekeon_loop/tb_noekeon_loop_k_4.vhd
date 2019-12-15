--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:15:32 02/25/2015
-- Design Name:   
-- Module Name:   C:/Users/vmr/Desktop/noekeon_loop/noekeon_loop/tb_noekeon_loop_k_4.vhd
-- Project Name:  noekeon_loop
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: noekeon_loop_k_4
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
 
ENTITY tb_noekeon_loop_k_4 IS
END tb_noekeon_loop_k_4;
 
ARCHITECTURE behavior OF tb_noekeon_loop_k_4 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT noekeon_loop_k_4
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         enc : IN  std_logic;
         a_0_in : IN  std_logic_vector(31 downto 0);
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
   signal rst : std_logic := '0';
   signal enc : std_logic := '0';
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
   uut: noekeon_loop_k_4 PORT MAP (
          clk => clk,
          rst => rst,
          enc => enc,
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
	wait for clk_period/2 + clk_period;
		rst <= '1';
		enc <= '0';
		
		a_0_in <= X"2a78421b";
		a_1_in <= X"87c7d092";		
		a_2_in <= X"4f26113f";
		a_3_in <= X"1d1349b2";

		k_0_in <= X"b1656851";
		k_1_in <= X"699e29fa";
		k_2_in <= X"24b70148";
		k_3_in <= X"503d2dfc";		
		
		wait for clk_period;
		rst <= '0';

		wait for clk_period*3 + clk_period/2;

      assert a_0_out = X"e2f687e0"
			report "ENCRYPT ERROR (a_0)" severity FAILURE;		

      assert a_1_out = X"7b75660f"
			report "ENCRYPT ERROR (a_1)" severity FAILURE;		

      assert a_2_out = X"fc372233"
			report "ENCRYPT ERROR (a_2)" severity FAILURE;	

      assert a_3_out = X"bc47532c"
			report "ENCRYPT ERROR (a_3)" severity FAILURE;	

      wait;
   end process;

END;
