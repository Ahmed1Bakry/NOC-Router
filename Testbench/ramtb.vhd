----------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY tbram IS
END ENTITY;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behav OF tbram IS
-- [component and signal declarations] --
    COMPONENT ram IS
        PORT (
            d_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            wea, rea : IN STD_LOGIC;
            clka, clkb : IN STD_LOGIC;
            ADDRA, ADDRB : INOUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            d_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT ram;
    FOR ALL : ram USE ENTITY work.ram(behav);
    SIGNAL d_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL wea, rea : STD_LOGIC;
    SIGNAL clka, clkb : STD_LOGIC;
    SIGNAL ADDRA, ADDRB : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL d_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    dut : ram PORT MAP(d_in, wea, rea, clka, clkb, ADDRA, ADDRB, d_out);
    p1 : PROCESS IS BEGIN
        WAIT FOR 10 ns;
        IF (clka = '0') THEN
            clka <= '1';
        ELSE
            clka <= '0';
        END IF;
        IF (clkb = '0') THEN
            clkb <= '1';
        ELSE
            clkb <= '0';
        END IF;
    END PROCESS p1;
END ARCHITECTURE;
----------------------------------------------------------