
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

entity gamma is
	port(a_0_in : in std_logic_vector(31 downto 0);
		  a_1_in : in std_logic_vector(31 downto 0);
		  a_2_in : in std_logic_vector(31 downto 0);
		  a_3_in : in std_logic_vector(31 downto 0);		  
		  
		  a_0_out : out std_logic_vector(31 downto 0);
		  a_1_out : out std_logic_vector(31 downto 0);
		  a_2_out : out std_logic_vector(31 downto 0);
		  a_3_out : out std_logic_vector(31 downto 0));				  
end gamma;

architecture Behavioral of gamma is

	signal a_0_tmp_s : std_logic_vector(31 downto 0);
	signal a_1_tmp_s : std_logic_vector(31 downto 0);
	signal a_2_tmp_s : std_logic_vector(31 downto 0);
	signal a_3_tmp_s : std_logic_vector(31 downto 0);
	signal a_1_1_tmp_s : std_logic_vector(31 downto 0);
	signal a_0_1_tmp_s : std_logic_vector(31 downto 0);	
	signal a_0_2_tmp_s : std_logic_vector(31 downto 0);	

begin

--Gamma(a){
-- 	a[1] ^= ~a[3]&~a[2];
-- 	a[0] ^= a[2]& a[1];
--		tmp = a[3]; 
--		a[3] = a[0]; 
--		a[0] = tmp;
--		a[2] ^= a[0]^a[1]^a[3];
--		a[1] ^= ~a[3]&~a[2];
--		a[0] ^= a[2]& a[1];
--}

	a_1_tmp_s <= a_1_in xor (not(a_3_in) and not(a_2_in)); 					-- a[1] ^= ~a[3]&~a[2];
	a_0_tmp_s <= a_0_in xor (a_2_in and a_1_tmp_s); 		 					-- a[2]& a[1];

	a_0_1_tmp_s <= a_3_in; 																-- a[0] = a[3]; 
	a_3_tmp_s <=  a_0_tmp_s; 															-- a[3] = a[0]; 

	a_2_tmp_s <= a_0_1_tmp_s xor a_1_tmp_s xor a_2_in xor a_3_tmp_s; 		-- a[2] ^= a[0]^a[1]^a[3];
	a_1_1_tmp_s <= a_1_tmp_s xor (not(a_3_tmp_s) and not(a_2_tmp_s)); 	-- a[1] ^= ~a[3]&~a[2];
	a_0_2_tmp_s <= a_0_1_tmp_s xor (a_2_tmp_s and a_1_1_tmp_s);				-- a[0] ^= a[2]& a[1];

	a_3_out <= a_3_tmp_s;
	a_2_out <= a_2_tmp_s;
	a_1_out <= a_1_1_tmp_s;
	a_0_out <= a_0_2_tmp_s;
	
end Behavioral;

