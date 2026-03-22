library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_rans_decoder is
end entity;

architecture sim of tb_rans_decoder is

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';

    signal bit_in    : std_logic := '0';
    signal bit_valid : std_logic := '0';

    signal symbol_out : unsigned(1 downto 0);
    signal sym_valid  : std_logic;

begin

    -- Clock
    clk <= not clk after 5 ns;

    -- DUT
    uut : entity work.rans_decoder
        port map(
            clk        => clk,
            rst        => rst,
            bit_in     => bit_in,
            bit_valid  => bit_valid,
            symbol_out => symbol_out,
            sym_valid  => sym_valid
        );

    ------------------------------------------------
    -- STIMULUS
    ------------------------------------------------
    process
    begin
        -- Reset
        wait for 20 ns;
        rst <= '0';

        bit_valid <= '1';

        -- Improved bitstream (NOT repetitive)
        for i in 0 to 63 loop
            wait until rising_edge(clk);

            if ((i*3 + 1) mod 2) = 0 then
                bit_in <= '0';
            else
                bit_in <= '1';
            end if;

        end loop;

        bit_valid <= '0';

        wait for 200 ns;
        wait;
    end process;

end architecture;
