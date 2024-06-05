library ieee;
use ieee.std_logic_1164.all;
 
use ieee.numeric_std.all;
use std.textio.all;
use work.all;

entity mlayer is
port ( InpxDI : in  std_logic_vector(319 downto 0);
       OupxDO : out std_logic_vector(319 downto 0));
end entity mlayer;

architecture m of mlayer is 


signal X0,X1,X2,X3,X4: std_logic_vector(63 downto 0);

signal X01,X11,X21,X31,X41: std_logic_vector(63 downto 0);
signal X02,X12,X22,X32,X42: std_logic_vector(63 downto 0);

begin 

X0 <= InpxDI(319 downto 256);
X1 <= InpxDI(255 downto 192);
X2 <= InpxDI(191 downto 128);
X3 <= InpxDI(127 downto 64);
X4 <= InpxDI(63 downto 0);


X01 <= X0(18 downto 0) & X0(63 downto 19);
X02 <= X0(27 downto 0) & X0(63 downto 28);


X11 <= X1(60 downto 0) & X1(63 downto 61);
X12 <= X1(38 downto 0) & X1(63 downto 39);

X21 <= X2(0) & X2(63 downto 1);
X22 <= X2(5 downto 0) & X2(63 downto 6);

X31 <= X3(9 downto 0) & X3(63 downto 10);
X32 <= X3(16 downto 0) & X3(63 downto 17);

X41 <= X4(6 downto 0) & X4(63 downto 7);
X42 <= X4(40 downto 0) & X4(63 downto 41);


OupxDO(319 downto 256) <= X0 xor X01 xor X02;
OupxDO(255 downto 192) <= X1 xor X11 xor X12;
OupxDO(191 downto 128) <= X2 xor X21 xor X22;
OupxDO(127 downto 64)  <= X3 xor X31 xor X32;
OupxDO(63 downto 0)    <= X4 xor X41 xor X42;



end architecture m;
