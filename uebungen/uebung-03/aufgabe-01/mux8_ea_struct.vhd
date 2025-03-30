library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX8_gen is
  generic(width : integer);
  port(a, b: in  std_ulogic_vector(width-1 downto 0);
       s:    in  std_ulogic; 
       y:    out std_ulogic_vector(width-1 downto 0));
end;

architecture struct of MUX8_gen is
begin
  y <= (a and (not (width-1 downto 0 => s))) or (b and (width-1 downto 0 => s));
  
end;