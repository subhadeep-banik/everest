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

entity Amds is
  
  port (
    InpxDI : in  std_logic_vector(31 downto 0);
    OupxDO : out std_logic_vector(31 downto 0)
    );

end Amds;


architecture a01 of Amds is


signal X0xD, X1xD, X2xD, X3xD: std_logic_vector(7 downto 0);
signal X03xD, X12xD          : std_logic_vector(7 downto 0);
signal Y0xD, Y1xD, Y2xD, Y3xD: std_logic_vector(7 downto 0);
  
begin   

 X0xD <= InpxDI(31 downto 24); X1xD <= InpxDI(23 downto 16); X2xD <= InpxDI(15 downto 8); X3xD <= InpxDI(7 downto 0);
 
 X12xD <= X1xD xor X2xD;
 X03xD <= X0xD xor X3xD;
 
 Y0xD <= X3xD xor X12xD;
 Y1xD <= X2xD xor X03xD;
 Y2xD <= X1xD xor X03xD;
 Y3xD <= X0xD xor X12xD;   
 
 OupxDO <= Y0xD & Y1xD & Y2xD & Y3xD; 
  

end architecture a01;
 
