library verilog;
use verilog.vl_types.all;
entity bilinear_cal is
    port(
        clk             : in     vl_logic;
        coefficient1    : in     vl_logic_vector(9 downto 0);
        coefficient2    : in     vl_logic_vector(9 downto 0);
        coefficient3    : in     vl_logic_vector(9 downto 0);
        coefficient4    : in     vl_logic_vector(9 downto 0);
        en_b            : in     vl_logic;
        doutbx          : in     vl_logic_vector(7 downto 0);
        doutbx1         : in     vl_logic_vector(7 downto 0);
        doutby          : in     vl_logic_vector(7 downto 0);
        doutby1         : in     vl_logic_vector(7 downto 0);
        data_o          : out    vl_logic_vector(7 downto 0);
        en_o            : out    vl_logic
    );
end bilinear_cal;
