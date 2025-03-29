library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- ALU Entity
entity ALU is
    generic (
        width : integer := 32
    );
    port (
        A     : in  std_logic_vector(width-1 downto 0);
        B     : in  std_logic_vector(width-1 downto 0);
        mode  : in  std_logic_vector(2 downto 0);
        result: out std_logic_vector(width-1 downto 0);
        neg   : out std_logic
    );
end ALU;

-- ALU Architektur mit CRA Addierer
architecture Behavioral of ALU is

    -- Signaldeklarationen für die verschiedenen Operationen
    signal A_or_B, A_and_B, A_or_NotB, A_and_NotB, sum_int, diff_int : std_logic_vector(31 downto 0);
    signal cout : std_logic;
    signal slt_result : std_logic;

    -- CRA Instanz für 32-Bit Addition/Subtraktion
    component cra_gen is
        generic(width: integer);
        port(a, b: in std_ulogic_vector(width-1 downto 0);
             cin: in std_ulogic;
             cout: out std_ulogic;
             sum: out std_ulogic_vector(width-1 downto 0));
    end component;

begin
    -- Logische Operationen
    A_or_B <= A or B;     
    A_and_B <= A and B;    

    A_or_NotB <= A or Not B;      
    A_and_NotB <= A and Not B;    

    -- Set Less Than (SLT) - Ergebnis ist 1, wenn A < B
    slt_result <= diff_int(31);
  
    -- Instanz des CRA-Addierers für Addition
    adder: cra_gen 
        generic map(width => 32)
        port map(
            a => A,
            b => B, 
            cin => '0',
            cout => cout,
            sum => sum_int
        );

    -- Subtraktion mit Addierer
    subtraction: cra_gen 
        generic map(width => 32)
        port map(
            a => A,
            b => B,
            cin => '1',
            cout => cout,
            sum => diff_int
        );
    
    result <= (A_or_B and (not mode(2) and not mode(1) and not mode(0))) or           -- A OR B (mode = "000")
              (A_and_B and (not mode(2) and not mode(1) and mode(0))) or              -- A AND B (mode = "001")

              (A_or_NotB and (mode(2) and not mode(1) and not mode(0))) or            -- A - Not B (mode = "100")
              (A_and_NotB and (mode(2) and not mode(1) and mode(0))) or               -- A - No tB (mode = "101")
              
              (diff_int and (B(31) and not mode(2) and mode(1) and not mode(0))) or   -- A + B (mode = "010")
              (sum_int and (not B(31) and not mode(2) and mode(1) and not mode(0))) or              
              
              (A and (not B(0) and mode(2) and mode(1) and not mode(0))) or           -- A - B (mode = "110")
              (sum_int and (B(31) and mode(2) and mode(1) and not mode(0))) or
              (diff_int and (not B(31) and mode(2) and mode(1) and not mode(0))) or   
              
              (slt_result and (mode(2) and mode(1) and mode(0)));                     -- A < B (mode = "111")

    -- Setze Negativ-Flag (neg) basierend auf dem höchstwertigen Bit des Ergebnisses
    neg <= result(31);

end Behavioral;
