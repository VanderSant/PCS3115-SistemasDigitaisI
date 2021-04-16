------------------------------------------------------
--! @file resto_uc.vhdl
--! @brief resto control unit
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

library ieee;
use ieee.numeric_bit.rising_edge;

entity resto_uc is
    port(
        Clock    : in bit;
        Reset    : in bit;
        Inicio   : in bit;
        zr       : in bit;
        Fim      : out bit;
        RSTa,CEa : out bit;
        RSTb,CEb : out bit;
        DCb      : out bit; 
        RSTr,CEr : out bit;
        DCr      : out bit
        );

end entity resto_uc;

architecture fsm of resto_uc is
    type state_t is (wait1,x1,x2, fins);
    signal next_state, current_state: state_t;
    begin
        fsm: process (clock, reset)
           begin
            if Reset= '1' then current_state <= wait1;
            elsif (rising_edge(clock)) then
                current_state <= next_state;
            end if;
        end process;
        
        next_state <=
           wait1 when (current_state = wait1) and (Inicio = '0') else
           x1    when (current_state = wait1) and (Inicio = '1') else
           x2    when (current_state = x1)    and (zr = '0') else
           fins  when (current_state = x1)    and (zr = '1') else
           x2    when (current_state = x2)    and (zr = '0') else
           fins  when (current_state = x2)    and (zr = '1') else
           wait1 when (current_state = fins) else
           wait1;
   
        RSTa   <= '1' when current_state=wait1 else '0';
        CEa    <= '1' when current_state=x1 else '0';
        RSTb   <= '1' when current_state=wait1 else '0';
        CEb    <= '1' when current_state=x1 or current_state=x2 else '0';
        DCb    <= '1' when current_state=x2 else '0';
        RSTr   <= '1' when current_state=wait1 else '0';
        CEr    <= '1' when current_state=x1 or current_state=x2 else '0';
        DCr    <= '1' when current_state=x1 else '0';    

        Fim    <= '1' when current_state=fins else '0';

    end architecture fsm;