------------------------------------------------------
--! @file log2.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

entity log2 is
    port (
      clock, reset: in bit;       
      start: in bit;            
      ready: out bit;           
      N: in bit_vector(7 downto 0);   
      logval: out bit_vector(3 downto 0)  
    );
  end entity log2;
  
      architecture arch_log2 of log2 is
          Component log2UC is
              port(
                  clock     : in bit;
                  reset     : in bit;
                  start    : in bit;
                  d0        : in bit;
                  d1        : in bit;
                  ready       : out bit;
                  RSTn, CEn : out bit;
                  DCn, Dn   : out bit;
                  RSTd, CEd : out bit;
                  RSTl, CEl : out bit;
                  DCl       : out bit
              );
  
          end Component log2UC;
          
          component log2FD is
              port(
                  N       : in bit_vector(7 downto 0);
                  clock     : in bit;
                  RSTn, CEn : in bit;
                  DCn, Dn   : in bit;
                  RSTd, CEd : in bit;
                  RSTl, CEl : in bit;
                  DCl       : in bit;
                  d0        : out bit;
                  d1        : out bit;
                  logval : out bit_vector(3 downto 0)
              );
          end component log2FD;
  
          signal s_rstn, s_cen : bit;
          signal s_dcn, s_dn   : bit;
          signal s_rstd, s_ced : bit;
          signal s_rstl, s_cel : bit;
          signal s_dcl         : bit;
          signal s_d0, s_d1    : bit;
          signal s_clock_n     : bit;
  
          begin
              s_clock_n <= not clock;
  
              LOG2UC1: log2UC port map(
                  clock  => clock,  
                  reset  => reset,
                  start => start,
                  d0     => s_d0,
                  d1     => s_d1,
                  ready    => ready,
                  RSTn   => s_rstn,
                  CEn    => s_cen,
                  DCn    => s_dcn,
                  Dn     => s_dn,
                  RSTd   => s_rstd,
                  CEd    => s_ced,
                  RSTl   => s_rstl,
                  CEl    => s_cel,
                  DCl    => s_dcl
              );
  
              LOG2FD1: log2FD port map(
                  N       => N,
                  clock     => s_clock_n,
                  RSTn      => s_rstn,
                  CEn       => s_cen,
                  DCn       => s_dcn,
                  Dn        => s_dn,
                  RSTd      => s_rstd,
                  CEd       => s_ced,
                  RSTl      => s_rstl,
                  CEl       => s_cel,
                  DCl       => s_dcl,
                  d0        => s_d0,
                  d1        => s_d1,
                  logval => logval
              );

    end architecture arch_log2;
  