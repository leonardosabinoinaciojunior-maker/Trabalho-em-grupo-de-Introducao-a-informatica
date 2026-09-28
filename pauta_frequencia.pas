{ Pauta de Frequencia - Excluido, Admitido, Dispensado
  Regras:
    media < 10                          -> EXCLUIDO
    media >= 14 e nenhuma nota < 10     -> DISPENSADO
    restantes                           -> ADMITIDO
  Turma com pelo menos 10 estudantes }
program PautaFrequencia;

const
  MAXALUNOS = 50;
  MINALUNOS = 10;
  NAV = 3;            { numero de avaliacoes }
  NOTA_MIN = 10;      { nota abaixo disto e negativa }
  NOTA_DISP = 14;     { media minima para dispensa }

var
  nomes: array[1..MAXALUNOS] of string[30];
  notas: array[1..MAXALUNOS, 1..NAV] of real;
  media: array[1..MAXALUNOS] of real;
  estado: array[1..MAXALUNOS] of string[10];
  n: integer;

{ le o numero de estudantes, nomes e notas }
procedure LerTurma(var n: integer);
var
  i, j: integer;
begin
  repeat
    write('Numero de estudantes (min ', MINALUNOS, ', max ', MAXALUNOS, '): ');
    readln(n);
    if (n < MINALUNOS) or (n > MAXALUNOS) then
      writeln('Numero invalido! A turma deve ter pelo menos ', MINALUNOS, ' estudantes.');
  until (n >= MINALUNOS) and (n <= MAXALUNOS);

  for i := 1 to n do
  begin
    writeln;
    writeln('Estudante ', i);
    write('  Nome: ');
    readln(nomes[i]);
    for j := 1 to NAV do
    begin
      repeat
        write('  Nota da avaliacao ', j, ' (0-20): ');
        readln(notas[i, j]);
      until (notas[i, j] >= 0) and (notas[i, j] <= 20);
    end;
  end;
end;

{ calcula a media e o estado de cada estudante }
procedure CalcularEstados(n: integer);
var
  i, j: integer;
  soma: real;
  negativa: boolean;
begin
  for i := 1 to n do
  begin
    soma := 0;
    negativa := false;
    for j := 1 to NAV do
    begin
      soma := soma + notas[i, j];
      if notas[i, j] < NOTA_MIN then
        negativa := true;
    end;
    media[i] := soma / NAV;

    if media[i] < NOTA_MIN then
      estado[i] := 'EXCLUIDO'
    else if (media[i] >= NOTA_DISP) and (negativa = false) then
      estado[i] := 'DISPENSADO'
    else
      estado[i] := 'ADMITIDO';
  end;
end;

{ escreve um texto e completa com espacos ate ocupar 'larg' colunas }
procedure EscreverNome(s: string; larg: integer);
var
  k: integer;
begin
  write(s);
  for k := length(s) + 1 to larg do
    write(' ');
end;

procedure MostrarPauta(n: integer);
var
  i, j, nExc, nAdm, nDisp: integer;
begin
  nExc := 0;
  nAdm := 0;
  nDisp := 0;

  writeln;
  writeln('================ PAUTA DE FREQUENCIA ================');
  write('No  ');
  EscreverNome('Nome', 31);
  for j := 1 to NAV do
    write('Av', j, '     ');
  writeln('Media   Estado');
  writeln('-----------------------------------------------------');

  for i := 1 to n do
  begin
    write(i:2, '  ');
    EscreverNome(nomes[i], 31);
    for j := 1 to NAV do
      write(notas[i, j]:5:1, '  ');
    write(media[i]:6:2, '  ');
    writeln(estado[i]);

    if estado[i] = 'EXCLUIDO' then nExc := nExc + 1
    else if estado[i] = 'ADMITIDO' then nAdm := nAdm + 1
    else nDisp := nDisp + 1;
  end;

  writeln('-----------------------------------------------------');
  writeln('Total de estudantes: ', n);
  writeln('Dispensados: ', nDisp);
  writeln('Admitidos:   ', nAdm);
  writeln('Excluidos:   ', nExc);
end;

begin
  LerTurma(n);
  CalcularEstados(n);
  MostrarPauta(n);
  readln;
end.
