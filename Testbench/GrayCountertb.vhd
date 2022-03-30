----------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY tbGrayCounter IS
END ENTITY;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behav OF tbGrayCounter IS
-- [component and signal declarations] -- 
    COMPONENT grayCounter IS
        PORT (
            clock : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            count_out : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT grayCounter;
    FOR ALL : grayCounter USE ENTITY WORK.grayCounter(behav);
    SIGNAL clock : STD_LOGIC;
    SIGNAL reset : STD_LOGIC;
    SIGNAL enable : STD_LOGIC;
    SIGNAL count_out : STD_LOGIC_VECTOR (2 DOWNTO 0);
BEGIN
    but : grayCounter PORT MAP(clock, reset, enable, count_out);
    p1 : PROCESS IS BEGIN
        WAIT FOR 10 ns;
        IF (clock = '0') THEN
            clock <= '1';
        ELSE
            clock <= '0';
        END IF;
    END PROCESS p1;
END ARCHITECTURE;
----------------------------------------------------------