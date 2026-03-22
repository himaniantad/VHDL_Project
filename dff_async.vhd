library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_async is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;  -- Asynchronous reset (active high)
        d     : in  STD_LOGIC;
        q     : out STD_LOGIC
    );
end dff_async;

architecture rtl of dff_async is
begin

    process(clk, reset)
    begin
        if reset = '1' then
            q <= '0';                     -- Immediate asynchronous reset
        elsif rising_edge(clk) then
            q <= d;                       -- Capture input on rising edge
        end if;
    end process;

end rtl;