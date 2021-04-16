library ieee;
use ieee.numeric_bit.all;

entity reg8desl is
    port (
      clock, reset, enable, deslocar: in bit;
      D: in  bit_vector(7 downto 0);
      Q: out bit_vector(7 downto 0)
    );
end entity;

architecture arch_reg4 of reg8desl is
    signal dado: bit_vector(7 downto 0);
  begin
    process(clock, reset)
    begin
      if reset = '1' then
        dado <= (others=>'0');
      elsif (clock'event and clock='1') then
        if enable='1' then
          dado <= D;
        end if;
        if(deslocar ='1') then
            dado(0) <= D(1);
            dado(1) <= D(2);
            dado(2) <= D(3);
            dado(3) <= D(4); 
            dado(4) <= D(5);
            dado(5) <= D(6);
            dado(6) <= D(7);
            dado(7) <= '0';
        end if;
      end if;
    end process;            
    Q <= dado;
end architecture;
