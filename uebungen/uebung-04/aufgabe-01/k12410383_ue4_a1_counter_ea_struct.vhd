-- Aleksandar Stojanović, 12411325
-- Annika Schmidthaler, 12411307
-- Benedikt Zöchmann, 12410383

-- Aufgabe 1

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity counter is
    generic (width: integer);
    port(
        clk, reset : in std_ulogic;
        up         : in std_ulogic;
        y          : out std_ulogic_vector(width-1 downto 0)
    );
end entity counter;

architecture struct of counter is

    -- Flip-Flop Komponente
    component ff is
        generic (width: integer);
        port (
            clk, reset : in std_ulogic;
            d          : in std_ulogic_vector(width-1 downto 0);
            q          : out std_ulogic_vector(width-1 downto 0)
        );
    end component;

    -- CRA Addierer-Komponente
    component cra_gen is
        generic(width: integer);
        port(
            a, b : in std_ulogic_vector(width-1 downto 0);
            cin  : in std_ulogic;
            cout : out std_ulogic;
            sum  : out std_ulogic_vector(width-1 downto 0)
        );
    end component;

    -- Signal Deklarationen
    signal count        : std_ulogic_vector(width-1 downto 0);
    signal next_count   : std_ulogic_vector(width-1 downto 0);
    signal plus_one     : std_ulogic_vector(width-1 downto 0);
    signal minus_one    : std_ulogic_vector(width-1 downto 0);
    signal carry_up     : std_ulogic;
    signal carry_down   : std_ulogic;
    signal max_val      : std_ulogic_vector(width-1 downto 0);
    signal min_val      : std_ulogic_vector(width-1 downto 0);

begin
    -- Initialisierung
    max_val <= (others => '1');
    min_val <= (others => '0');

    -- CRA für Inkrement
    add_up: cra_gen
        generic map(width => width)
        port map(
            a    => count,
            b    => conv_std_logic_vector(1, width),  -- +1
            cin  => '0',
            cout => carry_up,
            sum  => plus_one
    );

    -- CRA für Dekrement
    add_down: cra_gen
        generic map(width => width)
        port map(
            a    => count,
            b    => conv_std_logic_vector(-1, width),  -- -1
            cin  => '0',
            cout => carry_down,
            sum  => minus_one
    );

    -- Flip-Flop
    flipFlop: ff
        generic map(width => width)
        port map(
            clk   => clk,
            reset => reset,
            d     => next_count,
            q     => count
        );

    -- Auswertung
    process(clk, reset)
        variable is_max_var : std_ulogic := '1'; 
        variable is_min_var : std_ulogic := '1';
    begin
        -- Bitweise Gleichheit prüfen
        is_max_var := '1';
        is_min_var := '1';

        for i in 0 to width - 1 loop
            is_max_var := is_max_var and not(count(i) xor max_val(i));
            is_min_var := is_min_var and not(count(i) xor min_val(i));
        end loop;

        -- Logik für next_count
        next_count <= (reset and min_val)
                    or (not reset and up and is_max_var and min_val)
                    or (not reset and up and not is_max_var and plus_one)
                    or (not reset and not up and is_min_var and max_val)
                    or (not reset and not up and not is_min_var and minus_one);
    end process;

    -- Ausgabe
    y <= count;

end architecture struct;
