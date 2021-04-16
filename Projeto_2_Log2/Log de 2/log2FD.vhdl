------------------------------------------------------
--! @file log2FD.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

entity log2FD is
    port(
        N       : in bit_vector(7 downto 0);
        clock     : in bit;
        RSTn, CEn : in bit;
        DCn,Dn    : in bit;
        RSTd, CEd : in bit;
        RSTl, CEl : in bit;
        DCl       : in bit;
        d0        : out bit;
        d1        : out bit;
        logval : out bit_vector(3 downto 0)
    );
  end entity log2FD;
  
  architecture arch_log2FD of log2FD is
  
    component fa_1bit is
        port (
          A,B : in bit;       -- adends
          CIN : in bit;       -- carry-in
          SUM : out bit;      -- sum
          COUT : out bit      -- carry-out
          );
      end component fa_1bit;
  
    component fa_4bit is
        port (
          A,B  : in  bit_vector(3 downto 0);
          CIN  : in  bit;
          SUM  : out bit_vector(3 downto 0);
          COUT : out bit
          );
    end component fa_4bit;
  
    component zero_detector is
        port (
          A    : in  bit_vector(7 downto 0);
          zero : out bit
          );
      end component zero_detector;
  
    component um_detector is
        port (
          A    : in  bit_vector(7 downto 0);
          UM : out bit
          );
    end component um_detector;
  
    component reg4 is
        port (
          clock, reset, enable: in bit;
          D: in  bit_vector(3 downto 0);
          Q: out bit_vector(3 downto 0)
        );
    end component reg4;
  
    component reg8desl is
        port (
          clock, reset, enable, deslocar: in bit;
          D: in  bit_vector(7 downto 0);
          Q: out bit_vector(7 downto 0)
        );
    end component reg8desl;
  
    component mux4_2to1 is
        port (
          SEL : in bit;    
          A :   in bit_vector  (3 downto 0);
          B :   in bit_vector  (3 downto 0);
          Y :   out bit_vector (3 downto 0)
          );
      end component mux4_2to1;
  
    component mux8_2to1 is
        port (
          SEL : in bit;    
          A :   in bit_vector  (7 downto 0);
          B :   in bit_vector  (7 downto 0);
          Y :   out bit_vector (7 downto 0)
          );
    end component mux8_2to1;
  
      signal s_rn           : bit_vector(7 downto 0); 
      signal s_rd, s_rl     : bit_vector(3 downto 0);
      signal s_muxn         : bit_vector(7 downto 0);
      signal s_muxl, dmais1 : bit_vector(3 downto 0);
  
      begin
        RN: reg8desl port map(
            clock => clock,
            reset => RSTn,
            enable => CEn,
            deslocar => Dn,
            D => s_muxn,
            Q => s_rn
        );
  
        RD: reg4 port map(
            clock => clock,
            reset => RSTd,
            enable => CEd,
            D=> dmais1,
            Q=> s_rd
        );
  
        RL: reg4 port map(
            clock => clock,
            reset => RSTl,
            enable => CEl,
            D=> s_muxl,
            Q=> s_rl
        );
  
        ADDER1: fa_4bit port map(
            A => "0001",
            B => s_rd,
            CIN => '0',
            SUM => dmais1,
            COUT => open
        );
  
        MUXN: mux8_2to1 port map(
            SEL => DCn,
            A => N,
            B => s_rn,
            Y => s_muxn 
        );
  
        MUXL: mux4_2to1 port map(
            SEL => DCl,
            A =>  s_rd,
            B => "1111",
            Y => s_muxl 
        );
  
        ZERO: zero_detector port map(
            A    =>s_rn,
            zero =>d0
        );
  
        UM: um_detector port map(
            A  => s_rn,
            um => d1
        );
        logval <=s_rl;
    end architecture arch_log2FD;
  