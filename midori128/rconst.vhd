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
use ieee.numeric_std.all;               -- contains conversion functions

entity Rconst is
  
  port (
    InpxDI : in  std_logic_vector(127 downto 0);
    RCxDI  : in  std_logic_vector(15 downto 0);
    OupxDO : out std_logic_vector(127 downto 0)
    );

end Rconst;


architecture rc of Rconst is


signal A1xD,A2xD,A3xD, A4xD,A5xD,A6xD: std_logic_vector(4 downto 0);
  
begin   

loop1: for i in 0 to 15 generate
  
  OupxDO(8*i) <= InpxDI(8*i) xor RCxDI(i);

end generate loop1;

loop2: for i in 0 to 15 generate
  
  loop3: for j in 1 to 7  generate
  
  
      OupxDO(8*i+j) <= InpxDI(8*i+j);
      
  end generate loop3;
    

end generate loop2;
  
 

end architecture rc;
