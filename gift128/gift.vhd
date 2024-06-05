library ieee;
use ieee.std_logic_1164.all;

entity gift is
 
    port(key_in    : in  std_logic_vector(127 downto 0);
 
         state_in  : in  std_logic_vector(127 downto 0);
         state_out : out std_logic_vector(127 downto 0);
         clk      : in std_logic);
end;

architecture structural of gift is

    constant b : integer := 128;
    constant c : integer := 6;
    constant r : integer := 40;
    signal csts   : std_logic_vector((r+1)*c-1 downto 0);
    signal keys   : std_logic_vector((r+1)*b-1 downto 0);
    signal states : std_logic_vector((r+1)*b-1 downto 0);

    signal done_tmp : std_logic;

begin

   
     
        
         keys(b-1 downto 0)<=key_in;
         csts(c-1 downto 0) <= "000001";
         states(b-1 downto 0)<= state_in;

    rounds : for i in 1 to 40 generate
        ke : entity work.keyexpansion
            port map (keys((i)*b-1 downto (i-1)*b), keys((i+1)*b-1 downto (i)*b));
        cl : entity work.roundconstant
            port map (csts((i)*c-1 downto (i-1)*c), csts((i+1)*c-1 downto (i)*c));
        rf : entity work.roundfunction
            port map (csts((i)*c-1 downto (i-1)*c), keys((i)*b-1 downto (i-1)*b),
                      states((i)*b-1 downto (i-1)*b), states((i+1)*b-1 downto (i)*b));
    end generate;


     
        state_out <= states((r+1)*b-1 downto (r)*b);
     

end;

