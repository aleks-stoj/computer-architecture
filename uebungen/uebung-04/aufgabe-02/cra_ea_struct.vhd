library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity cra_gen is
  generic(width: integer := 32);
  port(a, b: in  std_ulogic_vector(width-1 downto 0);
       cin:  in  std_ulogic;
       cout: out std_ulogic;
       sum:  out std_ulogic_vector(width-1 downto 0));
end;    

architecture struct of cra_gen is
  component fa
    port(a, b, cin: in  std_ulogic;
         cout, s:   out std_ulogic);
  end component;
  signal c: std_ulogic_vector(width-1 downto 0);
begin
  
  fa0: fa port map(a(0), b(0), cin, c(0), sum(0));
  
  FA_1: for I in 1 to width-1 generate
    faN: fa port map(a(I), b(I), c(I-1), c(I), sum(I));
  end generate;
  
  cout <= c(width-1);
end;
