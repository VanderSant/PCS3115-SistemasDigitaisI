------------------------------------------------------
--! @file turbo_tb.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

entity turbo_tb is    
end entity turbo_tb;

architecture tb of turbo_tb is
    component turbo is
        port (
          clock, reset: in bit; 	
          button: in bit_vector(7 downto 0);
          sensib: in bit_vector(3 downto 0);
          cmd: out bit_vector(7 downto 0)		
        );
      end component;

    signal clock, reset : bit;
    signal button, cmd  : bit_vector(7 downto 0);
    signal sensib       : bit_vector(3 downto 0);

   begin
      DUT: entity work.turbo port map(
         clock => clock,
         reset => reset,
         button => button,
         cmd => cmd,
         sensib => sensib
        );

       Clk: process is
         begin
          clock <='0';
          wait for 0.5 ns;
          clock <= '1';
          wait for 0.5 ns;
        end process Clk;
        
        StimulusProcess: process is
           type PatternType is record
             reset   : bit;
             sensib  : bit_vector(3 downto 0);
             button  : bit_vector(7 downto 0);
             cmd     : bit_vector(7 downto 0);
            end Record PatternType;

            type PatternArray is array(natural range <>) of PatternType;
            constant Patterns : PatternArray :=
            (
              ('1',"0001","00000000","00000000"),
              ('0',"0001","00000011","00000011"),
              ('0',"0001","00000011","00000000"),
              ('0',"0001","00000011","00000011"),
              ('0',"0001","00000011","00000011"),
              ('0',"0001","00000011","00000011"),
              ('0',"0001","00100010","00100010"),
              ('0',"0001","00100010","00000000"),
              ('0',"0001","00100010","00100010"),
              ('0',"0001","00100010","00100010"),
              ('0',"0010","00000000","00000000"),
              ('0',"0010","00000011","00000011"),
              ('0',"0010","00000011","00000000"),
              ('0',"0010","00000011","00000000"),
              ('0',"0010","00000011","00000011"),
              ('0',"0010","00000011","00000011"),
              ('0',"0010","00100010","00100010"));
              
           begin 
             for k in Patterns'range loop
                 reset <= Patterns(k).reset;
                 sensib <= Patterns(k).sensib;
                 button <= Patterns(k).button;
                 wait for 1 ns;
                 assert cmd= Patterns(k).cmd report "bad cmd" severity error;
                 end loop;

              assert false report "end of test" severity note;
              wait;

        end process StimulusProcess;

end architecture tb;