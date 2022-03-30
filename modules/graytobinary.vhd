----------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY gray2bin IS
        PORT (
                G : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
                bin : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
END ENTITY gray2bin;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behav OF gray2bin IS
BEGIN
        bin(2) <= G(2);
        bin(1) <= G(2) XOR G(1);
        bin(0) <= G(2) XOR G(1) XOR G(0);
END ARCHITECTURE;
----------------------------------------------------------