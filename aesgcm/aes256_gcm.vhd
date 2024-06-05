library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.all;
use work.aes256_gcm_pkg.all;

entity aes256_gcm is
    generic (rf_conf : rf_t_enum := rf_ttable_e;
	         sb_conf : sb_t_enum := sb_bonus_e;
	         mc_conf : mc_t_enum := mc_fast_e);
    port (clk     : in std_logic;
          reset_n : in std_logic;
          last    : in std_logic;

          iv  : in std_logic_vector(95 downto 0);
          key : in std_logic_vector(127 downto 0);
          
   
          
          data      : in std_logic_vector(127 downto 0);
        
          
          ct        : out std_logic_vector(127 downto 0));
     --     tag       : out std_logic_vector(127 downto 0);
       --   );
end entity;

architecture structural of aes256_gcm is

    signal state, next_state : state_type;
 
    signal count : integer;

 
     signal aes_in,aes_out : std_logic_vector(127 downto 0);

    signal gh_load : std_logic;
    signal hk_load : std_logic;
    signal tg_load : std_logic;

    signal gh_in, gh_out : std_logic_vector(127 downto 0);
    signal hk_in, hk_out : std_logic_vector(127 downto 0);
    signal int1,int2 : std_logic_vector(127 downto 0);

 
    signal mult_in0, mult_in1 ,mult_out: std_logic_vector(127 downto 0);
 
    signal count_t :  std_logic_vector(31 downto 0) ;

begin



 
    gh_in <=  (others => '0') when state = hk_state else  int2; 
    hk_in <= aes_out;
    
    hk_load <= '1' when state = hk_state else '0';
   

 
        
         count_t <= std_logic_vector(to_unsigned(count,32));
        aes_in  <= (others => '0') when state = hk_state else iv & count_t;
    

 
     
    mult_in1 <= hk_out;

    gh_reg : entity dffp generic map (128) port map (clk, gh_in, gh_out);
    hk_reg : entity dff  generic map (128) port map (clk, hk_load, hk_in, hk_out);
 
   
 
        aes_gen : entity aes generic map (rf_conf, sb_conf, mc_conf) port map ( key, aes_in, aes_out );
        
        
        
        gf_gen : entity gf128_mult port map (mult_in0, mult_in1, mult_out); 
    
    
        int1 <= aes_out xor data;
        
        int2 <= mult_out xor int1;
        
        ct <= mult_out when state=tag_state else int1;
        
        
        mult_in1 <= hk_out;
        mult_in0 <= gh_out;   
        
      
  p_clk: process (reset_n, clk)
         begin
           if reset_n='0' then
 
                    count   <= 0;
                    state <= hk_state;
	     
           elsif clk'event and clk ='1' then

	           count   <= count +1;
	           state <= next_state; 
           end if;
         end process p_clk;
   
 next_state <= msg_state when last='0' else tag_state;
 
end architecture;

