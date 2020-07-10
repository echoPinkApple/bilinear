library verilog;
use verilog.vl_types.all;
entity bilinear is
    generic(
        src_width       : vl_logic_vector(7 downto 0) := (Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        start           : in     vl_logic;
        doutb           : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of src_width : constant is 2;
end bilinear;
