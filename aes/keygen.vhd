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

entity keygen is
  port (
     KeyxDI      : in  std_logic_vector(127 downto 0);
     RconxDI     : in  std_logic_vector(7 downto 0); 
     RoundKeyxDO : out std_logic_vector(127 downto 0)
  );

end keygen;

architecture behav of keygen is

 

 

  
  signal KeyxDP, KeyxDN,KeyxD,NewKeyxD  : std_logic_vector(127 downto 0); 

  signal RotWordxD : std_logic_vector(31 downto 0);
  signal SubWordxD : std_logic_vector(31 downto 0);
  signal TempxD    : std_logic_vector(31 downto 0);
 
  
begin

  KeyxD(31 downto  0) <= KeyxD (63 downto 32) xor KeyxDI(31 downto  0);
  KeyxD(63 downto 32) <= KeyxD (95 downto 64) xor KeyxDI(63 downto 32);
  KeyxD(95 downto 64) <= KeyxD (127 downto 96) xor KeyxDI(95 downto 64);

  RotWordxD <= KeyxDI(23 downto 0) & KeyxDI(31 downto 24);
  
  g_sbox: for i in 0 to 3 generate
               i_sbox: entity sbox (maximov)
                       port map (
                                 InpxDI => RotWordxD(((i+1)*8)-1 downto i*8),
                                 OupxDO => SubWordxD(((i+1)*8)-1 downto i*8));
          end generate g_sbox;

 
   
   TempxD(31 downto 24) <=RconxDI xor SubWordxD(31 downto 24);

   TempxD(23 downto 0) <=  SubWordxD(23 downto 0);
   
   
   KeyxD(127 downto 96) <= TempxD xor KeyxDI(127 downto 96);            



  RoundKeyxDO<= KeyxD;
 
         
end architecture behav;
