library ieee;
use ieee.std_logic_1164.all;
 
entity dffp is
   generic(n : integer := 128);
   port (clk     : in std_logic;
         d       : in  std_logic_vector(n-1 downto 0);
         q       : out std_logic_vector(n-1 downto 0));
end entity;

architecture behavioural of dffp is
begin

    bank : process(clk)
    begin
        --if reset_n = '0' then
        --    q <= (others => '0');
        --elsif rising_edge(clk) then
        if rising_edge(clk) then
 
                q <= d;
 
        end if;
    end process;

end architecture;

