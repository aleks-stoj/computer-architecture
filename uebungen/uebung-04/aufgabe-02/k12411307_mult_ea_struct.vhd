--Aleksandar Stojanović, 12411325
--Annika Schmidthaler, 12411307
--Benedikt Zöchmann, 12410383

library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity mult is 
  generic(width: integer := 32);
  port(a:   in STD_ULOGIC_VECTOR(width/2-1 downto 0);
       b:   in STD_ULOGIC_VECTOR(width/2-1 downto 0);
       y:   out STD_ULOGIC_VECTOR(width-1 downto 0));
end;

architecture struct of mult is 
  component cra_gen
  port(a, b: in  std_ulogic_vector(width-1 downto 0);
       cin:  in  std_ulogic;
       cout: out std_ulogic;
       sum:  out std_ulogic_vector(width-1 downto 0));
  end component;

  component partSum
  port(a:    in  std_ulogic_vector(width/2-1 downto 0);
       b:    in  std_ulogic;
       i:    in  integer; 
       y:    out std_ulogic_vector(width-1 downto 0));
  end component;

  type vector_array is array(0 to width/2-1) of STD_ULOGIC_VECTOR(width-1 downto 0);
  signal partialSums: vector_array := (others => (others => '0'));
  signal currentSums: vector_array := (others => (others => '0'));
  signal zeros: STD_ULOGIC_VECTOR(width-1 downto 0) := (others => '0');
  signal carries: std_ulogic_vector(width/2-1 downto 0);
begin
  p0: partSum port map(a, b(0), 0, partialSums(0));

  getParts: for I in 1 to width/2-1 generate
    partN: partSum port map(a, b(I), I, partialSums(I));
  end generate;


  add1: cra_gen port map(partialSums(0), partialSums(1), '0', carries(1), currentSums(1));

  addSums: for I in 2 to width/2-1 generate
    addN: cra_gen port map(partialSums(I), currentSums(I-1), carries(I-1), carries(I), currentSums(I));
  end generate;

  y <= currentSums(width/2-1);

end;