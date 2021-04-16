library ieee;
use ieee.numeric_bit.all;

entity cont4 is
    port
    (
        clock, clear, enable: in bit;
        Q:                    out bit_vector (3 downto 0);
        rco:                  out bit
    );
end entity;

architecture comportamental of cont4 is

  signal IQ: integer range 0 to 15;

begin
  
  process (clock,clear,enable,IQ)
  begin
    if clear = '1' then IQ <= 0;   
    elsif clock'event and clock='1' then
      if enable = '1' then 
        if IQ = 15 then IQ <= 0; 
        else            IQ <= IQ + 1; 
        end if;
      end if;
    end if;
    
    Q <= bit_vector(to_unsigned(IQ, Q'length)); 

    if IQ=15 then rco <= '1'; 
    else          rco <= '0'; 
    end if;
        
  end process;

end architecture;