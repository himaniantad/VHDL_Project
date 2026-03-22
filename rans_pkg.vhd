library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package rans_pkg is

    constant STATE_W : integer := 16;      -- rANS internal state x is 16-bit wide.
    constant L       : integer := 256;     -- renormalisation threshold. M = 16 ? implied by using 4 LSBs (x(3 downto 0)Alphabet size = 4 symbols).

    -- Total M =2^4=16. That means 4 LSB bits
   -- The decoder is designed for a 4?symbol alphabets is only 0..3

   -- type int_array is array (0 to 12) of integer;
   -- constant Fs : int_array := (3, 1, 4, 2, 20, 4, 16, 16, 2, 2, 1, 4, 8);
   -- constant Bs : int_array := (0, 3, 4, 8, 10, 30, 34, 50, 66, 68, 70, 71, 75);

    type int_array is array (0 to 3) of integer;
    constant Fs : int_array := (6, 4, 3, 3);     --Fs = symbol frequencies
    constant Bs : int_array := (0, 6, 10, 13);   --Bs = cumulative frequencies

end package;

package body rans_pkg is
end package body;