-------------------------------------------------------------------------------
-- @author Subhadeep Banik <subhadeep.banik@usi.ch>
-------------------------------------------------------------------------------
-- This source code is hereby placed in the public domain.
--
-- THIS SOURCE CODE IS PROVIDED BY THE AUTHORS ''AS IS'' AND ANY EXPRESS
-- OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
-- BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
-- WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
-- OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE,
-- EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
 
use ieee.numeric_std.all;
use std.textio.all;
use work.all;

entity Present is 
port ( KeyxDI : in std_logic_vector(79 downto 0); 
       PTxDI:   in std_logic_vector(63 downto 0); 
       ClkxCI:  in std_logic; 
       CTxDO: out std_logic_vector(63 downto 0) );
end entity Present;

architecture pr80 of Present is

 type Sigtype is array (0 to 31) of std_logic_vector(63 downto 0);
 signal St, AftxD,BytesxD :Sigtype;
 
 type Ktype is array (0 to 31) of std_logic_vector(79 downto 0);
 signal K, RolxD:Ktype;
 
 type B4 is array (0 to 31) of std_logic_vector(4 downto 0);
 signal CntxD: B4;
 
 type B3 is array (0 to 31) of std_logic_vector(3 downto 0);
 signal SBxD: B3;
 

subtype Int6Type is integer range 0 to 63;
  type Int6Array is array (0 to 63) of Int6Type;
  constant Perm : Int6Array := (

 0,16,32,48, 1,17,33,49, 2,18,34,50, 3,19,35,51,
 4,20,36,52, 5,21,37,53, 6,22,38,54, 7,23,39,55,
 8,24,40,56, 9,25,41,57,10,26,42,58,11,27,43,59,
12,28,44,60,13,29,45,61,14,30,46,62,15,31,47,63 
);

  
 type RconType is array (0 to 31) of std_logic_vector(7 downto 0);
 constant RC : RconType := (
 x"00",  x"01",  x"02",  x"03",  x"04",  x"05",  x"06", x"07",
 x"08",  x"09",  x"0a",  x"0b",  x"0c",  x"0d",  x"0e", x"0f",
 x"10",  x"11",  x"12",  x"13",  x"14",  x"15",  x"16", x"17",
 x"18",  x"19",  x"1a",  x"1b",  x"1c",  x"1d",  x"1e", x"1f" 
 
 ); 
  

begin

 
K(0)  <= KeyxDI;
St(0)  <= PtxDI;
--------------------------------------------------------------------------------------------------------------

rnds: for i in 1 to 31 generate


AftxD(i) <= K(i-1)(79 downto 16) xor St(i-1);

sl1x: entity Slayer (sl) port map (AftxD(i), BytesxD(i));

loop1x: for j in 0 to 63 generate
St(i)(Perm(j)) <= BytesxD(i)(j);
end generate loop1x;

end generate rnds;
--------------------------------------------------------------------------------------------------------------

 
--------------------------------------------------------------------------------------------------------------
CTxDO <= St(31) xor K(31)(79 downto 16);



--------------------------------------------------------------------------------------------------------------
 


 

ks: for i in 1 to 31 generate

RolxD(i)(79 downto 61) <= K(i-1)(18 downto 0);
RolxD(i)(60 downto 0)  <= K(i-1)(79 downto 19);


kl1x: entity sbox (lookuptable) port map (RolxD(i)(79 downto 76), SBxD(i));


CntxD(i) <= RolxD(i) (19 downto 15) xor RC(i)(4 downto 0);

K(i) <= SBxD(i) & RolxD(i)(75 downto 20) & CntxD(i) & RolxD(i)(14 downto 0);

end generate ks;

--------------------------------------------------------------------------------------------------------------
 








 



end architecture pr80;

