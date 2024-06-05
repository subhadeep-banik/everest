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

entity Matmult is
  
  port (
    InpxDI : in  std_logic_vector(127 downto 0);
    OupxDO : out std_logic_vector(127 downto 0)
    );

end Matmult;


architecture m00 of Matmult is


signal X0xD, X1xD, X2xD, X3xD: std_logic_vector(31 downto 0);
signal Y0xD, Y1xD, Y2xD, Y3xD: std_logic_vector(31 downto 0);
  
begin   

 X0xD <= InpxDI(127 downto 96); X1xD <= InpxDI(95 downto 64); X2xD <= InpxDI(63 downto 32); X3xD <= InpxDI(31 downto 0);
 
 
 n0: entity Amds (a01) port map(X0xD,Y0xD);
 n1: entity Amds (a01) port map(X1xD,Y1xD);
 n2: entity Amds (a01) port map(X2xD,Y2xD);
 n3: entity Amds (a01) port map(X3xD,Y3xD);  
 
 OupxDO <= Y0xD & Y1xD & Y2xD & Y3xD; 
  

end architecture m00;
 
