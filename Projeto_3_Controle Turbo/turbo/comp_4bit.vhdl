------------------------------------------------------
--! @file comp_4bit.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

entity comp_4bit is
port(
  A            : in bit_vector(3 downto 0);
  B            : in bit_vector(3 downto 0);
  GreaterEqual : out bit
);
end entity comp_4bit;

architecture arch of comp_4bit is
    signal Equal : bit;
    signal Greater : bit;
    signal xor0,  xor1,  xor2,  xor3 : bit;
    signal and0,  and1,  and2,  and3 : bit;

    begin
        xor0  <= (A(0)xor(not B(0)));
        xor1  <= (A(1)xor(not B(1)));
        xor2  <= (A(2)xor(not B(2)));
        xor3  <= (A(3)xor(not B(3)));

        and0  <= (A(0) and (not B(0)) and xor3 and xor2 and xor1);
        and1  <= (A(1) and (not B(1)) and xor3 and xor2);
        and2  <= (A(2) and (not B(2)) and xor3);
        and3  <= (A(3) and (not B(3)) );



        Equal <= (xor0 and xor1 and xor2 and xor3 );

        Greater <= ( and0 or and1 or and2 or and3);
        
        GreaterEqual <= Greater or Equal;

    end architecture arch;