--Aleksandar Stojanović, 12411325
--Annika Schmidthaler, 12411307
--Benedikt Zöchmann, 12410383

library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity barrel is
  generic(width : integer := 8);
  port(n:     in  std_ulogic_vector(width-1 downto 0);
       shamt: in  std_ulogic_vector(2 downto 0);
       y:     out std_ulogic_vector(width-1 downto 0));
end;

architecture barrelShifter of barrel is
  component MUX2
    port(a, b: in  std_ulogic;
       s:    in  std_ulogic; 
       y:    out std_ulogic);
  end component;

  signal shift4, shift2, shift1: std_ulogic_vector(width-1 downto 0);

begin
  m0: MUX2 port map(n(3), n(7), shamt(2), shift4(7));
  m1: MUX2 port map(n(2), n(6), shamt(2), shift4(6));
  m2: MUX2 port map(n(1), n(5), shamt(2), shift4(5));
  m3: MUX2 port map(n(0), n(4), shamt(2), shift4(4));
  m4: MUX2 port map('0', n(3), shamt(2), shift4(3));
  m5: MUX2 port map('0', n(2), shamt(2), shift4(2));
  m6: MUX2 port map('0', n(1), shamt(2), shift4(1));
  m7: MUX2 port map('0', n(0), shamt(2), shift4(0));
  
  m8: MUX2 port map(shift4(5), shift4(7), shamt(1), shift2(7));
  m9: MUX2 port map(shift4(4), shift4(6), shamt(1), shift2(6));
  m10: MUX2 port map(shift4(3), shift4(5), shamt(1), shift2(5));
  m11: MUX2 port map(shift4(2), shift4(4), shamt(1), shift2(4));
  m12: MUX2 port map(shift4(1), shift4(3), shamt(1), shift2(3));
  m13: MUX2 port map(shift4(0), shift4(2), shamt(1), shift2(2));
  m14: MUX2 port map('0', shift4(1), shamt(1), shift2(1));
  m15: MUX2 port map('0', shift4(0), shamt(1), shift2(0));

  m16: MUX2 port map(shift2(6), shift2(7), shamt(0), shift1(7));
  m17: MUX2 port map(shift2(5), shift2(6), shamt(0), shift1(6));
  m18: MUX2 port map(shift2(4), shift2(5), shamt(0), shift1(5));
  m29: MUX2 port map(shift2(3), shift2(4), shamt(0), shift1(4));
  m20: MUX2 port map(shift2(2), shift2(3), shamt(0), shift1(3));
  m21: MUX2 port map(shift2(1), shift2(2), shamt(0), shift1(2));
  m22: MUX2 port map(shift2(0), shift2(1), shamt(0), shift1(1));
  m23: MUX2 port map('0', shift2(0), shamt(0), shift1(0));

  y <= shift1;
end;


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX2 is
  port(a, b: in  std_ulogic;
       s:    in  std_ulogic; 
       y:    out std_ulogic);
end;

architecture struct of MUX2 is
begin
  y <= (a and s) or (b and (not s));
  
end;