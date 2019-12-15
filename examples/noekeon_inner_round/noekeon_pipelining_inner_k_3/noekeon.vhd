
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

-- This is an iterative implementation of the NOEKEON block
-- cipher relying on the direct mode of the cipher. This means that
-- key schedule is not performed.

entity noekeon is
	port(clk     : in std_logic;
		  rst     : in std_logic;
		  enc     : in std_logic; -- (enc, 0) / (dec, 1)
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
end noekeon;

architecture Behavioral of noekeon is

	component round_f is
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
	end component;

	component rc_gen is
	port(clk : in std_logic;
	     rst : in std_logic;
		  enc : in std_logic; -- (enc, 0) / (dec, 1)
		  rc_out : out std_logic_vector(7 downto 0));
	end component;

	component output_trans is
	port(clk     : in std_logic;
		  enc		 : in std_logic; -- (enc, 0) / (dec, 1)
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
	end component;

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

	component rc_shr is
	port(clk : in std_logic;
		  rst : in std_logic;
		  rc_in : in std_logic_vector(543 downto 0);
		  rc_out : out std_logic_vector(7 downto 0));
	end component;

	signal rc_s : std_logic_vector(7 downto 0);
	signal rc_ext_s : std_logic_vector(31 downto 0);

	signal a_0_in_s  : std_logic_vector(31 downto 0);
	signal a_1_in_s  : std_logic_vector(31 downto 0);
	signal a_2_in_s  : std_logic_vector(31 downto 0);
	signal a_3_in_s  : std_logic_vector(31 downto 0);		

	signal out_t_a_0_in_s  : std_logic_vector(31 downto 0);
	signal out_t_a_1_in_s  : std_logic_vector(31 downto 0);
	signal out_t_a_2_in_s  : std_logic_vector(31 downto 0);
	signal out_t_a_3_in_s  : std_logic_vector(31 downto 0);		
	
	signal a_0_out_s : std_logic_vector(31 downto 0);
	signal a_1_out_s : std_logic_vector(31 downto 0);
	signal a_2_out_s : std_logic_vector(31 downto 0);
	signal a_3_out_s : std_logic_vector(31 downto 0);

	signal k_0_d_s  : std_logic_vector(31 downto 0);
	signal k_1_d_s  : std_logic_vector(31 downto 0);
	signal k_2_d_s  : std_logic_vector(31 downto 0);
	signal k_3_d_s  : std_logic_vector(31 downto 0);	

	signal k_0_mux_s  : std_logic_vector(31 downto 0);
	signal k_1_mux_s  : std_logic_vector(31 downto 0);
	signal k_2_mux_s  : std_logic_vector(31 downto 0);
	signal k_3_mux_s  : std_logic_vector(31 downto 0);	

	signal rc_in_s : std_logic_vector(543 downto 0);

begin

--	rc_in_s <= X"80 1b 36 6c d8 ab 4d 9a 2f 5e bc 63 c6 97 35 6a d4";
	rc_in_s <= X"808080801b1b1b1b363636366c6c6c6cd8d8d8d8abababab4d4d4d4d9a9a9a9a2f2f2f2f5e5e5e5ebcbcbcbc63636363c6c6c6c697979797353535356a6a6a6ad4d4d4d4";
	
	--RC_GEN_0 : rc_gen port map (clk, rst, enc, rc_s);

	RC_SHR_0: rc_shr port map (clk, rst, rc_in_s, rc_s);
	rc_ext_s <= X"000000" & rc_s;

	ROUND_F_0 : round_f port map (clk,
											rst,
										   enc,
										   rc_ext_s, 
											a_0_in_s,
											a_1_in_s,
										   a_2_in_s,
											a_3_in_s,
											k_0_mux_s,
											k_1_mux_s,
											k_2_mux_s,
											k_3_mux_s,
											a_0_out_s,
											a_1_out_s,
											a_2_out_s,
											a_3_out_s);

	pr_noe: process(clk, rst, enc)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				a_0_in_s <= a_0_in;
				a_1_in_s <= a_1_in;
				a_2_in_s <= a_2_in;
				a_3_in_s <= a_3_in;				
			else
				a_0_in_s <= a_0_out_s;
				a_1_in_s <= a_1_out_s;
				a_2_in_s <= a_2_out_s;
				a_3_in_s <= a_3_out_s;				
			end if;
		end if;
	end process;

	-- Key decryption as k' = theta(0, k)
	-- This is the key required for decryption
	-- in NOEKEON
	
	THETA_DECRYPT_0 : theta port map (
			k_0_in,
			k_1_in,
			k_2_in,
			k_3_in,	
			(others => '0'),
			(others => '0'),
			(others => '0'),
			(others => '0'),			
			k_0_d_s,	
	      k_1_d_s,	
	      k_2_d_s,	
	      k_3_d_s);

	-- These multiplexers select the key that is used
	-- in each mode i.e. during decryption the key generated
	-- as k' = theta(0, k) (THETA_DECRYPT_0) is utilized.

	k_0_mux_s <= k_0_in when enc = '0' else k_0_d_s;
	k_1_mux_s <= k_1_in when enc = '0' else k_1_d_s;
	k_2_mux_s <= k_2_in when enc = '0' else k_2_d_s;
	k_3_mux_s <= k_3_in when enc = '0' else k_3_d_s;

	out_trans_pr: process(clk, rst, a_0_out_s, a_1_out_s, a_2_out_s, a_3_out_s)
	begin
		if rising_edge(clk) then
			out_t_a_0_in_s <= a_0_out_s;
			out_t_a_1_in_s <= a_1_out_s;
			out_t_a_2_in_s <= a_2_out_s;
			out_t_a_3_in_s <= a_3_out_s;			
		end if;
	end process;

	-- This component performs the last operation
	-- with theta.

	OUT_TRANS_0 : output_trans port map (clk, enc, rc_ext_s,
			out_t_a_0_in_s,
			out_t_a_1_in_s,
			out_t_a_2_in_s,
			out_t_a_3_in_s,
			k_0_mux_s,
			k_1_mux_s,
			k_2_mux_s,
			k_3_mux_s,			
			a_0_out,
			a_1_out,
			a_2_out,
			a_3_out);

end Behavioral;

