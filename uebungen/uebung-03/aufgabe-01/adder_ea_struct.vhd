library IEEE; use IEEE.STD_LOGIC_1164.all;
entity adder is -- Conditional Sum Adder
  generic(width : Integer := 8);
  port(a,b: in  std_ulogic_vector(width-1 downto 0);
       c:   in  std_ulogic;
       s:   out std_ulogic_vector(width downto 0));
end;

architecture struct of adder is
  constant half : integer := width/2; -- half width
  
  component cra_gen -- carry ripple adder
  generic(width : integer := 8);
    port(
      a,b: in std_ulogic_vector(width-1 downto 0);
      cin:  in  std_ulogic;
      cout: out std_ulogic;
      sum:  out std_ulogic_vector(width-1 downto 0)
    );
  end component;

  component MUX8_gen -- 8-bit multiplexer
    generic(width : integer := 8);
    port(
      a,b:  in  std_ulogic_vector(width-1 downto 0);
      s:    in  std_ulogic; 
      y:    out std_ulogic_vector(width-1 downto 0)
    );
  end component;

  -- signals for the lower 4 bits
  signal sum_lower : std_ulogic_vector(half-1 downto 0); -- sum of lower 4 bits
  signal cout_lower : std_ulogic; -- cout signal of lower 4 bits, used for MUX selection
  
  -- signals for the higher 4 bits
  signal sum_higher_0, sum_higher_1 : std_ulogic_vector(width-1 downto half); -- sum for higher blocks, one for cin = 1, the other for cin = 0
  signal cout_higher_0, cout_higher_1 : std_ulogic; -- cout for higher blocks, one for cin = 1, the other for cin = 0

  begin
    lower_block: cra_gen
      generic map (width => half)
      port map(
        a => a(half-1 downto 0),
        b => b(half-1 downto 0),
        cin => c,
        cout => cout_lower,
        sum => sum_lower
      );

    higher_block_0: cra_gen
      generic map (width => half)
      port map (
        a => a(width-1 downto half),
        b => b(width-1 downto half),
        cin => '0',
        cout => cout_higher_0,
        sum => sum_higher_0
      );
    
    higher_block_1: cra_gen
      generic map (width => half)
      port map (
        a => a(width-1 downto half),
        b => b(width-1 downto half),
        cin => '1',
        cout => cout_higher_1,
        sum => sum_higher_1
      );

    mux8 : MUX8_gen
      generic map (width => half)
      port map(
        a => sum_higher_1,
        b => sum_higher_0,
        s => not cout_lower,
        y => s(width-1 downto half)
      );

    -- Directly assign lower bits to final sum
    s(half-1 downto 0) <= sum_lower;
    s(width) <= cout_higher_1 when cout_lower = '1' else cout_higher_0;
  end; 