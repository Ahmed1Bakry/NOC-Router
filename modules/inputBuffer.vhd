-------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-------------------------------------------------------
-- [entity definition] -- 
ENTITY inputBuffer IS
    PORT (
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        clk, eclk, reset : IN STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY;
-------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behav OF inputBuffer IS
BEGIN
    p1 : PROCESS (clk, eclk, reset) IS
    BEGIN
        IF (reset = '1') THEN
            data_out <= "ZZZZZZZZ";
        ELSIF (eclk = '1') THEN
            IF (rising_edge(clk)) THEN
                data_out <= data_in;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
---------------------------------------------------------