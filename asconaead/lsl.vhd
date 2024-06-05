library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- contains conversion functions

entity sbox is
  
  port (
    InpxDI : in  std_logic_vector(4 downto 0);
    OupxDO : out std_logic_vector(4 downto 0)
    );

end sbox;


architecture lookuptable of sbox is

begin
--4 b 1f 14 1a 15 9 2 1b 5 8 12 1d 3 6 1c 1e 13 7 e 0 d 11 18 10 c 1 19 16 a f 17
    with InpxDI select
    OupxDO <= "00100" when "00000",--04
              "01011" when "00001",--0b
              "11111" when "00010",--1f
              "10100" when "00011",--14
              "11010" when "00100",--1a
              "10101" when "00101",--15
              "01001" when "00110",--09
              "00010" when "00111",--02
              "11011" when "01000",--1b
              "00101" when "01001",--05
              "01000" when "01010",--08
              "10010" when "01011",--12
              "11101" when "01100",--1d
              "00011" when "01101",--03
              "00110" when "01110",--06
              "11100" when "01111",--1c
              "11110" when "10000",--1e
              "10011" when "10001",--13
              "00111" when "10010",--07
              "01110" when "10011",--0e
              "00000" when "10100",--00
              "01101" when "10101",--0d
              "10001" when "10110",--11
              "11000" when "10111",--18
              "10000" when "11000",--10
              "01100" when "11001",--0c
              "00001" when "11010",--01
              "11001" when "11011",--19
              "10110" when "11100",--16
              "01010" when "11101",--0a
              "01111" when "11110",--0f                       
              "10111" when others;--17

end architecture lookuptable;

 
