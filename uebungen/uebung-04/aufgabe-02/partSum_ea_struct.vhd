library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity partSum is
  generic(width: integer := 32);
  port(a:    in  std_ulogic_vector(width/2-1 downto 0);
       b:    in  std_ulogic;
       i:    in  integer; 
       y:    out std_ulogic_vector(width-1 downto 0));
end;

architecture struct of partSum is
  signal zeros: std_ulogic_vector(width/2-1 downto 0) := (others => '0');
begin
  -- A * B(i) * 2^i
  y <= zeros(16-i-1 downto 0) & (a and b) & zeros(i-1 downto 0);
end;