entity littleSort_fd is
    port 
    ( 
      clock:             in  bit;
      zera_j:            in  bit;  -- sinais de controle
      conta_j:           in  bit;
      selEnd:            in  bit;
      selDado:           in  bit;
      we_mem:            in  bit;
      apaga_regJ:        in  bit;
      carrega_regJ:      in  bit;
      apaga_regJmais1:   in  bit;
      carrega_regJmais1: in  bit;
      fim_j:             out bit;  -- sinais de condicao
      maior:             out bit;
      mem_we:            out bit;  -- interface com memoria externa
      mem_endereco:      out bit_vector(3 downto 0);
      mem_dado_write:    out bit_vector(3 downto 0);
      mem_dado_read:     in  bit_vector(3 downto 0)
    );
  end entity;
  
  architecture estrutural of littleSort_fd is

    component cont4 is
      port
      (
          clock, clear, enable: in bit;
          Q:                    out bit_vector (3 downto 0);
          rco:                  out bit
      );
  end component;

  component fa_1bit is
    port
    (
      A,B  : in  bit;     -- adends
      CIN  : in  bit;     -- carry-in
      SUM  : out bit;     -- sum
      COUT : out bit      -- carry-out
    );
end component;

  component fa_4bit is
  port 
  (
      A,B :  in  bit_vector(3 downto 0);  -- adends
      CIN :  in  bit;                     -- carry-in
      SUM :  out bit_vector(3 downto 0);  -- sum
      COUT : out bit                      -- carry-out
  );
end component;

component mux4_2to1 is
  port 
  (
    SEL : in  bit;    
    A :   in  bit_vector (3 downto 0);
    B :   in  bit_vector (3 downto 0);
    Y :   out bit_vector (3 downto 0)
  );
end component mux4_2to1;

component reg4 is
  port 
  (
      clock, reset, enable: in  bit;
      D:                    in  bit_vector(3 downto 0);
      Q:                    out bit_vector(3 downto 0)
  );
end component;

component comp4 is
  port 
  (
      A, B:               in  bit_vector (3 downto 0);
      igual, diferente:   out bit;
      maior, maior_igual: out bit; 
      menor, menor_igual: out bit
  );
end component;

signal s_rj, s_rjmais1: bit_vector(3 downto 0);
signal s_rrj, s_rrjmais1: bit_vector(3 downto 0);

begin

  RJ: reg4 port map(
      clock   => clock, 
      reset   => zera_j,
      enable  => conta_j,
      D       =>s_rjmais1,
      Q       => s_rj
  );

  ADDER1: fa_4bit port map(
      A => "0001",
      B => s_rj,
      CIN => '0',
      SUM => s_rjmais1,
      COUT => open
    );

  COMP40: comp4 port map(
      A           => s_rj,
      B           => "1111",            
      igual       => open, 
      diferente   => open,
      maior       => open, 
      maior_igual => fim_j,
      menor       => open, 
      menor_igual => open
  );

  MUX4: mux4_2to1 port map(
      SEL => selEnd,
      A   => s_rj,
      B   => s_rjmais1,
      Y   => mem_endereco
  );

  RJ1: reg4 port map(
      clock   => clock, 
      reset   => apaga_regJ,
      enable  => carrega_regJ,
      D       => mem_dado_read,
      Q       => s_rrj
  );

  RJMAIS1: reg4 port map(
      clock   => clock, 
      reset   => apaga_regJmais1,
      enable  => carrega_regJmais1,
      D       => mem_dado_read,
      Q       => s_rrjmais1 
  );

  COMP4J: comp4 port map(
      A           => s_rrj,
      B           => s_rrjmais1,            
      igual       => open, 
      diferente   => open,
      maior       => maior, 
      maior_igual => open,
      menor       => open, 
      menor_igual => open
  );

  MUX41: mux4_2to1 port map(
      SEL => selDado,
      A   => s_rrj,
      B   => s_rrjmais1,
      Y   => mem_dado_write
  );

  mem_we <= we_mem;

  
    -- <coloque aqui os componentes internos do projeto>
    -- <seguindo uma descricao do tipo estrutural>
    
    -- sinais para interface com a memoria externa
    -- <coloque aqui os comandos para a especificacao dos>
    -- <sinais de interface com a memoria externa>
  
  end architecture;