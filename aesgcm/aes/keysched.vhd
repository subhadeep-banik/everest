library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.aes256_gcm_pkg.all;

entity keysched is
    generic (sb_conf : sb_t_enum);
    port (r : in  std_logic_vector(7 downto 0) ;
          x     : in  std_logic_vector(127 downto 0);
          y     : out std_logic_vector(127 downto 0));
end entity;

architecture parallel of keysched is
    


    signal sbox_in, sbox_out : std_logic_vector(31 downto 0);
    signal t, c0, c1, c2, c3 : std_logic_vector(31 downto 0);

    signal index : integer range 0 to 9;
 

begin

    sbox_in <= x(31 downto 0);

 
    
    t <= (sbox_out(23 downto 16) xor r) &
          sbox_out(15 downto 8) &
          sbox_out(7 downto 0) &
          sbox_out(31 downto 24) ;--when cycle(0) = '1' else sbox_out;

    c0 <= x(127 downto 96) xor t;
    c1 <= x(95 downto 64) xor c0;
    c2 <= x(63 downto 32) xor c1;
    c3 <= x(31 downto 0) xor c2;

    y <=   c0 & c1 & c2 & c3;

    sb_bonus_gen : if sb_conf = sb_bonus_e generate
        sb_bonus_byte_gen : for i in 0 to 3 generate
            sbox : entity sb_bonus port map (
                sbox_in((i+1)*8 - 1 downto i*8), 
                sbox_out((i+1)*8 - 1 downto i*8)
            ); 
        end generate;
    end generate;
    
    sb_fast_gen : if sb_conf = sb_fast_e generate
        sb_fast_byte_gen : for i in 0 to 3 generate
            sbox : entity sb_fast port map (
                sbox_in((i+1)*8 - 1 downto i*8), 
                sbox_out((i+1)*8 - 1 downto i*8)
            ); 
        end generate;
    end generate;
    
    sb_tradeoff_gen : if sb_conf = sb_tradeoff_e generate
        sb_tradeoff_byte_gen : for i in 0 to 3 generate
            sbox : entity sb_tradeoff port map (
                sbox_in((i+1)*8 - 1 downto i*8), 
                sbox_out((i+1)*8 - 1 downto i*8)
            ); 
        end generate;
    end generate;
    
    sb_dse_gen : if sb_conf = sb_dse_e generate
        sb_dse_fast_gen : for i in 0 to 3 generate
            sbox : entity sb_dse port map (
                sbox_in((i+1)*8 - 1 downto i*8), 
                sbox_out((i+1)*8 - 1 downto i*8)
            ); 
        end generate;
    end generate;
    
    sb_lut_gen : if sb_conf = sb_lut_e generate
        sb_lut_byte_gen : for i in 0 to 3 generate
            sbox : entity sb_lut port map (
                sbox_in((i+1)*8 - 1 downto i*8), 
                sbox_out((i+1)*8 - 1 downto i*8)
            ); 
        end generate;
    end generate;

end architecture;

