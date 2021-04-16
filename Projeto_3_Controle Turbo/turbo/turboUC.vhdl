------------------------------------------------------
--! @file turboFD.vhdl
--! @brief 
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

entity turboUC is
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
    end entity turboUC;

    architecture arch_turboUC of turboUC is
        type state_t is (i0, x1, x2, t3);
        signal next_state, current_state: state_t;

        begin
            fsm: process(clock, reset)
            begin
                if reset = '1' then
                    current_state <= i0;
                elsif (clock'event and clock='1') then
                    current_state <= next_state;
                end if;
            end process;


        next_state <=
        i0 when (current_state = i0) and (d0 = '1') else
        x1 when (current_state = i0) and (d0 = '0') else
        x2 when (current_state = x1) and (eq0 = '1') else
        x1 when (current_state = x1) and (eq0 = '0') and (d0 = '0') else
        i0 when (current_state = x1) and (eq0 = '0') and (d0 = '1') else
        t3 when (current_state = x2) and (eq0 = '1') and (me0 = '1') else
        x2 when (current_state = x2) and (eq0 = '1') and (me0 = '0') else
        x1 when (current_state = x2) and (eq0 = '0') and (d0 = '0') else
        i0 when (current_state = x2) and (eq0 = '0') and (d0 = '1') else
        t3 when (current_state = t3) and (eq0 = '1') and (me0 = '1') else
        x2 when (current_state = t3) and (eq0 = '1') and (me0 = '0') else
        x1 when (current_state = t3) and (eq0 = '0') and (d0 = '0') else
        i0 when (current_state = t3) and (eq0 = '0') and (d0 = '1') else
        i0;

        RSTr     <= '1' when current_state=i0 else '0';
        CEr      <= '1' when current_state=x1 else '0';
        Zr       <= '0';
        DLcmd    <= '1' when current_state=x1 or current_state=t3 else '0';
        RSTco    <= '1' when current_state=i0 else '0';
        CEco     <= '1' when current_state=x2 or current_state=t3 else '0';
        Zco      <= '1' when current_state=x1 else '0';


end arch_turboUC;

