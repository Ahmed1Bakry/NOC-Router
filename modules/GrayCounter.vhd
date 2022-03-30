----------------------------------------------------------
-- [library declaration] -- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY grayCounter IS
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        count_out : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END ENTITY grayCounter;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behav OF grayCounter IS
--[component and signal declarations] --
    COMPONENT binaryCounter IS
        PORT (
            clk, clear, enable : IN STD_LOGIC;
            d_out : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT binaryCounter;
    FOR ALL : binaryCounter USE ENTITY WORK.binaryCounter(behav);
    SIGNAL d_bin : STD_LOGIC_VECTOR (2 DOWNTO 0);
BEGIN
    bcount : binaryCounter 
    PORT MAP(clk => clock, clear => reset, enable => enable, d_out => d_bin);
    gray : PROCESS (d_bin) IS 
    BEGIN
        count_out(2) <= d_bin(2);
        FOR j IN 1 DOWNTO 0 LOOP
            count_out(j) <= d_bin (j + 1) XOR d_bin (j);
        END LOOP;
    END PROCESS gray;
END ARCHITECTURE;
----------------------------------------------------------