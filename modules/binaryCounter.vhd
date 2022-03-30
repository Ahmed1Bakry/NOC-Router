----------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY binaryCounter IS
    PORT (
        clk, clear, enable : IN STD_LOGIC;
        d_out : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END ENTITY binaryCounter;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behav OF binaryCounter IS
    --[signal declaration] --
    SIGNAL counter : STD_LOGIC_VECTOR (2 DOWNTO 0) := (OTHERS => '0');
BEGIN
    ct : PROCESS (clk, enable, clear) IS 
    BEGIN
        IF clear = '1' THEN
            counter <= (OTHERS => '0');
        ELSIF enable = '1' THEN
            IF rising_edge (clk) THEN
            counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS ct;
    d_out <= counter;
END ARCHITECTURE behav;
----------------------------------------------------------