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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.all;
     -- Brings NW and BW; NW is num_of_words-1 and BW is the bit_width  

entity aes is
  port(
        InxDI     : in  std_logic_vector(127 downto 0);
        KeyxDI    : in  std_logic_vector(127 downto 0);
        OutxDO    : out std_logic_vector(127 downto 0);
        ClkxCI    : in std_logic 
      );

end aes;


architecture behav of aes is

   
 
 type Sigtype is array (0 to 10) of std_logic_vector(127 downto 0);
 signal CT,RK: Sigtype;  
 
 
  
   type RconType is array (0 to 14) of std_logic_vector(7 downto 0);
 constant RC : RconType := (
 x"00",
 x"01",
 x"02",
 x"04",
 x"08",
 x"10",
 x"20",
 x"40",
 x"80",
 x"1B",
 x"36",
 x"6C",
 x"D8", 
 x"AB",
 x"4D"
 ); 
  
  
  
begin

 
OutxDO  <= CT(10);


 
CT(0) <= InxDI xor KeyXDI; 
RK(0) <= KeyXDI; 
   
 f9: for i in 1 to 9 generate
           
  i_encrypt128_1: entity encrypt128_n (behav)
    port map (
      InxDI       => CT(i-1),
      OutxDO      => CT(i),
      RoundKeyxDI => RK(i));
      
end generate f9;
      
 
 i_encrypt128_a: entity encrypt128 (behav)
    port map (
      InxDI       => CT(9),
      OutxDO      => CT(10),
      RoundKeyxDI => RK(10));   



k10: for i in 1 to 10 generate    

       
    i_keygen1: entity keygen (behav)
     port map (
        KeyxDI      => RK(i-1),
        RconxDI     => RC(i),
        RoundKeyxDO => RK(i));
 
      
end generate k10;
   

  
end architecture behav;
