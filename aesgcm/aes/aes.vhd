library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.aes256_gcm_pkg.all;

entity aes is
    generic (rf_conf : rf_t_enum := rf_ttable_e;
             sb_conf : sb_t_enum := sb_bonus_e;
	         mc_conf : mc_t_enum := mc_small_e);
    port ( 
          key : in  std_logic_vector(127 downto 0);
          pt  : in  std_logic_vector(127 downto 0);
          ct  : out std_logic_vector(127 downto 0));
end entity;

architecture structural of aes is

    type stype is array (0 to 10) of std_logic_vector(127 downto 0);

    signal sbox_out       : stype;
    signal shiftrows_out  : stype;
    signal mixcolumns_out : stype;
    signal mixttable_out  : stype;

    signal state_in  : stype;
    signal key_in   : stype;
 

 
    signal inter    : std_logic_vector(127 downto 0);
    
    subtype Int8Type is integer range 0 to 255;
    type RconType is array (0 to 9) of std_logic_vector(7 downto 0);
    constant Rcon : RconType := (x"01", x"02", x"04", x"08", x"10", x"20", x"40", x"80", x"1B", x"36");

begin

 
 
    ct       <= state_in(10);
 

    state_in (0) <= key  xor pt;
 
    key_in (0)   <= key ;

 z1: for i in 1 to 9 generate
    ks  : entity keysched generic map (sb_conf) port map (Rcon(i-1), key_in(i-1), key_in(i));

    rf_split_gen : if rf_conf = rf_split_e generate
        subbytes_gen    : entity subbytes   generic map (sb_conf) port map (state_in(i-1), sbox_out(i-1) );
        shiftrows_gen   : entity shiftrows  port map (sbox_out(i-1), shiftrows_out(i-1));
        mixcolumns_gen  : entity mixcolumns generic map (mc_conf) port map (shiftrows_out(i-1), mixcolumns_out(i-1));
        addroundkey_gen : entity addroundkey port map (mixcolumns_out(i-1), key_in(i), state_in(i));

 
    end generate;

    rf_ttable_gen : if rf_conf = rf_ttable_e generate
        mixttable_gen   : entity mixttable   port map (state_in(i-1), mixttable_out(i-1));
        addroundkey_gen : entity addroundkey port map (mixttable_out(i-1), key_in(i), state_in(i));
    end generate;
    
end generate z1;


    ks  : entity keysched generic map (sb_conf) port map (Rcon(9), key_in(9), key_in(10));

    rf_split_gen : if rf_conf = rf_split_e generate
        subbytes_gen    : entity subbytes   generic map (sb_conf) port map (state_in(9), sbox_out(9) );
        shiftrows_gen   : entity shiftrows  port map (sbox_out(9), shiftrows_out(9));
 
        addroundkey_gen : entity addroundkey port map (shiftrows_out(9), key_in(10), state_in(10));

 
    end generate;

    rf_ttable_gen : if rf_conf = rf_ttable_e generate
        mixttable_gen   : entity mixttable1   port map (state_in(9),  inter );
        addroundkey_gen : entity addroundkey port map (inter , key_in(10), state_in(10));
    end generate;



end architecture;

