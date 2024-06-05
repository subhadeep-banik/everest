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
use work.all;

entity encrypt128 is
  port (
         InxDI      : in  std_logic_vector(127 downto 0);
         OutxDO     : out std_logic_vector(127 downto 0);
         RoundKeyxDI: in  std_logic_vector(127 downto 0));
end encrypt128;

architecture behav of encrypt128 is


 

-- intermediate signals 
  signal AddxD, RowsxD, ColsxD, MixedxD, BytesxD : std_logic_vector(127 downto 0);
  
  
begin

-------------------------------------------------------------------------------
-- SBOX
-------------------------------------------------------------------------------

 g_sbox: for i in 0 to 15 generate 
  
          i_sbox: entity sbox (maximov)
                  port map (
                            InpxDI => InxDI ( ((i+1)*8)-1 downto i*8),
                            OupxDO => BytesxD( ((i+1)*8)-1 downto i*8));
          end generate g_sbox;
          
-------------------------------------------------------------------------------
-- ShiftRows
-------------------------------------------------------------------------------
  
  i_shiftrows: entity shiftrows (permutation)
    port map (
      InxDI  => BytesxD,
      OutxDO => RowsxD);

ColsxD<= RowsxD;  


  
-------------------------------------------------------------------------------
-- AddRoundKey
-------------------------------------------------------------------------------

 


  AddxD <= ColsxD xor RoundKeyxDI;
         
  OutxDO <= AddxD;
 
  

  

end architecture behav;
