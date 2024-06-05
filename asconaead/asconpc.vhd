library ieee;
use ieee.std_logic_1164.all;
 
use ieee.numeric_std.all;
use std.textio.all;
 
use work.all;

entity asconp IS
    PORT (
        state_in : IN STD_LOGIC_VECTOR(319 DOWNTO 0);
        cyc_in: in  std_logic;
        state_out : OUT STD_LOGIC_VECTOR(319 DOWNTO 0)
    );
end entity asconp;



architecture asc of asconp is

type RC8type  is array (0 to 11)  of std_logic_vector(63 downto 0);

constant RC8 : RC8type := (
x"00000000000000f0",
x"00000000000000e1",
x"00000000000000d2",
x"00000000000000c3",
x"00000000000000b4",
x"00000000000000a5",
x"0000000000000096",
x"0000000000000087",
x"0000000000000078",
x"0000000000000069",
x"000000000000005a",
x"000000000000004b");

 type Sigtype is array (0 to 11) of std_logic_vector(319 downto 0);
 signal S,R,C,L,M: Sigtype;
 
 
 
begin

S(0)<= state_in ;

state_out<=M(5) ;

l1: for i in 0 to 5 generate

 
   R(i)<= x"0000000000000000" & x"0000000000000000" & RC8(i) & x"0000000000000000" & x"0000000000000000" when cyc_in='0' else
 
          x"0000000000000000" & x"0000000000000000" & RC8(6+i) & x"0000000000000000" & x"0000000000000000";
 

C(i) <= S(i) xor R(i);

s0: entity slayer (s) port map (C(i), L(i));

m0: entity mlayer (m) port map (L(i), M(i));

rx1:if i < 5 generate 
S(i+1)<=M(i);
end generate rx1;


end generate l1;




end architecture asc;
