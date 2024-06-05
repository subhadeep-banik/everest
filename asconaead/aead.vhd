library ieee;
use ieee.std_logic_1164.all;

entity aead is
    port(clk   : in std_logic;
 
         reset : in std_logic;

         key          : in std_logic_vector(127 downto 0);
         nonce        : in std_logic_vector(127 downto 0);
         data         : in std_logic_vector(63 downto 0);

         last_block   : in std_logic;
         --last_partial : in std_logic;

         empty_ad     : in std_logic;
         empty_pt    : in std_logic;

         ct_out : out std_logic;
         tag_out: out std_logic;
         ciphertext : out std_logic_vector(127 downto 0));
      --   tag        : out std_logic_vector(127 downto 0));
end;

architecture behaviour of aead is

 
    
    
    signal istate , istate_n : std_logic_vector(2 downto 0);

    signal cyc: std_logic;
    
    signal c1: std_logic_vector(127 downto 0);

    signal c2,reg,reg_n,pin,pout,init,const:      std_logic_vector(319 downto 0);
    
begin

 
    init <= x"80400c0600000000" & key & nonce;
    
    asp_core : entity work.asconp
 
        port map (pin,cyc,pout);
        
 
    
    pin (319 downto 256) <= reg(319 downto 256) xor data;
    pin (255 downto 0) <= reg(255 downto 0);
    
    c2 <=   const xor pout;
    c1 <=   (pout (127 downto 0) xor key);
    
    ciphertext <= pin (319 downto 256)  &  x"0000000000000000"  when istate="011" else c1;
    
    reg_n <=  init when  istate = "000" else   c2 ;
    
 


    const  <=  x"0000000000000000" & x"0000000000000000" & x"0000000000000000" & key                                         when istate="010" else
               x"0000000000000000" & x"0000000000000000" & x"0000000000000000" &  x"0000000000000000" & x"0000000000000001"  when istate="011" and last_block='1' else
               x"0000000000000000" & key                                       &  x"0000000000000000" & x"0000000000000000"  when istate="100" and last_block='1' else
               x"0000000000000000" & x"0000000000000000" & x"0000000000000000" &  x"0000000000000000" & x"0000000000000000";      
    
    
    cyc <= '1' when istate="010" or istate = "111" else '0';
       
    ct_out <='1' when istate="100" else '0';
    tag_out <='1' when istate="111" else '0';    

  p_clk: process (all)
         begin      
    if reset='0' then 
     reg <= (others=>'0');
     istate <= "000"; 
    elsif clk'event and clk ='1' then
     reg<= reg_n;
     
     istate <= istate_n;
    end if;
 end process p_clk;
    
    
   p_istate : process (all)
   
   begin
         if istate = "000" then --load
         
            istate_n <= "001"; -- 1st cycle of init
         
         end if;
         
         if istate = "001" then 
         
            istate_n <= "010"; -- 2nd cycle of init
         
         end if;
       
         
         
         
  ----------------------------------------------------          
         if istate = "010" then -- second cycle of init
         
            if empty_ad = '1' and empty_pt = '1' then 
                
               istate_n <= "110" ;--final
            
            elsif  empty_ad = '1' and empty_pt = '0' then 
   
               istate_n <= "100"; -- process pt
               
            else
            
               istate_n <= "011"; --- process ad
             
             end if;
               
         end if;   
    ----------------------------------------------------        
      if istate = "011" then     --- process ad
     
         if last_block ='0' then 
         
            istate_n <= "011"; ---keep proc ad
            
         elsif empty_pt='1' then 
         
             istate_n <= "110" ;  --final
         
         else
           
             istate_n <= "100"; --process pt
             
         end if;
         
      end if;
   ----------------------------------------------------   
      if istate = "100" then 
         if last_block ='0' then 
            istate_n <= "100"; ---keep proc pt
         else
            istate_n <= "110";
         end if;
         
      end if;
     ----------------------------------------------------       
       if istate = "110" then 
          istate_n<="111"; --final2
       end if;   
      
   end process p_istate;
    
 
end;

  
