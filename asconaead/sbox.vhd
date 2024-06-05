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

  subtype Int4Type is integer range 0 to 31;
  type Int4Array is array (0 to 31) of Int4Type;
  constant SBOX : Int4Array := (

 
4, 11 ,31, 20, 26, 21, 9, 2, 27, 5, 8, 18, 29, 3, 6, 28, 30, 19, 7, 14, 0, 13, 17, 24, 16, 12, 1, 25, 22, 10, 15, 23
);

  
begin  -- lookuptable

  OupxDO <= std_logic_vector(to_unsigned(SBOX(to_integer(unsigned(InpxDI(4 downto 0)))), 5));
  

end lookuptable;

