------------------------------------------------------
--! @file reg8.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

entity reg8 is
    port (
      clock, reset, enable: in bit;
      Z: in bit;
      D: in  bit_vector(7 downto 0);
      Q: out bit_vector(7 downto 0)
    );
end entity;

architecture arch_reg8 of reg8 is
    signal dado: bit_vector(7 downto 0);
  begin
    process(clock, reset)
    begin
      if reset = '1' then
        dado <= (others=>'0');
      elsif (clock'event and clock='1') then
        if (Z = '1') then
         dado <= "00000000";
        end if;

        if enable='1' then
          dado <= D;
        end if;
      end if;
    end process;            
    Q <= dado;
end architecture;