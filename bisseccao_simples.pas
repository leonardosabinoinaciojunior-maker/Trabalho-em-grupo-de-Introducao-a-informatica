{ Bisseccao - versao simples (sintaxe basica, sem objectos)
  Paragem: precisao 0.001 ou 100 iteracoes }
program Trabalho;

var
  a, b, h, x0, x1, f0, f1: real;
  raizes: array[1..100] of real;
  n, i: integer;

{ funcao em estudo: calcula y = f(x) }
procedure F(x: real; var y: real);
begin
  y := x * x * x - 2 * x - 5;
end;

{ metodo da bisseccao em [a,b] }
procedure Metodo(a, b: real; var raiz: real);
var
  m, fa, fm: real;
  k: integer;
  fim: boolean;
begin
  k := 0;
  fim := false;
  F(a, fa);
  while (k < 100) and (fim = false) do
  begin
    k := k + 1;
    m := (a + b) / 2;
    F(m, fm);
    if (fm = 0) or ((b - a) / 2 < 0.001) then
      fim := true
    else if fa * fm < 0 then
      b := m
    else
    begin
      a := m;
      fa := fm;
    end;
  end;
  raiz := m;
end;

begin
  write('Introduza a: ');
  readln(a);
  write('Introduza b: ');
  readln(b);

  { procura subintervalos onde f muda de sinal }
  h := (b - a) / 1000;
  n := 0;
  for i := 0 to 999 do
  begin
    x0 := a + i * h;
    x1 := x0 + h;
    F(x0, f0);
    F(x1, f1);
    if n < 100 then
    begin
      if f0 = 0 then
      begin
        n := n + 1;
        raizes[n] := x0;
      end
      else if f0 * f1 < 0 then
      begin
        n := n + 1;
        Metodo(x0, x1, raizes[n]);
      end;
    end;
  end;

  if n = 0 then
    writeln('Nao ha raizes no intervalo.')
  else
    for i := 1 to n do
      writeln('Raiz ', i, ' = ', raizes[i]:10:6);

  readln;
end.
