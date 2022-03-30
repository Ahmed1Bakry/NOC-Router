----------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY RRTestBench IS
END RRTestBench;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behavior OF RRTestBench IS

   -- [Component Declaration for the Unit Under Test (UUT)] -- 

   COMPONENT RoundRobinScheduler
      PORT (
         clock : IN STD_LOGIC;
         reset : IN STD_LOGIC;
         din1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         din2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         din3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         din4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         RR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
         dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
   END COMPONENT;
   --Inputs
   SIGNAL clock : STD_LOGIC := '0';
   SIGNAL reset : STD_LOGIC := '0';
   SIGNAL din1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL din2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL din3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL din4 : STD_LOGIC_VECTOR(7 DOWNTO 0);

   --Outputs
   SIGNAL RR : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL dout : STD_LOGIC_VECTOR(7 DOWNTO 0);

   -- Clock period definitions
   CONSTANT clock_period : TIME := 20 ns;

BEGIN

   -- Instantiate the Unit Under Test (UUT)
   uut : RoundRobinScheduler PORT MAP(
      clock => clock,
      reset => reset,
      din1 => din1,
      din2 => din2,
      din3 => din3,
      din4 => din4,
      RR => RR,
      dout => dout
   );

   -- Clock process definitions
   clock_process : PROCESS
   BEGIN
      clock <= '0';
      WAIT FOR clock_period/2;
      clock <= '1';
      WAIT FOR clock_period/2;
   END PROCESS;
   -- Stimulus process
   stim_proc : PROCESS
   BEGIN
      reset <= '1';
      WAIT FOR 5 ns;
      reset <= '0';
      WAIT FOR 10 ns;
      din1 <= "00001111";
      WAIT FOR 10 ns;
      din1 <= "01010101";
      WAIT FOR 10 ns;
      din2 <= "11110000";
      WAIT FOR 10 ns;
      din2 <= "10101010";
      WAIT FOR 10 ns;
      din3 <= "00110011";
      WAIT FOR 10 ns;
      din3 <= "11000011";
      WAIT FOR 10 ns;
      din4 <= "11001100";
      WAIT FOR 10 ns;
      reset <= '1';
      WAIT FOR 5 ns;
      reset <= '0';
      din4 <= "00111100";
      WAIT FOR 10 ns;
      din1 <= "00010001";
      WAIT FOR 10 ns;
      din3 <= "01000100";
      WAIT FOR 10 ns;
      din2 <= "00100010";
      WAIT FOR 10 ns;
      din4 <= "10001000";
      WAIT;
   END PROCESS;
END;
----------------------------------------------------------