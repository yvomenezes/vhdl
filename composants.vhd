entity mux is 
  generic (tmux: time := 3 ns;
	   N: natural := 2);
  port(A, B: in bit_vector(N-1 downto 0);
       sel: in bit;
       V: out bit_vector(N-1 downto 0));
end mux;

architecture beh of mux is 
  begin
    process(sel, A, B)      
      variable X: bit_vector(N-1 downto 0);
      begin
        case sel is 
          when '0' => X := A;
	  when '1' => X := B;
        end case; 
	V <= X after tmux;
    end process;
end beh;


entity registre is 
  generic (tco: time := 2 ns;
	   N: natural := 2);
  port(V: in bit_vector(N-1 downto 0);
       H: in bit;
       R: out bit_vector(N-1 downto 0));
end registre;

architecture beh of registre is
  begin
    process(H)
      begin
        if(H='1' and H' event) then
          R <= V after tco;
        end if;
    end process;
end beh;
