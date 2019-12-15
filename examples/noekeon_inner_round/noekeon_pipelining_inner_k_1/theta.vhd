
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

entity theta is
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
end theta;

architecture Behavioral of theta is

	signal a_1_0_s : std_logic_vector(31 downto 0);
	signal a_3_0_s : std_logic_vector(31 downto 0);

	signal tmp_0_s : std_logic_vector(31 downto 0);
	signal tmp_1_s : std_logic_vector(31 downto 0);
	signal tmp_2_s : std_logic_vector(31 downto 0);
	signal tmp_3_s : std_logic_vector(31 downto 0);

	signal m_1_tmp_0_s : std_logic_vector(31 downto 0);
	signal m_1_tmp_1_s : std_logic_vector(31 downto 0);
	signal m_1_tmp_2_s : std_logic_vector(31 downto 0);
	signal m_1_tmp_3_s : std_logic_vector(31 downto 0);

	signal m_2_tmp_0_s : std_logic_vector(31 downto 0);
	signal m_2_tmp_1_s : std_logic_vector(31 downto 0);
	signal m_2_tmp_2_s : std_logic_vector(31 downto 0);
	signal m_2_tmp_3_s : std_logic_vector(31 downto 0);
	
begin

--Theta(k,a){
	-- temp = a[0]^a[2]; 				
	-- temp ^= temp>>>8 ^ temp<<<8; 	
	-- a[1] ^= temp; 						
	-- a[3] ^= temp; 						

	-- a[0] ^= k[0]; 						
	-- a[1] ^= k[1]; 						
	-- a[2] ^= k[2]; 						
	-- a[3] ^= k[3]; 						

	-- temp = a[1]^a[3]; 
	-- temp ^= temp>>>8 ^ temp<<<8;
	-- a[0] ^= temp;
	-- a[2] ^= temp;
--}

	m_1_tmp_0_s <= a_0_in xor a_2_in; 											   -- temp = a[0]^a[2]; 
	m_1_tmp_1_s <= m_1_tmp_0_s(23 downto 0) & m_1_tmp_0_s(31 downto 24); -- temp>>>8  
	m_1_tmp_2_s <= m_1_tmp_0_s(7 downto 0) & m_1_tmp_0_s(31 downto 8);   -- temp<<<8;
	m_1_tmp_3_s <= m_1_tmp_0_s xor m_1_tmp_1_s xor m_1_tmp_2_s;          -- temp ^= temp>>>8 ^ temp<<<8;

	a_1_0_s <= a_1_in xor m_1_tmp_3_s;												-- a[1] ^= temp;
	a_3_0_s <= a_3_in xor m_1_tmp_3_s;												-- a[3] ^= temp; 

	tmp_0_s <= a_0_in xor k_0_in;														-- a[0] ^= k[0]; 	
	tmp_1_s <= a_1_0_s xor k_1_in;													-- a[1] ^= k[1];
	tmp_2_s <= a_2_in xor k_2_in;														-- a[2] ^= k[2]; 	
	tmp_3_s <= a_3_0_s xor k_3_in;													-- a[3] ^= k[3]; 									

	m_2_tmp_0_s <= tmp_1_s xor tmp_3_s;												-- temp = a[1]^a[3]; 
	m_2_tmp_1_s <= m_2_tmp_0_s(23 downto 0) & m_2_tmp_0_s(31 downto 24); -- temp>>>8
	m_2_tmp_2_s <= m_2_tmp_0_s(7 downto 0) & m_2_tmp_0_s(31 downto 8);   -- temp<<<8;
	m_2_tmp_3_s <= m_2_tmp_0_s xor m_2_tmp_1_s xor m_2_tmp_2_s;				-- temp ^= temp>>>8 ^ temp<<<8;

	a_0_out <= tmp_0_s xor m_2_tmp_3_s;												-- a[0] ^= temp;
	a_2_out <= tmp_2_s xor m_2_tmp_3_s;												-- a[2] ^= temp;

	a_1_out <= tmp_1_s;
	a_3_out <= tmp_3_s;

end Behavioral;

