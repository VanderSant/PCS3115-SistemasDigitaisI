
entity zero_detector is
    port (
      A    : in  bit_vector(15 downto 0);
      zero : out bit
      );
  end entity;

  architecture when_else_arch of zero_detector is
    begin
      ZERO <= '1' when A = "0000000000000000" else
              '0';
    end architecture;