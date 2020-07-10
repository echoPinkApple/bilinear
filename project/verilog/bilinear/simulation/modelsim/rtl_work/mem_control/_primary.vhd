library verilog;
use verilog.vl_types.all;
entity mem_control is
    port(
        clk             : in     vl_logic;
        coordinate_x    : in     vl_logic_vector(9 downto 0);
        coordinate_y    : in     vl_logic_vector(9 downto 0);
        src_width       : in     vl_logic_vector(7 downto 0);
        doutbx          : out    vl_logic_vector(7 downto 0);
        doutbx1         : out    vl_logic_vector(7 downto 0);
        doutby          : out    vl_logic_vector(7 downto 0);
        doutby1         : out    vl_logic_vector(7 downto 0)
    );
end mem_control;
