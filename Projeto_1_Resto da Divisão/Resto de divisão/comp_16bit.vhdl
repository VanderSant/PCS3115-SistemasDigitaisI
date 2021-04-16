------------------------------------------------------
--! @file comp_16bit.vhdl
--! @brief 16 bits comparator
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

library ieee;
use ieee.numeric_bit.rising_edge;

entity comp_16bit is
port(
  A            : in bit_vector(15 downto 0);
  B            : in bit_vector(15 downto 0);
  GreaterEqual : out bit
);
end entity comp_16bit;

architecture arch of comp_16bit is
    signal Equal : bit;
    signal Greater : bit;
    signal xor0,  xor1,  xor2,  xor3,
           xor4,  xor5,  xor6,  xor7,
           xor8,  xor9,  xor10, xor11,
           xor12, xor13, xor14, xor15 : bit;
    signal and0,  and1,  and2,  and3, 
           and4,  and5,  and6,  and7,
           and8,  and9,  and10, and11,
           and12, and13, and14, and15 : bit;

    begin
        xor0  <= (A(0)xor(not B(0)));
        xor1  <= (A(1)xor(not B(1)));
        xor2  <= (A(2)xor(not B(2)));
        xor3  <= (A(3)xor(not B(3)));
        xor4  <= (A(4)xor(not B(4)));
        xor5  <= (A(5)xor(not B(5)));
        xor6  <= (A(6)xor(not B(6)));
        xor7  <= (A(7)xor(not B(7)));
        xor8  <= (A(8)xor(not B(8)));
        xor9  <= (A(9)xor(not B(9)));
        xor10 <= (A(10)xor(not B(10)));
        xor11 <= (A(11)xor(not B(11)));
        xor12 <= (A(12)xor(not B(12)));
        xor13 <= (A(13)xor(not B(13)));
        xor14 <= (A(14)xor(not B(14)));
        xor15 <= (A(15)xor(not B(15)));

        and0  <= (A(0) and (not B(0)) and xor15 and xor14 and xor13 and xor12 and xor11 and xor10
                 and xor9 and xor8 and xor7 and xor6 and xor5 and xor4 and xor3 and xor2 and xor1);
        and1  <= (A(1) and (not B(1)) and xor15 and xor14 and xor13 and xor12 and xor11 and xor10
                 and xor9 and xor8 and xor7 and xor6 and xor5 and xor4 and xor3 and xor2);
        and2  <= (A(2) and (not B(2)) and xor15 and xor14 and xor13 and xor12 and xor11 and xor10
                 and xor9 and xor8 and xor7 and xor6 and xor5 and xor4 and xor3);
        and3  <= (A(3) and (not B(3)) and xor15 and xor14 and xor13 and xor12 and xor11 and xor10
                 and xor9 and xor8 and xor7 and xor6 and xor5 and xor4);
        and4  <= (A(4) and (not B(4)) and xor15 and xor14 and xor13 and xor12 and xor11 and xor10
                 and xor9 and xor8 and xor7 and xor6 and xor5);
        and5  <= (A(5) and (not B(5)) and xor15 and xor14 and xor13 and xor12 and xor11 and xor10
                  and xor9 and xor8 and xor7 and xor6);
        and6  <= (A(6) and (not B(6)) and xor15 and xor14 and xor13 and xor12 and xor11 and xor10
                 and xor9 and xor8 and xor7);
        and7  <= (A(7) and (not B(7)) and xor15 and xor14 and xor13 and xor12 and xor11 and xor10
                 and xor9 and xor8);
        and8  <= (A(8) and (not B(8)) and xor15 and xor14 and xor13 and xor12 and xor11 and xor10
                 and xor9);
        and9  <= (A(9) and (not B(9)) and xor15 and xor14 and xor13 and xor12 and xor11 and xor10);
        and10 <= (A(10) and (not B(10)) and xor15 and xor14 and xor13 and xor12 and xor11);
        and11 <= (A(11) and (not B(11)) and xor15 and xor14 and xor13 and xor12);
        and12 <= (A(12) and (not B(12)) and xor15 and xor14 and xor13);
        and13 <= (A(13) and (not B(13)) and xor15 and xor14);
        and14 <= (A(14) and (not B(14)) and xor15 );
        and15 <= (A(15) and (not B(15))) ; 


        Equal <= (xor0 and xor1 and xor2 and xor3 and xor4 and xor5 and xor6 and xor7 and 
                  xor8 and xor9 and xor10 and xor11 and xor12 and xor13 and xor14 and xor15 );

        Greater <= ( and0 or and1 or and2 or and3 or and4 or and5 or and6 or and7 or and8 or
                     and9 or and10 or and11 or and12 or and13 or and14 or and15);
        
        GreaterEqual <= Greater;

    end architecture arch;