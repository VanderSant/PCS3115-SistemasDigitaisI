------------------------------------------------------
--! @file turbo.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

entity turbo is
    port (
      clock, reset: in bit; 	
      button: in bit_vector(7 downto 0);
      sensib: in bit_vector(3 downto 0);
      cmd: out bit_vector(7 downto 0)		
    );
  end entity;

architecture arch_turbo of turbo is
    component turboUC is
      port(
        clock, reset  : in bit;
        eq0           : in bit;
        d0            : in bit;
        me0           : in bit;
        RSTr, CEr     : out bit;
        Zr            : out bit;
        DLcmd         : out bit;
        RSTco, CEco   : out bit;
        Zco           : out bit

      );
      end component turboUC;

      component turboFD is
        port(
          button        : in bit_vector(7 downto 0);
          sensib        : in bit_vector(3 downto 0);
          clock         : in bit;	
          RSTr, CEr     : in bit;
          Zr            : in bit;
          DLcmd         : in bit;
          RSTco, CEco   : in bit;
          Zco           : in bit;
          eq0           : out bit;
          d0            : out bit;
          me0           : out bit;
          cmd           : out bit_vector(7 downto 0)
        );
        end component turboFD;

        signal s_rstr, s_cer      : bit;
        signal s_zr               : bit;
        signal s_rstco, s_ceco    : bit;
        signal s_zco              : bit;
        signal s_dlcmd            : bit;
        signal s_eq0, s_d0, s_me0 : bit;
        signal s_clock_n          : bit;

        begin

          s_clock_n <= not clock;

          TURBOUC1: turboUC port map(
            clock  => clock,
            reset  => reset,
            eq0    => s_eq0,       
            d0     => s_d0,       
            me0    => s_me0,       
            RSTr   => s_rstr,
            CEr    => s_cer, 
            Zr     => s_zr,
            DLcmd => s_dlcmd,
            RSTco  => s_rstco,
            CEco   => s_ceco,
            Zco    => s_zco

          );

          TURBOFD1: turboFD port map(
            clock  => s_clock_n,        
            button => button,
            sensib => sensib,
            RSTr   => s_rstr,
            CEr    => s_cer,
            Zr     => s_zr,
            dlcmd  => s_dlcmd,
            RSTco  => s_rstco,
            CEco   => s_ceco,
            Zco    => s_zco,
            eq0    => s_eq0,
            d0     => s_d0,
            me0    => s_me0,
            cmd    => cmd

          );

  end architecture arch_turbo;

  