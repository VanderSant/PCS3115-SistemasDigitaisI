------------------------------------------------------
--! @file reg16.vhdl
--! @brief 16 bits register
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

library ieee;
use ieee.numeric_bit.rising_edge;

entity reg16 is
    port (
      clock, reset, enable: in bit;
      D: in  bit_vector(15 downto 0);
      Q: out bit_vector(15 downto 0)
    );
end entity;

architecture arch_reg16 of reg16 is
    signal dado: bit_vector(15 downto 0);
  begin
    process(clock, reset)
    begin
      if reset = '1' then
        dado <= (others=>'0');
      elsif (rising_edge(clock)) then
        if enable='1' then
          dado <= D;
        end if;
      end if;
    end process;            
    Q <= dado;
end architecture;