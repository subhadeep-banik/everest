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
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.all;

entity Mux64 is 
port ( In0xDI, In1xDI : in std_logic_vector(63 downto 0);
       SelxSI : in std_logic;
       OpxDO : out std_logic_vector(63 downto 0));
end entity Mux64;

architecture m64 of Mux64 is 
 
begin
 process (In0xDI,In1xDI, SelxSI) is
   begin
     if SelxSI = '0' then
   OpxDO <= In0xDI;
elsif SelxSI = '1' then
   OpxDO <= In1xDI;
end if;

end process;

end architecture m64;
