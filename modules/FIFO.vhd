-------------------------------------------------------------
-- [library declaration] --
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
-------------------------------------------------------------
-- [entity definition] --
ENTITY fifo IS
  PORT (
    reset, rclk, wclk, wreq, rreq : IN STD_LOGIC;
    datain : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dataout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    empty, full : OUT STD_LOGIC
  );
END fifo;
-------------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE fifo_struc OF fifo IS
--[component and signal declarations] --
  COMPONENT fifo_ctrl IS
    GENERIC (N : INTEGER := 2);
    PORT (
      reset, rdclk, wrclk, r_req, w_req : IN STD_LOGIC;
      write_valid, read_valid, empty, full : OUT STD_LOGIC;
      wr_ptr, rd_ptr : OUT STD_LOGIC_VECTOR(N DOWNTO 0)
    );
  END COMPONENT fifo_ctrl;

  COMPONENT ram IS
    PORT (
      d_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wea, rea : IN STD_LOGIC;
      clka, clkb : IN STD_LOGIC;
      ADDRA, ADDRB : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      d_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
  END COMPONENT ram;

  FOR fifoctrl : fifo_ctrl USE ENTITY WORK.fifo_ctrl(fifo_ctrl_behav);
  FOR ram1 : ram USE ENTITY WORK.ram(behav);

  SIGNAL w_ptr, r_ptr : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL w_valid, r_valid : STD_LOGIC;

BEGIN
  fifoctrl : fifo_ctrl PORT MAP(reset => reset, 
                                rdclk => rclk, 
                                wrclk => wclk, 
                                r_req => rreq, 
                                w_req => wreq, 
                                write_valid => w_valid, 
                                read_valid => r_valid, 
                                empty => empty, 
                                full => full, 
                                wr_ptr => w_ptr, 
                                rd_ptr => r_ptr);

  ram1 : ram PORT MAP(d_in => datain, 
                      wea => w_valid, 
                      rea => r_valid, 
                      clka => wclk, 
                      clkb => rclk, 
                      ADDRA => w_ptr, 
                      ADDRB => r_ptr,
                      d_out => dataout);
END;
-------------------------------------------------------------