entity comp4 is
    port 
    (
        A, B:               in  bit_vector (3 downto 0);
        igual, diferente:   out bit;
        maior, maior_igual: out bit; 
        menor, menor_igual: out bit
    );
end entity;

architecture comportamental of comp4 is
begin
  process (A, B)
    begin
      igual<= '0'; diferente<= '0'; maior<= '0'; 
      maior_igual<= '0'; menor <= '0'; menor_igual <= '0'; 

      if A = B  then igual<= '1';        end if;
      if A /= B then diferente<= '1';    end if;
      if A > B  then maior<= '1';        end if;
      if A >= B then maior_igual<= '1';  end if;
      if A < B  then menor <= '1';       end if;
      if A <= B then menor_igual <= '1'; end if;
  end process;
  
end architecture;