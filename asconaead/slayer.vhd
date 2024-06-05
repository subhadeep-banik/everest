library ieee;
use ieee.std_logic_1164.all;
 
use ieee.numeric_std.all;
use std.textio.all;
use work.all;

entity slayer is
port ( InpxDI : in  std_logic_vector(319 downto 0);
       OupxDO : out std_logic_vector(319 downto 0));
end entity slayer;

architecture s of slayer is 

 type stype is array (0 to 63) of std_logic_vector(4 downto 0);
 signal s,t: stype;

begin 


loop1: for i in 0 to 63 generate 

s(i)<=  InpxDI (319-i) & InpxDI (255-i) & InpxDI (191-i) &  InpxDI (127-i) & InpxDI (63-i);

i_sbox: entity sbox(lookuptable) port map (s(i), t(i)); 

OupxDO (319-i)<= t(i)(4); 
OupxDO (255-i)<= t(i)(3); 
OupxDO (191-i)<= t(i)(2); 
OupxDO (127-i)<= t(i)(1); 
OupxDO (63-i) <= t(i)(0); 
 
end generate loop1;

end architecture s;
