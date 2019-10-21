entity tb_registredouble is
end tb_registredouble;
architecture bench of tb_registredouble is
  component registredouble
    generic (tcomb, tco:time; 
             N: natural := 4);
    port(A, B: in bit_vector(N-1 downto 0);
         sel, H: in bit;
         R: out bit_vector(N-1 downto 0));
  end component;
  for UUT:registredouble use entity work.registredouble(flot);
  constant tco: time := 2 ns;
  constant tcomb: time := 3 ns;
  constant N: natural := 4;
  signal A, B, R: bit_vector(3 downto 0);
  signal sel, H: bit; 
  begin 
	UUT:registredouble generic map(tcomb => tcomb,tco => tco, N => N) port map(A, B, sel, H, R);
	A <= "1010" after 2 ns, "0110" after 5 ns, "1100" after 10 ns;
	B <= "1001" after 3 ns, "1011" after 5 ns, "0000" after 8 ns, "1111" after 10 ns;
	H <= '1' after 4 ns, '0' after 5 ns, '1' after 6 ns, '0' after 7 ns, '1' after 10 ns;
	sel <= '0' after 2 ns, '1' after 5 ns, '1' after 6 ns;
end bench;