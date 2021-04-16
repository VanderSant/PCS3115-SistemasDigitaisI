------------------------------------------------------
--! @file um_detector.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

entity um_detector is
    port (
      A    : in  bit_vector(7 downto 0);
      UM : out bit
      );
  end entity;

  architecture when_else_arch of um_detector is
    begin
      UM   <= '1' when A = "00000001" else
              '0';
    end architecture;