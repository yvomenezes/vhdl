entity registredouble is 
  generic (tcomb, tco:time; 
           N: natural := 4);
  port(A, B: in bit_vector(N-1 downto 0);
       sel, H: in bit;
       R: out bit_vector(N-1 downto 0));
end registredouble;

architecture algorithmique of registredouble is
  begin
    process(H)
      variable V: bit_vector(N-1 downto 0);
      begin
        if(H='1' and H' event) then
          case sel is 
	    when '0' => V := A;
            when '1' => V := B;
	  end case;
        end if;
	R <= V after tco; 
    end process;
end algorithmique;

architecture structurelle of registredouble is
  component mux
    generic (tmux: time := 3 ns;
	     N: natural := 2);
    port(A, B: in bit_vector(N-1 downto 0);
         sel: in bit;
         V: out bit_vector(N-1 downto 0));
  end component;
  component registre 
    generic (tco: time := 2 ns;
	     N: natural := 2);
    port(V: in bit_vector(N-1 downto 0);
         H: in bit;
         R: out bit_vector(N-1 downto 0));
  end component;
  signal X: bit_vector(N-1 downto 0);
begin
  mux1:mux generic map(tmux => tcomb, N=>N) port map(A => A, B => B, sel => sel, V => X);
  reg1:registre generic map(tco => tco, N=>N) port map(V => X, H => H, R => R);
end structurelle;

architecture flot of registredouble is
signal V: bit_vector(N-1 downto 0);
begin
   V <= A after tcomb when sel = '0' else
 	B after tcomb when sel = '1'; 
   R <= V after tco when H = '1' and H' event; 
end flot;
   
