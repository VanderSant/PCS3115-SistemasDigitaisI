entity log2UC is
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
  end entity log2UC;
  
  architecture arch_log2UC of log2UC is
    type state_t is (wait0,x1,ready2,x3,x4,ready5,ready6);
    signal next_state, current_state: state_t;
    begin
    fsm: process(clock, reset)
      begin
        if reset='1' then
            current_state <= wait0;
        elsif (clock'event and clock='1') then
            current_state <= next_state;
        end if;
    end process;
  
    next_state <=
        wait0  when (current_state = wait0) and (start='0') else
        x1     when (current_state = wait0) and (start='1') else
        ready2   when (current_state = x1)    and (d0='1') else
        x3     when (current_state = x1)    and (d0='0') else
        x4     when (current_state = x3)    and (d1='0') else
        x4     when (current_state =x4 )    and (d1='0') else
        ready5   when (current_state = x3 )   and (d1='1') else
        ready5   when (current_state =x4 )    and (d1='1') else
        ready6  when (current_state = ready5) else
        wait0  when (current_state = ready6) else
        wait0  when (current_state = ready2) else
        wait0;
  
        ready  <= '1' when current_state=ready6 or current_state=ready2 else '0';
        RSTn <= '1' when current_state=wait0 else '0';
        CEn  <= '1' when current_state=x1 else '0';
        DCn  <= '1' when current_state=x4 else '0';
        Dn   <= '1' when current_state=x4 else '0';
        RSTd <= '1' when current_state=wait0 or current_state=x1 else '0';
        CEd  <= '1' when current_state=x4 else '0';
        RSTl <= '1' when current_state=wait0 else '0';
        CEl  <= '1' when current_state=x1 or current_state=x3 or current_state=ready5 else '0';
        DCl  <= '1' when current_state=x1 else '0';   
    
  end architecture arch_log2UC;