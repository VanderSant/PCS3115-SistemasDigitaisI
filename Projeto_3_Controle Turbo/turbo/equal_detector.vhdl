entity equal_detector is
    port(
        A  : in bit_vector (7 downto 0);
        B  : in bit_vector (7 downto 0);
        EQ : out bit
    );
end entity equal_detector;

architecture arch_equal of equal_detector is
    signal Equal : bit;
    signal xor0, xor1, xor2, xor3,
           xor4, xor5, xor6, xor7: bit;

    begin
        xor0  <= (A(0) xor (not B(0)) );
        xor1  <= (A(1) xor (not B(1)) );
        xor2  <= (A(2) xor (not B(2)) );
        xor3  <= (A(3) xor (not B(3)) );
        xor4  <= (A(4) xor (not B(4)) );
        xor5  <= (A(5) xor (not B(5)) );
        xor6  <= (A(6) xor (not B(6)) );
        xor7  <= (A(7) xor (not B(7)) );

        Equal <= xor0 and xor1 and xor2 and xor3 and xor4 and xor5 and xor6 and xor7;
        EQ <= Equal;

end architecture arch_equal;