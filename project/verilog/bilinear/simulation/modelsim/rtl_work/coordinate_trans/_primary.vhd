library verilog;
use verilog.vl_types.all;
entity coordinate_trans is
    port(
        clk             : in     vl_logic;
        src_width       : in     vl_logic_vector(7 downto 0);
        start           : in     vl_logic;
        coordinate_x    : out    vl_logic_vector(9 downto 0);
        coordinate_y    : out    vl_logic_vector(9 downto 0);
        coefficient1    : out    vl_logic_vector(9 downto 0);
        coefficient2    : out    vl_logic_vector(9 downto 0);
        coefficient3    : out    vl_logic_vector(9 downto 0);
        coefficient4    : out    vl_logic_vector(9 downto 0);
        en              : out    vl_logic
    );
end coordinate_trans;
