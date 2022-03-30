----------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY RouterTB IS
END RouterTB;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE behavior OF RouterTB IS

-- [Component Declaration for the Unit Under Test (UUT)] --

   COMPONENT router
      PORT (
         wclock : IN STD_LOGIC;
         rst : IN STD_LOGIC;
         rclock : IN STD_LOGIC;
         datai1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         datai2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         datai3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         datai4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         wr1 : IN STD_LOGIC;
         wr2 : IN STD_LOGIC;
         wr3 : IN STD_LOGIC;
         wr4 : IN STD_LOGIC;
         datao1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
         datao2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
         datao3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
         datao4 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
   END COMPONENT;
   --Inputs
   SIGNAL wclock : STD_LOGIC := '0';
   SIGNAL rst : STD_LOGIC := '0';
   SIGNAL rclock : STD_LOGIC := '0';
   SIGNAL datai1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => 'Z');
   SIGNAL datai2 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => 'Z');
   SIGNAL datai3 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => 'Z');
   SIGNAL datai4 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => 'Z');
   SIGNAL wr1 : STD_LOGIC := '0';
   SIGNAL wr2 : STD_LOGIC := '0';
   SIGNAL wr3 : STD_LOGIC := '0';
   SIGNAL wr4 : STD_LOGIC := '0';

   --Outputs
   SIGNAL datao1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL datao2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL datao3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL datao4 : STD_LOGIC_VECTOR(7 DOWNTO 0);

   -- Clock period definitions
   CONSTANT wclock_period : TIME := 20 ns;
   CONSTANT rclock_period : TIME := 20 ns;

BEGIN

   -- Instantiate the Unit Under Test (UUT)
   uut : router PORT MAP(
      wclock => wclock,
      rst => rst,
      rclock => rclock,
      datai1 => datai1,
      datai2 => datai2,
      datai3 => datai3,
      datai4 => datai4,
      wr1 => wr1,
      wr2 => wr2,
      wr3 => wr3,
      wr4 => wr4,
      datao1 => datao1,
      datao2 => datao2,
      datao3 => datao3,
      datao4 => datao4
   );

   -- Clock process definitions
   wclock_process : PROCESS
   BEGIN
      wclock <= '0';
      WAIT FOR wclock_period/2;
      wclock <= '1';
      WAIT FOR wclock_period/2;
   END PROCESS;

   rclock_process : PROCESS
   BEGIN
      rclock <= '0';
      WAIT FOR rclock_period/2;
      rclock <= '1';
      WAIT FOR rclock_period/2;
   END PROCESS;
   -- Stimulus process
   stim_proc : PROCESS
   BEGIN
      -- insert stimulus here
      rst <= '1';
      WAIT FOR 5 ns;
      rst <= '0';
      datai1 <= "00000000";
      datai2 <= "01000001";
      datai3 <= "10000010";
      datai4 <= "11000011";
      wr1 <= '1';
      wr2 <= '1';
      wr3 <= '1';
      wr4 <= '1';
      WAIT FOR 20 ns;
      wr1 <= '0';
      wr2 <= '0';
      wr3 <= '0';
      wr4 <= '0';
      WAIT FOR 10 ns;
      datai1 <= "00000101";
      datai2 <= "01000110";
      datai3 <= "10000111";
      datai4 <= "11000100";
      wr1 <= '1';
      wr2 <= '1';
      wr3 <= '1';
      wr4 <= '1';
      WAIT FOR 20 ns;
      wr1 <= '0';
      wr2 <= '0';
      wr3 <= '0';
      wr4 <= '0';
      WAIT FOR 10 ns;
      datai1 <= "00001010";
      datai2 <= "01001011";
      datai3 <= "10001000";
      datai4 <= "11001001";
      wr1 <= '1';
      wr2 <= '1';
      wr3 <= '1';
      wr4 <= '1';
      WAIT FOR 20 ns;
      wr1 <= '0';
      wr2 <= '0';
      wr3 <= '0';
      wr4 <= '0';
      WAIT FOR 10 ns;
      datai1 <= "00001111";
      datai2 <= "01001100";
      datai3 <= "10001101";
      datai4 <= "11001110";
      wr1 <= '1';
      wr2 <= '1';
      wr3 <= '1';
      wr4 <= '1';
      WAIT FOR 20 ns;
      wr1 <= '0';
      wr2 <= '0';
      wr3 <= '0';
      wr4 <= '0';
      WAIT FOR 10 ns;
      datai1 <= "00010000";
      datai2 <= "01010001";
      datai3 <= "10010010";
      datai4 <= "11010011";
      wr1 <= '1';
      wr2 <= '1';
      wr3 <= '1';
      wr4 <= '1';
      WAIT FOR 20 ns;
      wr1 <= '0';
      wr2 <= '0';
      wr3 <= '0';
      wr4 <= '0';
      WAIT;
   END PROCESS;
END;
----------------------------------------------------------