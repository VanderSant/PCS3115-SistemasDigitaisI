------------------------------------------------------
--! @file turboFD.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

entity turboFD is
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
    end entity turboFD;

    architecture arch_turboFD of turboFD is

          component fa_4bit is
            port (
              A,B  : in  bit_vector(3 downto 0);
              CIN  : in  bit;
              SUM  : out bit_vector(3 downto 0);
              COUT : out bit
              );
          end component;

          component mux8_2to1 is
            port (
              SEL : in bit;    
              A :   in bit_vector  (7 downto 0);
              B :   in bit_vector  (7 downto 0);
              Y :   out bit_vector (7 downto 0)
              );
          end component mux8_2to1;

          component comp_4bit is
            port(
              A            : in bit_vector(3 downto 0);
              B            : in bit_vector(3 downto 0);
              GreaterEqual : out bit
            );
            end component comp_4bit;

            component reg4 is
                port (
                  clock, reset, enable: in bit;
                  Z: in bit;
                  D: in  bit_vector(3 downto 0);
                  Q: out bit_vector(3 downto 0)
                );
            end component;

            component reg8 is
                port (
                  clock, reset, enable: in bit;
                  Z: in bit;
                  D: in  bit_vector(7 downto 0);
                  Q: out bit_vector(7 downto 0)
                );
            end component;

            component equal_detector is
                port(
                    A  : in bit_vector (7 downto 0);
                    B  : in bit_vector (7 downto 0);
                    EQ : out bit
                );
            end component equal_detector;

            component zero_detector is
                port (
                  A    : in  bit_vector(7 downto 0);
                  zero : out bit
                  );
              end component zero_detector;

            signal s_rr, s_rcmd : bit_vector(7 downto 0);
            signal s_rco        : bit_vector(3 downto 0);
            signal comais1      : bit_vector(3 downto 0);

            begin
                RREG: reg8 port map(
                    clock  => clock,
                    reset  => RSTr,
                    enable => CEr,
                    Z      => Zr,
                    D      => button,
                    Q      => s_rr
                );


                MUXCMD: mux8_2to1 port map(
                    SEL => DLcmd,
                    A   => "00000000",
                    B   => button,
                    Y   => s_rcmd
                );

                RCO: reg4 port map(
                    clock  => clock,
                    reset  => RSTco,
                    enable => CEco,
                    Z      => Zco,
                    D      => comais1,
                    Q      => s_rco
                );

                ADDER1: fa_4bit port map(
                      A => "0001",
                      B => s_rco,
                      CIN => '0',
                      SUM => comais1,
                      COUT => open
                      );

                COMP4: comp_4bit port map(
                    A            => s_rco,
                    B            => sensib,
                    GreaterEqual => me0
                );
                EQUAL2: equal_detector port map(
                    A  => s_rr,
                    B  => button,
                    EQ => eq0
                );
                
                ZERO: zero_detector port map(
                      A    =>button,
                      zero =>d0
                      );

                  cmd <= s_rcmd;

        end architecture arch_turboFD;