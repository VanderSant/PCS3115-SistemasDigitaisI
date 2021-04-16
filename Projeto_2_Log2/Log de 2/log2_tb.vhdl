------------------------------------------------------
--! @file log2_tb.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

library ieee;
use ieee.numeric_bit.all;

entity log2_tb is
    end entity log2_tb;

architecture tb of log2_tb is
    component log2 is
        port (
          clock, reset: in bit;				
          start: in bit;						
          ready: out bit;						
          N: in bit_vector(7 downto 0);		
          logval: out bit_vector(3 downto 0)	
        );
      end component log2;

      signal clk_in: bit := '0';
      signal rst_in, start_in, ready_out: bit := '0';
      signal N_in: bit_vector(7 downto 0);
      signal logval_out: bit_vector(3 downto 0);

      signal keep_simulating: bit := '0';
      constant clockPeriod : time := 1 ns;

      begin

        clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;

        dut: log2 port map(
          clock  => clk_in,
          reset	 =>	rst_in,
          start	 =>	start_in,				
          ready	 =>	ready_out,				
          N	     => N_in,
          logval =>	logval_out
        );

        stimulus: process is
            begin
                assert false report "simulation start" severity note;
                keep_simulating <= '1';

                -----------------------------------------------------------------------------------------------
                ---- Caso de teste 0: N=1,
                N_in <= "00000001";
                -- pulso do sinal de Start
                wait until (clk_in'event and clk_in='1');
                start_in <= '1';
                wait until (clk_in'event and clk_in='1');
                start_in <= '0';
                -- espera pelo termino da multiplicacao
                wait until ready_out='1';
                -- verifica resultado
                assert (logval_out/="0000") report "1.OK: log=0000 (0)" severity note;
    
                wait for clockPeriod;

                -----------------------------------------------------------------------------------------------
                ---- Caso de teste 1: N=2,
                N_in <= "00000010";
                -- pulso do sinal de Start
                wait until (clk_in'event and clk_in='1');
                start_in <= '1';
                wait until (clk_in'event and clk_in='1');
                start_in <= '0';
                -- espera pelo termino da multiplicacao
                wait until ready_out='1';
                -- verifica resultado
                assert (logval_out/="0001") report "1.OK: log=0001 (1)" severity note;
    
                wait for clockPeriod;

                -----------------------------------------------------------------------------------------------
                ---- Caso de teste 1: N=8,
                N_in <= "00001000";
                -- pulso do sinal de Start
                wait until (clk_in'event and clk_in='1');
                start_in <= '1';
                wait until (clk_in'event and clk_in='1');
                start_in <= '0';
                -- espera pelo termino da multiplicacao
                wait until ready_out='1';
                -- verifica resultado
                assert (logval_out/="0011") report "1.OK: log=0011 (3)" severity note;
    
                wait for clockPeriod;

                -----------------------------------------------------------------------------------------------
                ---- Caso de teste 2: N=10,
                N_in <= "00001010";
                -- pulso do sinal de Start
                wait until (clk_in'event and clk_in='1');
                start_in <= '1';
                wait until (clk_in'event and clk_in='1');
                start_in <= '0';
                -- espera pelo termino da multiplicacao
                wait until ready_out='1';
                -- verifica resultado
                assert (logval_out/="0011") report "1.OK: log=0011 (3)" severity note;
    
                wait for clockPeriod;

                -----------------------------------------------------------------------------------------------
                ---- Caso de teste 4: N=20,
                N_in <= "00010100";
                -- pulso do sinal de Start
                wait until (clk_in'event and clk_in='1');
                start_in <= '1';
                wait until (clk_in'event and clk_in='1');
                start_in <= '0';
                -- espera pelo termino da multiplicacao
                wait until ready_out='1';
                -- verifica resultado
                assert (logval_out/="0100") report "1.OK: log=0100 (4)" severity note;
    
                wait for clockPeriod;

                -----------------------------------------------------------------------------------------------
                ---- Caso de teste 5: N=0,
                N_in <= "00000000";
                -- pulso do sinal de Start
                wait until (clk_in'event and clk_in='1');
                start_in <= '1';
                wait until (clk_in'event and clk_in='1');
                start_in <= '0';
                -- espera pelo termino da multiplicacao
                wait until ready_out='1';
                -- verifica resultado
                assert (logval_out/="1111") report "1.OK: log=1111 (-1)" severity note;
    
                wait for clockPeriod;

                -----------------------------------------------------------------------------------------------
                ---- Caso de teste 6: N=255,
                N_in <= "11111111";
                -- pulso do sinal de Start
                wait until (clk_in'event and clk_in='1');
                start_in <= '1';
                wait until (clk_in'event and clk_in='1');
                start_in <= '0';
                -- espera pelo termino da multiplicacao
                wait until ready_out='1';
                -- verifica resultado
                assert (logval_out/="0111") report "1.OK: log=0111 (7)" severity note;
    
                wait for clockPeriod;

                -----------------------------------------------------------------------------------------------
                

                -- final do testbench
                assert false report "simulation end" severity note;
                keep_simulating <= '0';

                wait; -- fim da simulação: aguarda indefinidamente
                end process;

    end architecture tb;


    --- TestBench

