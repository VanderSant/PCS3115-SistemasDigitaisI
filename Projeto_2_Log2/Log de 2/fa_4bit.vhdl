------------------------------------------------------
--! @file fa_4bit.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

library ieee;
use ieee.numeric_bit.all;

entity fa_4bit is
    port (
      A,B  : in  bit_vector(3 downto 0);
      CIN  : in  bit;
      SUM  : out bit_vector(3 downto 0);
      COUT : out bit
      );
  end entity;

  architecture ripple of fa_4bit is

      component fa_1bit
        port (
          A, B : in  bit;   -- adends
          CIN  : in  bit;   -- carry-in
          SUM  : out bit;   -- sum
          COUT : out bit    -- carry-out
        );
      end component fa_1bit;
    
      signal x,y    : bit_vector(3 downto 0);
      signal s      : bit_vector(3 downto 0);
      signal cin0   : bit;
      signal cout0  : bit;  
      signal cout1  : bit;
      signal cout2  : bit;
      signal cout3  : bit;
      
    begin
      
      ADDER0: fa_1bit port map (
        A => x(0),
        B => y(0),
        CIN => cin0,
        SUM => s(0),
        COUT => cout0
        );
    
      ADDER1: fa_1bit port map (
        A => x(1),
        B => y(1),
        CIN => cout0,
        SUM => s(1),
        COUT => cout1
        );
    
      ADDER2: fa_1bit port map (
        A => x(2),
        B => y(2),
        CIN => cout1,
        SUM => s(2),
        COUT => cout2
        );  
    
      ADDER3: fa_1bit port map (
        A => x(3),
        B => y(3),
        CIN => cout2,
        SUM => s(3),
        COUT => cout3
        );
        
      x <= A;
      y <= B;
      cin0 <= CIN;
      SUM <= s;
      COUT <= cout3;
      
    end architecture ripple;