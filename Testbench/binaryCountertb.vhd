----------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY tbbinaryCounter IS
END ENTITY;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behav OF tbbinaryCounter IS
-- [component and signal decalarations] --
    COMPONENT BinaryCounter IS
        PORT (
            clk, clear, enable : IN STD_LOGIC;
            d_out : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT BinaryCounter;
    FOR ALL : BinaryCounter USE ENTITY WORK.BinaryCounter(behav);
    SIGNAL clk : STD_LOGIC;
    SIGNAL clear : STD_LOGIC;
    SIGNAL d_out : STD_LOGIC_VECTOR (2 DOWNTO 0);
BEGIN
    but : BinaryCounter PORT MAP(clk, clear, '1', d_out);
    p1 : PROCESS IS BEGIN
        WAIT FOR 10 ns;
        IF (clk = '0') THEN
            clk <= '1';
        ELSE
            clk <= '0';
        END IF;
    END PROCESS p1;
END ARCHITECTURE;