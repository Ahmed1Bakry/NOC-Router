----------------------------------------------------------
-- [library declaration] --
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY RoundRobinScheduler IS
	PORT (
		clock, reset : IN STD_LOGIC;
		din1, din2, din3, din4 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		RR : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		dout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END RoundRobinScheduler;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE Behavioral OF RoundRobinScheduler IS
--[type and signal declaration] --
	TYPE state IS (s_idle, s1, s2, s3, s4);
	SIGNAL CurrentState, NextState : state;
BEGIN
	PROCESS (clock, reset)
	BEGIN
		IF (reset = '1') THEN
			CurrentState <= s_idle;
		ELSIF (rising_edge(clock)) THEN
			CurrentState <= NextState;
		END IF;
	END PROCESS;

	PROCESS (CurrentState, din1, din2, din3, din4)
	BEGIN
		CASE CurrentState IS
			WHEN s_idle =>
				IF (din1 /= "UUUUUUUU") THEN
					dout <= din1;
					NextState <= s1;
					RR <= (0 => '1', OTHERS => '0');
				ELSIF (din2 /= "UUUUUUUU") THEN
					dout <= din2;
					NextState <= s2;
					RR <= (1 => '1', OTHERS => '0');
				ELSIF (din3 /= "UUUUUUUU") THEN
					dout <= din3;
					NextState <= s3;
					RR <= (2 => '1', OTHERS => '0');
				ELSIF (din4 /= "UUUUUUUU") THEN
					dout <= din4;
					NextState <= s4;
					RR <= (3 => '1', OTHERS => '0');
				ELSE
					NextState <= s_idle;
					dout <= "ZZZZZZZZ";
					RR <= "1111";
				END IF;

			WHEN s1 =>
				IF (din1 /= "UUUUUUUU") THEN
					dout <= din1;
					NextState <= s2;
					RR <= (0 => '1', OTHERS => '0');
				ELSIF (din2 /= "UUUUUUUU") THEN
					dout <= din2;
					NextState <= s3;
					RR <= (1 => '1', OTHERS => '0');
				ELSIF (din3 /= "UUUUUUUU") THEN
					dout <= din3;
					NextState <= s4;
					RR <= (2 => '1', OTHERS => '0');
				ELSE
					NextState <= s_idle;
					dout <= "ZZZZZZZZ";
					RR <= "1111";
				END IF;

			WHEN s2 =>
				IF (din2 /= "UUUUUUUU") THEN
					dout <= din2;
					NextState <= s3;
					RR <= (1 => '1', OTHERS => '0');
				ELSIF (din3 /= "UUUUUUUU") THEN
					dout <= din3;
					NextState <= s4;
					RR <= (2 => '1', OTHERS => '0');
				ELSIF (din4 /= "UUUUUUUU") THEN
					dout <= din4;
					NextState <= s1;
					RR <= (3 => '1', OTHERS => '0');
				ELSE
					NextState <= s_idle;
					dout <= "ZZZZZZZZ";
					RR <= "1111";
				END IF;

			WHEN s3 =>
				IF (din3 /= "UUUUUUUU") THEN
					dout <= din3;
					NextState <= s4;
					RR <= (2 => '1', OTHERS => '0');
				ELSIF (din4 /= "UUUUUUUU") THEN
					dout <= din4;
					NextState <= s1;
					RR <= (3 => '1', OTHERS => '0');
				ELSIF (din1 /= "UUUUUUUU") THEN
					dout <= din1;
					NextState <= s2;
					RR <= (0 => '1', OTHERS => '0');
				ELSE
					NextState <= s_idle;
					dout <= "ZZZZZZZZ";
					RR <= "1111";
				END IF;

			WHEN s4 =>
				IF (din4 /= "UUUUUUUU") THEN
					dout <= din4;
					NextState <= s1;
					RR <= (3 => '1', OTHERS => '0');
				ELSIF (din1 /= "UUUUUUUU") THEN
					dout <= din1;
					NextState <= s2;
					RR <= (0 => '1', OTHERS => '0');
				ELSIF (din2 /= "UUUUUUUU") THEN
					dout <= din2;
					NextState <= s3;
					RR <= (1 => '1', OTHERS => '0');
				ELSE
					NextState <= s_idle;
					dout <= "ZZZZZZZZ";
					RR <= "1111";
				END IF;
		END CASE;
	END PROCESS;
END Behavioral;
----------------------------------------------------------