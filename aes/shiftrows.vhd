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

entity shiftrows is
  port(
    InxDI   : in  std_logic_vector (127 downto 0);
    OutxDO  : out std_logic_vector (127 downto 0)
  );
end shiftrows;

architecture permutation of shiftrows is

  type BytesType is array (0 to 15) of std_logic_vector (7 downto 0);
  signal InBxD, OutBxD : BytesType;
  
begin

-- hmm earlier version had fucked up the ordering of the bytes..
-- So when you have a 128 bit data Byte 0 is 127..120 
  
  gen_byte_assign: for i in 0 to 15 generate
                     InBxD(i)                      <= InxDI(((15-i)*8)+7 downto (15-i)*8);
                     OutxDO(((15-i)*8)+7 downto (15-i)*8) <= OutBxD(i);
                   end generate gen_byte_assign;
-- Row 0   as it is 
  OutBxD(0) <= InBxD( 0); OutBxD(4) <= InBxD( 4); OutBxD( 8) <= InBxD( 8); OutBxD(12) <= InBxD(12); 
-- Row 1   one left
  OutBxD(1) <= InBxD( 5); OutBxD(5) <= InBxD( 9); OutBxD( 9) <= InBxD(13); OutBxD(13) <= InBxD( 1); 
-- Row 2   two left
  OutBxD(2) <= InBxD(10); OutBxD(6) <= InBxD(14); OutBxD(10) <= InBxD( 2); OutBxD(14) <= InBxD( 6); 
-- Row 3   three left
  OutBxD(3) <= InBxD(15); OutBxD(7) <= InBxD( 3); OutBxD(11) <= InBxD( 7); OutBxD(15) <= InBxD(11); 


                     
  
end permutation;

