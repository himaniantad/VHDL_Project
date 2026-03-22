library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.rans_pkg.all;

entity rans_decoder is
    port (
        clk        : in  std_logic;
        rst        : in  std_logic;
        bit_in     : in  std_logic;
        bit_valid  : in  std_logic;
        symbol_out : out unsigned(1 downto 0);
        sym_valid  : out std_logic
    );
end entity;

architecture rtl of rans_decoder is
    signal x : unsigned(STATE_W-1 downto 0);
begin

    process(clk, rst)
        variable r      : integer;
        variable s      : integer;
        variable x_next : unsigned(STATE_W-1 downto 0);
    begin
        if rst = '1' then
            -- Start above L
            x <= to_unsigned(2*L, STATE_W);
            symbol_out <= (others => '0');
            sym_valid  <= '0';

        elsif rising_edge(clk) then

            -- default
            sym_valid <= '0';

            ---------------------------------------
            -- RENORMALIZATION
            ---------------------------------------
            if x < to_unsigned(L, STATE_W) then
                if bit_valid = '1' then
                    -- SAFE SHIFT + INSERT BIT
                    x <= x(STATE_W-2 downto 0) & bit_in;
                end if;

            ---------------------------------------
            -- DECODING
            ---------------------------------------
            else
                r := to_integer(x(3 downto 0));

                if r < 6 then
                    s := 0;
                elsif r < 10 then
                    s := 1;
                elsif r < 13 then
                    s := 2;
                else
                    s := 3;
                end if;

                -- rANS state update
                x_next :=
                    resize(
                                                   (to_unsigned(work.rans_pkg.Fs(s), STATE_W) *
                                                        shift_right(x, 4)) +
                                                       to_unsigned(r - work.rans_pkg.Bs(s), STATE_W),
                                                        STATE_W
                                                             );

                x <= x_next;

                symbol_out <= to_unsigned(s, 2);
                sym_valid  <= '1';
            end if;

        end if;
    end process;

end architecture;