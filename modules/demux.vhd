----------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
----------------------------------------------------------
-- [entity definition] -- 
ENTITY demuxproject IS
    PORT (
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        select_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        enable : IN STD_LOGIC;
        d1_out, d2_out ,d3_out, d4_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_sel : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END ENTITY;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behav OF demuxproject IS
BEGIN
    p1 : PROCESS (data_in, select_in, enable) IS 
    BEGIN
        IF enable = '1' THEN
            CASE select_in IS
                WHEN "00" =>
                    d1_out <= data_in;
                    wr_sel <= (0 => '1', OTHERS => '0');
                    -- wr_sel <= "0001"
                WHEN "01" =>
                    d2_out <= data_in;
                    wr_sel <= (1 => '1', OTHERS => '0');
                    -- wr_sel <= "0010"
                WHEN "10" =>
                    d3_out <= data_in;
                    wr_sel <= (2 => '1', OTHERS => '0');
                    -- wr_sel <= "0100"
                WHEN "11" =>
                    d4_out <= data_in;
                    wr_sel <= (3 => '1', OTHERS => '0');
                    -- wr_sel <= "1000"
                WHEN OTHERS =>
                    null;
            END CASE;
        ELSE
            wr_sel <= "0000";
        END IF;
    END PROCESS;
END ARCHITECTURE;
----------------------------------------------------------