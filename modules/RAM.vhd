----------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY ram IS
    PORT (
        d_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        wea, rea : IN STD_LOGIC;
        clka, clkb : IN STD_LOGIC;
        ADDRA, ADDRB : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        d_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY ram;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behav OF ram IS
-- [type and signal declaration] --
    TYPE ramdata IS ARRAY(7 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL memory : ramdata;
BEGIN
    write : PROCESS (clka) IS
    BEGIN
        IF wea = '1' THEN
            IF rising_edge(clka) THEN
            memory(conv_integer(ADDRA)) <= d_in;
            END IF;
        END IF;
    END PROCESS write;

    read : PROCESS (clkb) IS
    BEGIN
        IF rea = '1' THEN
            IF rising_edge(clkb) THEN
                d_out <= memory(conv_integer(ADDRB));
            END IF;
        END IF;
    END PROCESS read;
END;
----------------------------------------------------------