library ieee;
use ieee.numeric_bit.rising_edge;

entity resto is
    port(
    clock, reset : in bit;
    inicio : in bit;
    fim : out bit;
    dividendo , divisor : in bit_vector(15 downto 0);
    resto : out bit_vector(15 downto 0)
    );
end resto ;
    
    architecture structural of resto is
        component resto_uc
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
        end component resto_uc;

        component resto_fd
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
        end component resto_fd;

        signal s_rsta, s_cea : bit;
        signal s_rstb, s_ceb : bit;
        signal s_dcb         : bit;
        signal s_rstr, s_cer : bit;
        signal s_dcr         : bit;
        signal s_zr          : bit;
        signal s_clock_n     : bit;

        begin
            s_clock_n <= not clock;

            RESTO1_UC : resto_uc port map(
                Clock  => clock,
                Reset  => reset,
                Inicio => inicio,
                Fim    => fim,
                RSTa   => s_rsta,
                CEa    => s_cea, 
                RSTb   => s_rstb,
                CEb    => s_ceb,
                DCb    => s_dcb,      
                RSTr   => s_rstr,
                CEr    => s_cer,
                DCr    => s_dcr,     
                zr     => s_zr      
            );

            RESTO1_FD : resto_fd port map(
                Clock     => s_clock_n,
                dividendo => dividendo,
                divisor   => divisor,
                RSTa      => s_rsta,
                CEa       => s_cea, 
                RSTb      => s_rstb,
                CEb       => s_ceb,
                DCb       => s_dcb,      
                RSTr      => s_rstr,
                CEr       => s_cer,
                DCr       => s_dcr,   
                zr        => s_zr,
                Resto     => resto
            );
    
    end architecture structural;