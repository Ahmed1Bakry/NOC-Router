----------------------------------------------------------
-- [library declaration] --
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
----------------------------------------------------------
-- [entity definition] --
ENTITY fifo_ctrl IS
  GENERIC (N : INTEGER := 2);
  PORT (
    reset, rdclk, wrclk, r_req, w_req : IN STD_LOGIC;
    write_valid, read_valid, empty, full : OUT STD_LOGIC;
    wr_ptr, rd_ptr : OUT STD_LOGIC_VECTOR(N DOWNTO 0)
  );
END fifo_ctrl;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE fifo_ctrl_behav OF fifo_ctrl IS
--[component and signal declarations] --
  COMPONENT grayCounter IS
    PORT (
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      enable : IN STD_LOGIC;
      count_out : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
  END COMPONENT grayCounter;
  FOR ALL : grayCounter USE ENTITY WORK.grayCounter(behav);

  COMPONENT gray2bin IS
    PORT (
      G : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      bin : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
  END COMPONENT gray2bin;
  FOR ALL : gray2bin USE ENTITY WORK.gray2bin(behav);

  SIGNAL wr_ptr_t, rd_ptr_t, wr_ptr_g, rd_ptr_g : STD_LOGIC_VECTOR(N DOWNTO 0);
  SIGNAL empty_t, full_t, write_valid_t, read_valid_t : STD_LOGIC;
BEGIN

  readCtr : grayCounter 
  PORT MAP(rdclk, reset, read_valid_t, rd_ptr_g);
  writeCtr : grayCounter 
  PORT MAP(wrclk, reset, write_valid_t, wr_ptr_g);

  readConverter : gray2bin 
  PORT MAP(rd_ptr_g, rd_ptr_t);
  writeConverter : gray2bin 
  PORT MAP(wr_ptr_g, wr_ptr_t);

  full <= full_t;
  empty <= empty_t;
  wr_ptr <= wr_ptr_t;
  rd_ptr <= rd_ptr_t;
  write_valid <= write_valid_t;
  read_valid <= read_valid_t;

  PROCESS (r_req, w_req, wr_ptr_t, rd_ptr_t, empty_t, full_t)
  BEGIN
    IF (rd_ptr_t = wr_ptr_t) THEN
      empty_t <= '1';
    ELSE
      empty_t <= '0';
    END IF;

    IF (rd_ptr_t = (wr_ptr_t + 1)) THEN
      full_t <= '1';
    ELSE
      full_t <= '0';
    END IF;

    IF (w_req = '1' AND full_t = '0') THEN
      write_valid_t <= '1';
    ELSE
      write_valid_t <= '0';
    END IF;

    IF (r_req = '1' AND empty_t = '0') THEN
      read_valid_t <= '1';
    ELSE
      read_valid_t <= '0';
    END IF;
  END PROCESS;
END fifo_ctrl_behav;
----------------------------------------------------------