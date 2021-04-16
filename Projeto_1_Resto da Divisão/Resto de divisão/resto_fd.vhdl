------------------------------------------------------
--! @file resto_fd.vhdl
--! @brief resto data flow
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

library ieee;
use ieee.numeric_bit.rising_edge;

entity resto_fd is
    port(
        dividendo : in bit_vector(15 downto 0);
        divisor   : in bit_vector(15 downto 0);
        Clock     : in bit;
        RSTa,CEa  : in bit;
        RSTb,CEb  : in bit;
        DCb       : in bit; 
        RSTr,CEr  : in bit;
        DCr       : in bit;
        zr        : out bit;
        Resto     : out bit_vector(15 downto 0)
        );
end entity resto_fd;

architecture structural of resto_fd is

    component reg16
    port (
      clock, reset, enable: in bit;
      D: in  bit_vector(15 downto 0);
      Q: out bit_vector(15 downto 0)
    );
    end component reg16;


    component mux16_2to1
     port (
      SEL : in bit;    
      A :   in bit_vector  (15 downto 0);
      B :   in bit_vector  (15 downto 0);
      Y :   out bit_vector (15 downto 0)
    );
    end component mux16_2to1;


    component fa_16bit
     port (
      A,B  : in  bit_vector(15 downto 0);
      CIN  : in  bit;
      SUM  : out bit_vector(15 downto 0);
      COUT : out bit
      );
    end component fa_16bit;


    component zero_detector
     port (
      A    : in bit_vector(15 downto 0);
      zero : out bit
     );
    end component;


    component f_or
     port(
        A    : in bit;
        B    : in bit;
        C    : out bit
     );
    end component f_or;


    component comp_16bit
      port(
        A            : in bit_vector(15 downto 0);
        B            : in bit_vector(15 downto 0);
        GreaterEqual : out bit
      );
    end component comp_16bit;

    signal s_ra, s_rb, s_rr, s_ira : bit_vector(15 downto 0);
    signal s_bmenosa, s_muxb, s_muxr : bit_vector(15 downto 0);
    signal dz, GreEqu : bit;

    begin
      s_ira <= not s_ra;
      RA: reg16 port map(
        clock => clock,
        reset => RSTa,
        enable => CEa,
        D=> divisor,
        Q=> s_ra
      );

      RB: reg16 port map(
        clock=>  clock, 
        reset=>  RSTb, 
        enable=> CEb,
        D => s_muxb,
        Q => s_rb
      );

      RR: reg16 port map (
        clock=>  clock, 
        reset=>  RSTr, 
        enable=> CEr,
        D=>      s_muxr,
        Q=>      s_rr
      );

      SUB1: fa_16bit port map(
        A => s_rb,
        B => s_ira,
        CIN => '1',
        SUM => s_bmenosa,
        COUT => open
      );

      MUXB: mux16_2to1 port map(
        SEL => DCb,
        A => dividendo,
        B => s_muxr,
        Y => s_muxb 
      );

      MUXR: mux16_2to1 port map(
        SEL => DCr,
        A => s_bmenosa,
        B => dividendo,
        Y => s_muxr
      );

      ZERO: zero_detector port map(
        A => s_ra,
        zero => dz
      );

      COMPAR: comp_16bit port map(
        A => s_ra,
        B => s_rb,
        GreaterEqual => GreEqu
      );

      ZR1: f_or port map (
        A => dz,
        B => GreEqu,
        C => zr
      );
      
      Resto <= s_rr;
    
end architecture structural;