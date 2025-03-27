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
  component MUX2_gen
		port(a, b: in  std_ulogic_vector(width-1 downto 0);
       s:    in  std_ulogic; 
       y:    out std_ulogic_vector(width-1 downto 0));
	end component;
  component Shifter
		Port ( unshifted  : in STD_LOGIC_VECTOR(width-1 downto 0);
           shift_count : in integer range 0 to width-1;
           shifted    : out STD_LOGIC_VECTOR(width-1 downto 0)
         );
	end component;

  signal shift4, shift2, shift1: std_ulogic_vector(width-1 downto 0);
  signal result1, result2: std_ulogic_vector(width-1 downto 0);
  signal selected: std_ulogic_vector(width-1 downto 0);

begin
  s0: Shifter port map(n, 4, shift4);

  m0: MUX2_gen port map(n, shift4, shamt(2), result1);

  s1: Shifter port map(result1, 2, shift2);

  m1: MUX2_gen port map(result1, shift2, shamt(1), result2);

  s2: Shifter port map(result2, 1, shift1);

  m2: MUX2_gen port map(result2, shift1, shamt(0), y);
end;


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX2_gen is
  generic(width : integer := 8);
  port(a, b: in  std_ulogic_vector(width-1 downto 0);
       s:    in  std_ulogic; 
       y:    out std_ulogic_vector(width-1 downto 0));
end;

architecture struct of MUX2_gen is
begin
  y <= (a and (not (width-1 downto 0 => s))) or (b and (width-1 downto 0 => s));
end;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shifter is
    generic(width : integer := 8);
    Port ( unshifted  : in std_ulogic_vector(width-1 downto 0);
           shift_count : in integer range 0 to width-1;
           shifted    : out std_ulogic_vector(width-1 downto 0)
         );
end Shifter;

architecture behavioral of Shifter is
begin
    process(unshifted, shift_count)
    variable temp : std_ulogic_vector(width-1 downto 0);
    begin
        if(shift_count = 0) then
          temp := unshifted;
        else
          -- set all to 0
          temp := (others => '0');

          for i in 0 to width-1-shift_count loop
              temp(i+shift_count) := unshifted(i);
          end loop;
        end if;

        shifted <= temp;
    end process;

end behavioral;