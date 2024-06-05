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
use work.all;

entity Lin is
  
  port (
    InpxDI : in  std_logic_vector(127 downto 0);
    OupxDO : out std_logic_vector(127 downto 0)
    );

end Lin;


architecture l0 of Lin is


signal X0xD, X1xD : std_logic_vector(127 downto 0);
 
begin   

           
kml01: entity Matmult (m00) port map (InpxDI, X0xD);
  
  X1xD <= X0xD(127 downto 120) &  X0xD(71  downto  64) & X0xD(15  downto   8) & X0xD(55  downto 48) &
          X0xD(87  downto  80) &  X0xD(111 downto 104) & X0xD(39  downto  32) & X0xD(31  downto 24) &
          X0xD(7   downto   0) &  X0xD(63  downto  56) & X0xD(119 downto 112) & X0xD(79  downto 72) &
          X0xD(47  downto  40) &  X0xD(23  downto  16) & X0xD(95  downto  88) & X0xD(103 downto 96) ;

 

  

OupxDO<=X1xD;
  

end architecture l0;
 
