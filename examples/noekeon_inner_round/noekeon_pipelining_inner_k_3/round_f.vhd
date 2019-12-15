
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity round_f is
	port(clk : in std_logic;
		  rst : in std_logic;
		  enc : in std_logic;
		  rc_in   : in std_logic_vector(31 downto 0);
		  a_0_in  : in std_logic_vector(31 downto 0);
		  a_1_in  : in std_logic_vector(31 downto 0);
		  a_2_in  : in std_logic_vector(31 downto 0);
		  a_3_in  : in std_logic_vector(31 downto 0);		
		  k_0_in  : in std_logic_vector(31 downto 0);
		  k_1_in  : in std_logic_vector(31 downto 0);
		  k_2_in  : in std_logic_vector(31 downto 0);
		  k_3_in  : in std_logic_vector(31 downto 0);
		  a_0_out : out std_logic_vector(31 downto 0);
		  a_1_out : out std_logic_vector(31 downto 0);
		  a_2_out : out std_logic_vector(31 downto 0);
		  a_3_out : out std_logic_vector(31 downto 0));
end round_f;

architecture Behavioral of round_f is

	signal a_0_in_s : std_logic_vector(31 downto 0);

	signal theta_0_s : std_logic_vector(31 downto 0);
	signal theta_1_s : std_logic_vector(31 downto 0);
	signal theta_2_s : std_logic_vector(31 downto 0);
	signal theta_3_s : std_logic_vector(31 downto 0);

	signal pi_1_1_s : std_logic_vector(31 downto 0);
	signal pi_1_2_s : std_logic_vector(31 downto 0);
	signal pi_1_3_s : std_logic_vector(31 downto 0);

	signal gamma_0_s : std_logic_vector(31 downto 0);
	signal gamma_1_s : std_logic_vector(31 downto 0);
	signal gamma_2_s : std_logic_vector(31 downto 0);
	signal gamma_3_s : std_logic_vector(31 downto 0);

	signal pi_2_1_s : std_logic_vector(31 downto 0);
	signal pi_2_2_s : std_logic_vector(31 downto 0);
	signal pi_2_3_s : std_logic_vector(31 downto 0);

	component theta is
	port(a_0_in : in std_logic_vector(31 downto 0);
	     a_1_in : in std_logic_vector(31 downto 0);
	     a_2_in : in std_logic_vector(31 downto 0);
	     a_3_in : in std_logic_vector(31 downto 0);
		  
	     k_0_in : in std_logic_vector(31 downto 0);
	     k_1_in : in std_logic_vector(31 downto 0);
	     k_2_in : in std_logic_vector(31 downto 0);
	     k_3_in : in std_logic_vector(31 downto 0);

	     a_0_out : out std_logic_vector(31 downto 0);
	     a_1_out : out std_logic_vector(31 downto 0);
	     a_2_out : out std_logic_vector(31 downto 0);
	     a_3_out : out std_logic_vector(31 downto 0));
	end component;

	component pi_1 is
	port(a_1_in 	: in std_logic_vector(31 downto 0);
		  a_2_in 	: in std_logic_vector(31 downto 0);
		  a_3_in 	: in std_logic_vector(31 downto 0);
		  a_1_out 	: out std_logic_vector(31 downto 0);
		  a_2_out	: out std_logic_vector(31 downto 0);
		  a_3_out 	: out std_logic_vector(31 downto 0));
	end component;

	component gamma is
	port(a_0_in : in std_logic_vector(31 downto 0);
		  a_1_in : in std_logic_vector(31 downto 0);
		  a_2_in : in std_logic_vector(31 downto 0);
		  a_3_in : in std_logic_vector(31 downto 0);		  
		  
		  a_0_out : out std_logic_vector(31 downto 0);
		  a_1_out : out std_logic_vector(31 downto 0);
		  a_2_out : out std_logic_vector(31 downto 0);
		  a_3_out : out std_logic_vector(31 downto 0));				  
	end component;

	component pi_2 is
	port(a_1_in 	: in std_logic_vector(31 downto 0);
		  a_2_in 	: in std_logic_vector(31 downto 0);
		  a_3_in 	: in std_logic_vector(31 downto 0);
		  a_1_out 	: out std_logic_vector(31 downto 0);
		  a_2_out	: out std_logic_vector(31 downto 0);
		  a_3_out 	: out std_logic_vector(31 downto 0));
	end component;

	component reg_128 is
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
	end component;

	signal a_0_aux_s : std_logic_vector(31 downto 0);

	signal stage_0_out_0_s : std_logic_vector(31 downto 0);
	signal stage_0_out_1_s : std_logic_vector(31 downto 0);
	signal stage_0_out_2_s : std_logic_vector(31 downto 0);
	signal stage_0_out_3_s : std_logic_vector(31 downto 0);

	signal stage_1_out_0_s : std_logic_vector(31 downto 0);
	signal stage_1_out_1_s : std_logic_vector(31 downto 0);
	signal stage_1_out_2_s : std_logic_vector(31 downto 0);
	signal stage_1_out_3_s : std_logic_vector(31 downto 0);

	signal stage_2_out_0_s : std_logic_vector(31 downto 0);
	signal stage_2_out_1_s : std_logic_vector(31 downto 0);
	signal stage_2_out_2_s : std_logic_vector(31 downto 0);
	signal stage_2_out_3_s : std_logic_vector(31 downto 0);

	signal rc_delay_s : std_logic_vector(31 downto 0);

begin

        rc_delay_s <= rc_in;
	
	a_0_in_s <= (a_0_in xor rc_delay_s) when enc = '0' else a_0_in;

	THETA_0 : theta port map (a_0_in_s,
									  a_1_in, 
									  a_2_in, 
									  a_3_in, 
									  k_0_in, 
									  k_1_in,
									  k_2_in, 
									  k_3_in,
									  theta_0_s,
									  theta_1_s,
									  theta_2_s,
									  theta_3_s);

	REG_STAGE_0: reg_128 port map (clk, 
											 rst,
											 theta_0_s, 
											 theta_1_s, 
											 theta_2_s, 
											 theta_3_s, 
											 stage_0_out_0_s, 
											 stage_0_out_1_s, 
											 stage_0_out_2_s, 
											 stage_0_out_3_s);
	PI_1_0 : pi_1 port map (stage_0_out_1_s,
									stage_0_out_2_s,
									stage_0_out_3_s,
									pi_1_1_s,
									pi_1_2_s,
									pi_1_3_s);

	a_0_aux_s <= (stage_0_out_0_s xor rc_delay_s) when enc = '1' else stage_0_out_0_s;

	REG_STAGE_1: reg_128 port map (clk, 
											 rst,
											 a_0_aux_s, 
											 pi_1_1_s, 
											 pi_1_2_s, 
											 pi_1_3_s, 
											 stage_1_out_0_s, 
											 stage_1_out_1_s, 
											 stage_1_out_2_s, 
											 stage_1_out_3_s);

	GAMMA_0 : gamma port map (stage_1_out_0_s,
									  stage_1_out_1_s,
									  stage_1_out_2_s,
									  stage_1_out_3_s,
									  gamma_0_s,
									  gamma_1_s, 
									  gamma_2_s, 
							        gamma_3_s);

	REG_STAGE_2: reg_128 port map (clk, 
											 rst,
											 gamma_0_s, 
											 gamma_1_s, 
											 gamma_2_s, 
											 gamma_3_s, 
											 stage_2_out_0_s, 
											 stage_2_out_1_s, 
											 stage_2_out_2_s, 
											 stage_2_out_3_s);

	PI_2_0 : pi_2 port map (stage_2_out_1_s,
									stage_2_out_2_s,
									stage_2_out_3_s,
									pi_2_1_s,
									pi_2_2_s,
									pi_2_3_s);	

	a_0_out <= stage_2_out_0_s;
	a_1_out <= pi_2_1_s;
	a_2_out <= pi_2_2_s;
	a_3_out <= pi_2_3_s;

end Behavioral;

