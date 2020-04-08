library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.types.all;

entity seg7_encoder is
  port (
    digit : in digit_type;
    segments : out std_logic_vector(6 downto 0)
  );
end seg7_encoder; 

architecture rtl of seg7_encoder is

begin

  ENCODER_PROC : process(digit)
  begin
    case digit is

      when 0 => segments <= "0111111";
      when 1 => segments <= "0000110";
      when 2 => segments <= "1011011";
      when 3 => segments <= "1001111";
      when 4 => segments <= "1100110";
      when 5 => segments <= "1101101";
      when 6 => segments <= "1111101";
      when 7 => segments <= "0000111";
      when 8 => segments <= "1111111";
      when 9 => segments <= "1101111";
    
      end case;
  end process;

end architecture;