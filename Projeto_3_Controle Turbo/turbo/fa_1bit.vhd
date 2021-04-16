 
entity fa_1bit is
       port (
         A,B : in bit;
         CIN : in bit;
         SUM : out bit;
         COUT : out bit
         );
     end entity fa_1bit;
     
     architecture sum_minterm of fa_1bit is
     begin
       SUM <= (not(CIN) and not(A) and B) or
              (not(CIN) and A and not(B)) or
              (CIN and not(A) and not(B)) or
              (CIN and A and B);

       COUT <= (not(CIN) and A and B) or
               (CIN and not(A) and B) or
               (CIN and A and not(B)) or
               (CIN and A and B);
     end architecture sum_minterm;