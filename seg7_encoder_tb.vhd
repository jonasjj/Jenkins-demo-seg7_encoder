library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.sim.all;
use pck_lib.types.all;

entity seg7_encoder_tb is
end seg7_encoder_tb;

library seg7_encoder_lib;

architecture sim of seg7_encoder_tb is

  signal digit : digit_type; 
  signal segments : std_logic_vector(6 downto 0);

  type numbers_type is array (0 to 9) of integer;
  signal numbers : numbers_type := (others => -1);

begin

  DUT : entity seg7_encoder_lib.seg7_encoder(rtl)
  port map (
    digit => digit,
    segments => segments
  );

  SEQUENCER_PROC : process
    variable out_val : integer;
  begin

    for i in 0 to 9 loop
      digit <= i;
      wait for 1 ns;
      out_val := to_integer(unsigned(segments));

      report "Testing digit = " & integer'image(digit);

      -- Check that this combination of segments hasn't been used before
      -- for another digit. I don't see the value of repeating the
      -- segments mapping in the testbench. This test may catch copy-paste errors.
      for j in 0 to i loop
        assert numbers(j) /= out_val
          report "This segments combination has been used for another digit"
          severity failure;
      end loop;

      numbers(i) <= out_val;

    end loop;

    print_ok_and_finish;
  end process;

end architecture;