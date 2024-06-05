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

entity Tachyon is 
port ( KeyxDI : in std_logic_vector(127 downto 0); 
       InxDI:   in std_logic_vector(127 downto 0); 
       ClkxCI:  in std_logic; 
       OpxDO: out std_logic_vector(127 downto 0) );
end entity Tachyon;

architecture tach64 of Tachyon is

signal SxD: std_logic_vector(127 downto 0); 

 
 
  
 type Sigtype is array (0 to 19) of std_logic_vector(127 downto 0);
 signal R,SubxD,ShufxD,MultxD: Sigtype;
  

  type RconType is array (0 to 19) of std_logic_vector(127 downto 0);
 constant RC : RconType := (
 x"00000000000000000000000000000000",
 x"00000001000100010100010100000101",
 x"00010101010000000101000000000000",
 x"01000100000100000000010100010001",
 x"00010100000001000000000100000101",
 x"00000001000000000001000001010101",
 x"01010001000000010001010100000000",
 x"00000000000001000001010000010100",--7
 
 x"00000000010001010101000001010000",--8
 x"01000001000100000100000000000001",--9
 x"00010000000000000100010101000000",--a
 x"00010101000000010100000100010101",--b
 x"00000100000001000100000001010100",--c
 x"00010001000000010000010100000000",--d
 x"01010101010000000101000001000100",--e
 x"01010001010101010100000100000000", --f
 
 
 x"00010101010100000100000000000001",--g
 x"00000001010100000000010000010000",--h
 x"00000100000001010100010100010000",--i
 x"00010100000001000100000001000100" --19
 
 ); 
  

  
begin


 
 

R(0)<= KeyxDI xor InxDI;
 
--------------------------------------------------------------------------------------------------------------

rnds: for i in 1 to 19 generate 


sl01x: entity Slayer (sl) port map (R(i-1), SubxD(i));
  
ShufxD(i)<= SubxD(i)(127 downto 120) &  SubxD(i)(47  downto 40) & SubxD(i)(87  downto  80) & SubxD(i)(7   downto   0) &
            SubxD(i)(15  downto   8) &  SubxD(i)(95  downto 88) & SubxD(i)(39  downto  32) & SubxD(i)(119 downto 112) &
            SubxD(i)(55  downto  48) &  SubxD(i)(103 downto 96) & SubxD(i)(31  downto  24) & SubxD(i)(79  downto  72) &
            SubxD(i)(71  downto  64) &  SubxD(i)(23  downto 16) & SubxD(i)(111 downto 104) & SubxD(i)(63  downto  56) ;
 

ml01x: entity Matmult (m00) port map (ShufxD(i) , MultxD(i) );
   
R(i) <= MultxD(i) xor KeyxDI xor RC(i);  

end generate rnds;
--------------------------------------------------------------------------------------------------------------

sl0kx: entity Slayer (sl) port map (R(19), SxD);

OpxDO <= SxD xor KeyxDI ;


--------------------------------------------------------------------------------------------------------------
 





end architecture tach64;

