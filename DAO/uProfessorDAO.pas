unit uProfessorDAO;

interface

uses system.SysUtils, uDAO, uProfessor, uEndereco, system.Generics.Collections,
  FireDac.comp.Client;

type
  TProfessorDAO = class(TconectDAO)
  private
    FListaProfessor: TObjectList<TProfessor>;
    procedure CriaLista(Ds: TFDQuery);
  public
    Constructor Create;
    Destructor Destroy; override;
    function CadastrarProfessor(pProfessor: TProfessor;
      pEndereco: TEndereco): boolean;
    function CadastrarProfessor_Curso(pProfessor: TProfessor): boolean;
    function PesquisaProfessor(pProfessor: TProfessor): TObjectList<TProfessor>;

  end;

implementation

{ TProfessorDAO }

function TProfessorDAO.CadastrarProfessor(pProfessor: TProfessor;
  pEndereco: TEndereco): boolean;
var
  SQL: string;
begin

  SQL := 'select id_endereco from endereco '+
  'where id_endereco not in (select id_endereco from aluno) '+
  'and id_endereco not in (select id_endereco from professor)';

  FQuery := RetornarDataSet(SQL);

  pEndereco.id := FQuery.fieldByName('id_endereco').AsInteger;

  SQL := 'INSERT INTO professor VALUES(default, ' + QuotedSTR(pProfessor.Nome) +
    ', ' + QuotedSTR(InttoStr(pEndereco.id)) + ', ' +
    QuotedSTR(FormatDateTime('dd/mm/yyyy', pProfessor.DataNasc)) + ', ' +
    QuotedSTR(pProfessor.Cpf) + ', ' + QuotedSTR(pProfessor.rg) + ', ' +
    QuotedSTR(pProfessor.CNPJ) + ', ' + QuotedSTR(pProfessor.contato) + ', ' +
    QuotedSTR(pProfessor.email) + ')';

  result := executarComando(SQL) > 0;
end;

function TProfessorDAO.CadastrarProfessor_Curso(pProfessor: TProfessor)
  : boolean;
var
  I: integer;
  SQL: string;
begin
  for I := 0 to pProfessor.Tamanho - 1 do
    if pProfessor.Cursos[I] <> '' then
    begin
      SQL := 'SELECT id_Professor FROM professor WHERE cpf = ' +
        QuotedSTR(pProfessor.Cpf);
      FQuery := RetornarDataSet(SQL);
      pProfessor.id := FQuery.fieldByName('id_professor').AsInteger;

      SQL := 'SELECT id_curso FROM curso WHERE nome = ' +
        QuotedSTR(pProfessor.Cursos[I]);
      FQuery := RetornarDataSet(SQL);
      pProfessor.Curso := FQuery.fieldByName('id_curso').AsString;

      SQL := 'INSERT INTO professor_curso VALUES (' +
        QuotedSTR(InttoStr(pProfessor.id)) + ', ' +
        QuotedSTR(pProfessor.Curso) + ')';

      result := executarComando(SQL) > 0;
    end;

end;

constructor TProfessorDAO.Create;
begin
  inherited;

  FListaProfessor := TObjectList<TProfessor>.Create;
end;

procedure TProfessorDAO.CriaLista(Ds: TFDQuery);
var
  I, count: integer;
  SQL: string;
begin
  I := 0;
  FListaProfessor.Clear;

  while not Ds.eof do
  begin
    FListaProfessor.Add(TProfessor.Create);
    FListaProfessor[I].id := Ds.fieldByName('id_professor').AsInteger;
    FListaProfessor[I].Nome := Ds.fieldByName('nome').AsString;
    FListaProfessor[I].IDEndereco := Ds.fieldByName('id_endereco').AsInteger;
    FListaProfessor[I].DataNasc := Ds.fieldByName('data_nasc').AsDateTime;
    FListaProfessor[I].Cpf := Ds.fieldByName('cpf').AsString;
    FListaProfessor[I].rg := Ds.fieldByName('rg').AsString;
    FListaProfessor[I].CNPJ := Ds.fieldByName('cnpj').AsString;
    FListaProfessor[I].contato := Ds.fieldByName('telefone').AsString;
    FListaProfessor[I].email := Ds.fieldByName('email').AsString;

    SQL := 'SELECT id_curso FROM professor_curso WHERE id_professor = ' +
      QuotedSTR(Ds.fieldByName('id_professor').AsString);

    FQuery2 := RetornarDataSet2(SQL);
    while not FQuery2.eof do
    begin
      FListaProfessor[I].Tamanho := FListaProfessor[I].Tamanho + 1;
      SetLength(FListaProfessor[I].Cursos, FListaProfessor[I].Tamanho);
      FListaProfessor[I].Cursos[FListaProfessor[I].Tamanho - 1] :=
        FQuery2.fieldByName('id_curso').AsString;
      FQuery2.Next;
    end;

    for count := 0 to FListaProfessor[I].Tamanho - 1 do
    begin
      SQL := 'SELECT nome FROM curso WHERE id_curso = ' +
        QuotedSTR(FListaProfessor[I].Cursos[count]);

      FQuery2 := RetornarDataSet2(SQL);

      FListaProfessor[I].Cursos[count] := FQuery2.fieldByName('nome').AsString;
    end;

    Ds.Next;
    I := I + 1;
  end;

end;

destructor TProfessorDAO.Destroy;
begin
  inherited;
  if Assigned(FListaProfessor) then
  FreeAndNil(FListaProfessor);
end;


function TProfessorDAO.PesquisaProfessor(pProfessor: TProfessor)
  : TObjectList<TProfessor>;
var
  SQL: string;
begin
  Result := nil;
  SQL := 'SELECT * FROM professor WHERE nome LIKE ' + QuotedStr('%' + pProfessor.Nome + '%') +
  'and cnpj LIKE '+ QuotedStr('%' + pProfessor.CNPJ + '%') + ' and telefone LIKE '+ QuotedStr('%' + pProfessor.Contato + '%') +
  'and id_professor in (select id_professor from professor_curso where id_curso in (select id_curso from curso where nome like '
  + QuotedStr('%' + pProfessor.Curso + '%') + ')) order by nome';


  FQuery := RetornarDataSet(SQL);

  if not (FQuery.IsEmpty) then
  begin
    CriaLista(FQuery);
    Result:= FListaProfessor;
  end;
end;

end.
