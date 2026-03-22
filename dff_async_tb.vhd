library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_async_tb is
end dff_async_tb;

architecture sim of dff_async_tb is

    -- Testbench signals
    signal clk   : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal d     : STD_LOGIC := '0';
    signal q     : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Direct entity instantiation (VHDL-2008 style)
    uut: entity work.dff_async
        port map (
            clk   => clk,
            reset => reset,
            d     => d,
            q     => q
        );

    -- Clock generation
    clk <= not clk after CLK_PERIOD/2;

    -- Stimulus process
    stimulus : process
    begin

        -- Apply asynchronous reset
        reset <= '1';
        wait for 15 ns;
        reset <= '0';

        -- Test data capture
        wait for 10 ns;
        d <= '1';

        wait for 10 ns;
        d <= '0';

        wait for 10 ns;
        d <= '1';

        -- Assert asynchronous reset between clock edges
        wait for 7 ns;
        reset <= '1';

        wait for 5 ns;
        reset <= '0';

        wait for 20 ns;

        -- End simulation
        wait;
    end process;

end sim;
