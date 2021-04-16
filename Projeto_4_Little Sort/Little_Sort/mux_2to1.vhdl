entity mux_2to1 is
    port 
    (
      SEL : in  bit;    
      A :   in  bit;
      B :   in  bit;
      Y :   out bit
    );
  end entity;
  
  architecture with_select of mux_2to1 is
  begin
    with SEL select
      Y <= A when '0',
           B when '1',
           '0' when others;
  end architecture;