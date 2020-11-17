unit uFrmListagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, uFrmCadAluno, uFrmCadCurso,
  Vcl.Mask, uFrmCadProfessor, uProfessor, uProfessorDAO,
  System.Generics.Collections, uAluno, uAlunoDAO, uCurso, uCursoDAO,
  FireDac.Comp.Client, uFrmEditProfessor;

type
  TFrmListar = class(TForm)
    PageControl1: TPageControl;
    TabAlunos: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    BtnCadastroAluno: TButton;
    BrnView: TButton;
    BtnDelete: TButton;
    LVAluno: TListView;
    EdtNomeAluno: TEdit;
    EdtEmailAluno: TEdit;
    EdtTelefoneAluno: TEdit;
    BtnSearch: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EdtCPFAluno: TMaskEdit;
    TabProfessores: TTabSheet;
    LVProfessor: TListView;
    Panel3: TPanel;
    BtnCadastroProfessor: TButton;
    BtnViewProfessor: TButton;
    Button3: TButton;
    Panel4: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EdtNomeProfessor: TEdit;
    EdtContatoProfessor: TEdit;
    BtnPesquisaProfessor: TButton;
    EdtCnpj: TMaskEdit;
    TabCursos: TTabSheet;
    LVCurso: TListView;
    Panel5: TPanel;
    BtnNovoCurso: TButton;
    Button5: TButton;
    Button6: TButton;
    Panel6: TPanel;
    Label10: TLabel;
    EdtNomeCurso: TEdit;
    PesquisaCurso: TButton;
    EdtCursoProfessor: TComboBox;
    EdtCursoAluno: TComboBox;
    BtnClearAluno: TButton;
    BtnClearProfessor: TButton;
    procedure BtnCadastroAlunoClick(Sender: TObject);
    procedure BtnCadastroProfessorClick(Sender: TObject);
    procedure BtnNovoCursoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnPesquisaProfessorClick(Sender: TObject);
    procedure PesquisaCursoClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BtnClearAlunoClick(Sender: TObject);
    procedure BtnClearProfessorClick(Sender: TObject);
    procedure BtnViewProfessorClick(Sender: TObject);
  private
    procedure PreencherProfessor(pListaProfessor: TList<TProfessor>);
    procedure PreencherAluno(pListaAluno: TList<TAluno>);
    procedure PreencherCurso(pListaCurso: TList<TCurso>);
    function ListarCursosProfessor(pProfessor: TProfessor): String;
    function ListarCursosAluno(pAluno: TAluno): String;
    function ListarSalasCurso(pCurso: TCurso): String;
    procedure CriaCB(Ds: TFDQuery; CB : tCombobox);
    procedure PesquisarProfessor;
    procedure PesquisarAluno;
    procedure PesquisarCurso;
  public
    { Public declarations }
  end;

var
  FrmListar: TFrmListar;
  Professor: TProfessor;
  ProfessorDAO: TProfessorDAO;
  Aluno: TAluno;
  AlunoDAO: TAlunoDAO;
  Curso: TCurso;
  CursoDAO: TCursoDAO;

implementation

{$R *.dfm}

procedure TFrmListar.BtnCadastroAlunoClick(Sender: TObject);
begin
  Hide;
  FrmPrincipal.ShowModal;
  PesquisarAluno;
  show;
end;

procedure TFrmListar.BtnCadastroProfessorClick(Sender: TObject);
begin
  Hide;
  FrmCadProfessor.ShowModal;
  PesquisarProfessor;
  show;

end;

procedure TFrmListar.BtnNovoCursoClick(Sender: TObject);
begin
  Hide;
  FrmNovoCurso.ShowModal;
  PesquisarCurso;
  show;
end;

procedure TFrmListar.BtnPesquisaProfessorClick(Sender: TObject);
begin
  PesquisarProfessor;
end;

procedure TFrmListar.BtnSearchClick(Sender: TObject);
begin
  PesquisarAluno;
end;

procedure TFrmListar.BtnViewProfessorClick(Sender: TObject);
begin
  FrmEditProfessor.PreencherEditProfessor(LVProfessor.ItemFocused.data);
  FrmEditProfessor.ShowModal;

  PesquisarProfessor;
end;

procedure TFrmListar.BtnClearProfessorClick(Sender: TObject);
begin
  EdtNomeProfessor.Clear;
  EdtContatoProfessor.Clear;
  EdtCnpj.Clear;
  EdtCursoProfessor.ItemIndex := -1;

  PesquisarProfessor;
end;

procedure TFrmListar.BtnClearAlunoClick(Sender: TObject);
begin
  EdtNomeAluno.Clear;
  EdtEmailAluno.Clear;
  EdtTelefoneAluno.Clear;
  EdtCPFAluno.Clear;

  PesquisarAluno;
end;

Procedure TFrmListar.CriaCB(Ds: TFDQuery;CB : tCombobox);
begin
  CB.Clear;
  while not (Ds.Eof) do
  begin
    CB.Items.Add(Ds.FieldByName('nome').AsString);

    Ds.Next;
  end;
end;

procedure TFrmListar.PesquisaCursoClick(Sender: TObject);
begin
  PesquisarCurso;
end;

procedure TFrmListar.PesquisarAluno;
begin
  Aluno.Nome := EdtNomeAluno.Text;
  Aluno.Email := EdtEmailAluno.Text;
  Aluno.Curso := EdtCursoAluno.Text;
  if EdtCPFAluno.Text <> '   .   .   -  ' then
  begin
  Aluno.Cpf := EdtCPFAluno.Text;
  end else
  Aluno.Cpf := '';
  Aluno.Contato := EdtTelefoneAluno.Text;

  PreencherAluno(AlunoDAO.PesquisarAluno(Aluno));
end;

procedure TFrmListar.PesquisarCurso;
begin
Curso.Nome := EdtNomeCurso.Text;
  PreencherCurso(CursoDAO.PesquisaCurso(Curso));
end;

procedure TFrmListar.PesquisarProfessor;
begin
   Professor.Nome := EdtNomeProfessor.Text;
  if EdtCnpj.Text <> '  .   .   /    -  ' then
  begin
    Professor.CNPJ := EdtCnpj.Text;
  end
  else
    Professor.CNPJ := '';
  Professor.Contato := EdtContatoProfessor.Text;
  Professor.Curso := EdtCursoProfessor.Text;

  PreencherProfessor(ProfessorDAO.PesquisaProfessor(Professor));
end;

procedure TFrmListar.PreencherAluno(pListaAluno: TList<TAluno>);
var
  I: integer;
  tempItem: TListItem;
begin
  try

    if Assigned(pListaAluno) then
    begin
      LVAluno.Clear;

      for I := 0 to pListaAluno.Count - 1 do
      begin
        tempItem := LVAluno.Items.Add;
        tempItem.Caption := TAluno(pListaAluno[I]).Nome;
        tempItem.SubItems.Add(TAluno(pListaAluno[I]).Cpf);
        // tempItem.SubItems.Add(ListarCursosAluno(TAluno(plistaAluno[I])));
        tempItem.SubItems.Add(TAluno(pListaAluno[I]).Contato);
        tempItem.SubItems.Add(TAluno(pListaAluno[I]).Email);
        tempItem.Data := TAluno(pListaAluno[I]);
      end;
    end
    else
      ShowMessage('Nenhum professor encontrado');

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmListar.PreencherCurso(pListaCurso: TList<TCurso>);
var
  I: integer;
  tempItem: TListItem;
begin
  try

    if Assigned(pListaCurso) then
    begin
      LVCurso.Clear;

      for I := 0 to pListaCurso.Count - 1 do
      begin
        tempItem := LVCurso.Items.Add;
        tempItem.Caption := TCurso(pListaCurso[I]).Nome;
        tempItem.SubItems.Add(CurrToStr(TCurso(pListaCurso[I]).Preco));
        tempItem.SubItems.Add(ListarSalasCurso(TCurso(pListaCurso[I])));
        tempItem.Data := TCurso(pListaCurso[I]);
      end;
    end
    else
      ShowMessage('Nenhum curso encontrado');

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmListar.PreencherProfessor(pListaProfessor: TList<TProfessor>);
var
  I: integer;
  tempItem: TListItem;
begin
  try

    if Assigned(pListaProfessor) then
    begin
      LVProfessor.Clear;

      for I := 0 to pListaProfessor.Count - 1 do
      begin
        tempItem := LVProfessor.Items.Add;
        tempItem.Caption := TProfessor(pListaProfessor[I]).Nome;
        tempItem.SubItems.Add(TProfessor(pListaProfessor[I]).CNPJ);
        tempItem.SubItems.Add
          (ListarCursosProfessor(TProfessor(pListaProfessor[I])));
        tempItem.SubItems.Add(TProfessor(pListaProfessor[I]).Contato);
        tempItem.Data := TProfessor(pListaProfessor[I]);
      end;
    end
    else
      ShowMessage('Nenhum professor encontrado');

  except
    on e: exception do
      raise exception.Create(e.Message);
  end;
end;

procedure TFrmListar.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  PageControl1.TabIndex := 0;

  Professor := TProfessor.Create;
  ProfessorDAO := TProfessorDAO.Create;
  Aluno := TAluno.Create;
  AlunoDAO := TAlunoDAO.Create;
  Curso := TCurso.Create;
  CursoDAO := TCursoDAO.Create;

  PreencherProfessor(ProfessorDAO.PesquisaProfessor(Professor));
  PreencherAluno(AlunoDAO.PesquisarAluno(Aluno));
  PreencherCurso(CursoDAO.PesquisaCurso(Curso));

  CriaCB(CursoDAO.ListaCurso, EdtCursoProfessor);
  CriaCB(CursoDAO.ListaCurso, EdtCursoAluno);
end;

procedure TFrmListar.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(Professor) then
      FreeAndNil(Professor);

    if Assigned(ProfessorDAO) then
      FreeAndNil(ProfessorDAO);

    if Assigned(Aluno) then
      FreeAndNil(Aluno);

    if Assigned(AlunoDAO) then
      FreeAndNil(AlunoDAO);

    if Assigned(Curso) then
      FreeAndNil(Curso);

    if Assigned(CursoDAO) then
      FreeAndNil(CursoDAO);

  except
    on e: exception do
      raise exception.Create(e.Message);

  end;
end;

function TFrmListar.ListarCursosAluno(pAluno: TAluno): String;
var
  C: string;
  I: integer;
begin
  for I := 0 to pAluno.Tamanho - 2 do
  begin
    C := C + pAluno.Cursos[I] + ', ';
  end;
  C := C + pAluno.Cursos[pAluno.Tamanho - 1];
  Result := C;

end;

function TFrmListar.ListarCursosProfessor(pProfessor: TProfessor): String;
var
  C: string;
  I: integer;
begin
  for I := 0 to pProfessor.Tamanho - 2 do
  begin
    C := C + pProfessor.Cursos[I] + ', ';
  end;
  C := C + pProfessor.Cursos[pProfessor.Tamanho - 1];
  Result := C;
end;

function TFrmListar.ListarSalasCurso(pCurso: TCurso): String;
var
  C: string;
  I: integer;
begin
  for I := 0 to 4 do
  begin
    C := C + pCurso.salas[I];
    if pCurso.salas[I + 1] <> '' then
      C := C + ', '
  end;
  Result := C;
end;

end.
