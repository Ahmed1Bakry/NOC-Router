----------------------------------------------------------
-- [library declaration] --
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
use ieee.std_logic_misc.or_reduce;
----------------------------------------------------------
-- [entity definition] --
ENTITY router IS
    PORT (
        wclock, rst, rclock : IN STD_LOGIC;
        datai1, datai2, datai3, datai4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr1, wr2, wr3, wr4 : IN STD_LOGIC;
        datao1, datao2, datao3, datao4 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END router;
----------------------------------------------------------
-- [architecture definition] --
ARCHITECTURE routerstruc OF router IS
-- [type, component and signal declarations] --
    TYPE arrayOfVectorsData IS ARRAY(3 DOWNTO 0) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
    TYPE arrayOfVectorsReqs IS ARRAY(3 DOWNTO 0) OF STD_LOGIC_VECTOR (3 DOWNTO 0);

    COMPONENT inputBuffer IS
        PORT (
            data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            clk, eclk, reset : IN STD_LOGIC;
            data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;

    FOR ALL : inputBuffer USE ENTITY WORK.inputBuffer(behav);
    COMPONENT demuxproject IS
        PORT (
            data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            select_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            enable : IN STD_LOGIC;
            d1_out, d2_out, d3_out, d4_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            wr_sel : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    FOR ALL : demuxproject USE ENTITY WORK.demuxproject(behav);

    COMPONENT fifo IS
        PORT (
            reset, rclk, wclk, wreq, rreq : IN STD_LOGIC;
            datain : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            dataout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            empty, full : OUT STD_LOGIC
        );
    END COMPONENT;

    FOR ALL : fifo USE ENTITY WORK.fifo(fifo_struc);

    COMPONENT RoundRobinScheduler IS
        PORT (
            clock, reset : IN STD_LOGIC;
            din1, din2, din3, din4 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            RR : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            dout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT;

    FOR ALL : RoundRobinScheduler USE ENTITY WORK.RoundRobinScheduler(Behavioral);

    SIGNAL ibufout1, ibufout2, ibufout3, ibufout4 : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL dmuxout1, dmuxout2, dmuxout3, dmuxout4 : arrayOfVectorsData;
    SIGNAL writeReqs : arrayOfVectorsReqs;
    SIGNAL fifoOut1, fifoOut2, fifoOut3, fifoOut4 : arrayOfVectorsData;
    SIGNAL readReqs : arrayOfVectorsReqs;
    SIGNAL roundRobinOutput1, roundRobinOutput2, RoundRobinOutput3, RoundRobinOutput4 : STD_LOGIC_VECTOR (7 DOWNTO 0);
BEGIN

    ibuff1 : inputBuffer PORT MAP(datai1, wclock, wr1, rst, ibufout1);
    ibuff2 : inputBuffer PORT MAP(datai2, wclock, wr2, rst, ibufout2);
    ibuff3 : inputBuffer PORT MAP(datai3, wclock, wr3, rst, ibufout3);
    ibuff4 : inputBuffer PORT MAP(datai4, wclock, wr4, rst, ibufout4);

    demux1 : demuxproject PORT MAP(ibufout1, ibufout1(1 DOWNTO 0), wr1, dmuxout1(0), dmuxout1(1), dmuxout1(2), dmuxout1(3), writeReqs(0));
    demux2 : demuxproject PORT MAP(ibufout2, ibufout2(1 DOWNTO 0), wr2, dmuxout2(0), dmuxout2(1), dmuxout2(2), dmuxout2(3), writeReqs(1));
    demux3 : demuxproject PORT MAP(ibufout3, ibufout3(1 DOWNTO 0), wr3, dmuxout3(0), dmuxout3(1), dmuxout3(2), dmuxout3(3), writeReqs(2));
    demux4 : demuxproject PORT MAP(ibufout4, ibufout4(1 DOWNTO 0), wr4, dmuxout4(0), dmuxout4(1), dmuxout4(2), dmuxout4(3), writeReqs(3));
    FG1 : FOR n IN 0 TO 3 GENERATE
        newFIFO : fifo PORT MAP(rst, rclock, wclock, writeReqs(0)(n), readReqs(n)(0), dmuxout1(n), fifoOut1(n), OPEN, OPEN);
    END GENERATE FG1;

    FG2 : FOR n IN 0 TO 3 GENERATE
        newFIFO : fifo PORT MAP(rst, rclock, wclock, writeReqs(1)(n), readReqs(n)(1), dmuxout2(n), fifoOut2(n), OPEN, OPEN);
    END GENERATE FG2;

    FG3 : FOR n IN 0 TO 3 GENERATE
        newFIFO : fifo PORT MAP(rst, rclock, wclock, writeReqs(2)(n), readReqs(n)(2), dmuxout3(n), fifoOut3(n), OPEN, OPEN);
    END GENERATE FG3;

    FG4 : FOR n IN 0 TO 3 GENERATE
        newFIFO : fifo PORT MAP(rst, rclock, wclock, writeReqs(3)(n), readReqs(n)(3), dmuxout4(n), fifoOut4(n), OPEN, OPEN);
    END GENERATE FG4;

    rr1 : RoundRobinScheduler PORT MAP(
        clock => rclock,
        reset => rst,
        din1 => fifoOut1(0),
        din2 => fifoOut2(0),
        din3 => fifoOut3(0),
        din4 => fifoOut4(0),
        RR => readReqs(0),
        dout => roundRobinOutput1);

    rr2 : RoundRobinScheduler PORT MAP(
        clock => rclock,
        reset => rst,
        din1 => fifoOut1(1),
        din2 => fifoOut2(1),
        din3 => fifoOut3(1),
        din4 => fifoOut4(1),
        RR => readReqs(1),
        dout => roundRobinOutput2);

    rr3 : RoundRobinScheduler PORT MAP(
        clock => rclock,
        reset => rst,
        din1 => fifoOut1(2),
        din2 => fifoOut2(2),
        din3 => fifoOut3(2),
        din4 => fifoOut4(2),
        RR => readReqs(2),
        dout => roundRobinOutput3);

    rr4 : RoundRobinScheduler PORT MAP(
        clock => rclock,
        reset => rst,
        din1 => fifoOut1(3),
        din2 => fifoOut2(3),
        din3 => fifoOut3(3),
        din4 => fifoOut4(3),
        RR => readReqs(3),
        dout => roundRobinOutput4);

    obuff1 : inputBuffer PORT MAP(roundRobinOutput1, rclock, or_reduce(readReqs(0)), rst, datao1);
    obuff2 : inputBuffer PORT MAP(roundRobinOutput2, rclock, or_reduce(readReqs(1)), rst, datao2);
    obuff3 : inputBuffer PORT MAP(roundRobinOutput3, rclock, or_reduce(readReqs(2)), rst, datao3);
    obuff4 : inputBuffer PORT MAP(roundRobinOutput4, rclock, or_reduce(readReqs(3)), rst, datao4);

END;
----------------------------------------------------------