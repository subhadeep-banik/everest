library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.all;
 

entity ascone is

 
  port(
        PT        : in  std_logic_vector(319 downto 0);
        K0        : in  std_logic_vector(319 downto 0);
        CT        : out std_logic_vector(319 downto 0); 
        ClkxCI    : in  std_logic
      );

end ascone;

architecture e of ascone is

signal A,B: std_logic_vector(319 downto 0);

begin

A<= PT xor K0;

p: entity asconp (asc) port map (A,B);


CT<= B xor K0;

end architecture e;
