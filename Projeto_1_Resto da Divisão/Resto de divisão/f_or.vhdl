------------------------------------------------------
--! @file f_or.vhdl
--! @brief digital port OR
--! @author Vanderson Santos (vanderson.santos@usp.br)
--! @date 06/2020
-------------------------------------------------------

entity f_or is
    port(
      A: in bit;
      B: in bit;
      C: out bit
    );
    end entity f_or;
    
    architecture dataflow of f_or is
    begin
      C <= A or B;
    end architecture dataflow;