unit uFrmCadProfessor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls, System.DateUtils, uProfessorDAO,
  uFrmCadCurso, uEnderecoDAO, uEndereco, uProfessor, FireDac.Comp.Client,
  uCursoDAO;

type
  TFrmCadProfessor = class(TForm)
    pCadProfessor: TPanel;
    pInfo: TPanel;
    Label2: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    EdtContato: TEdit;
    EdtCpf: TMaskEdit;
    EdtRg: TMaskEdit;
    EdtNome: TEdit;
    DTDataNasc: TDateTimePicker;
    EdtEmail: TEdit;
    pEndereçoAluno: TPanel;
    Label3: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    EdtRua: TEdit;
    EdtNumero: TEdit;
    EdtCidade: TEdit;
    EdtBairro: TEdit;
    MECep: TMaskEdit;
    EdtCnpj: TMaskEdit;
    pCursos: TPanel;
    CLCursos: TCheckListBox;
    Label1: TLabel;
    BtnNewCourse: TButton;
    BtnCadastrar: TSpeedButton;
    BtnCancel: TSpeedButton;
    ScrollBar1: TScrollBar;
    pHorario: TPanel;
    ComboBox1: TComboBox;
    DTInicio: TDateTimePicker;
    DRFim: TDateTimePicker;
    ListView1: TListView;
    BtnCadHorario: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnNewCourseClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure BtnCadastrarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure LimparEdits;
    Procedure Crialista(pQuery: TFDQuery);
    procedure CreateProfessor;
    procedure CreateEndereco;
  public
    { Public declarations }
  end;

var
  FrmCadProfessor: TFrmCadProfessor;
  ProfessorDAO: TProfessorDAO;
  EnderecoDAO: TEnderecoDAO;
  CursoDAO: TCursoDAO;
  Endereco: Tendereco;
  Professor: Tprofessor;

implementation

{$R *.dfm}

procedure TFrmCadProfessor.BtnCadastrarClick(Sender: TObject);
begin
  CreateEndereco;
  CreateProfessor;

  if not EnderecoDAO.CadastrarEndereco(Endereco) = true then
  begin
    ShowMessage('Erro ao cadastro de endereço');
    abort
  end;

  if ProfessorDAO.CadastrarProfessor(Professor, Endereco) = true then
  begin
    ShowMessage(Professor.Nome + ' cadastrado(a) com sucesso');
    LimparEdits;
    FrmCadProfessor.close;
  end
  else
  begin
    ShowMessage('Falha no cadasto de Professor' + #13 + #13 +
      'Certifique-se de preencher todos os campos');
  end;

  if ProfessorDAO.CadastrarProfessor_Curso(Professor) = false then
  begin
    ShowMessage('Erro ao associar Cursos');
  end;

end;

procedure TFrmCadProfessor.BtnCancelClick(Sender: TObject);
begin
  FrmCadProfessor.close;
end;

procedure TFrmCadProfessor.BtnNewCourseClick(Sender: TObject);
begin
  FrmNovoCurso.showmodal;
  Crialista(CursoDAO.ListaCurso);
end;

procedure TFrmCadProfessor.CreateEndereco;
begin
  try
    if (EdtRua.Text = '') or (EdtBairro.Text = '') or (MECep.Text = '_____-___')
    then
    begin
      ShowMessage('Erro ao cadastrar endereco' + #13 + #13 +
        'Certifique-se de preencher todos os dados');
      abort
    end;

    Endereco := Tendereco.Create;

    Endereco.Rua := EdtRua.Text;
    Endereco.Numero := StrToInt(EdtNumero.Text);
    Endereco.Cidade := EdtCidade.Text;
    Endereco.Bairro := EdtBairro.Text;
    Endereco.Cep := MECep.Text;
  except
    ShowMessage('erro ao cadastrar endereco' + #13 + #13 +
      'Certifique-se de preencher todos os dados');
    abort
  end;
end;

procedure TFrmCadProfessor.CreateProfessor;
var
  I: integer;
begin
  try
    if (EdtCnpj.Text = '__.___.___/____-__') or (EdtNome.Text = '') or
      (EdtCpf.Text = '___.___.___-__') or (EdtRg.Text = '') then
    begin
      MessageDlg('Erro ao cadastrar professor', mtError, [mbOK], 0);
      abort
    end;

    Professor := Tprofessor.Create;

    Professor.Nome := EdtNome.Text;
    Professor.DataNasc := DTDataNasc.Date;
    Professor.Cpf := EdtCpf.Text;
    Professor.RG := EdtRg.Text;
    Professor.CNPJ := EdtCnpj.Text;
    Professor.Contato := EdtContato.Text;
    Professor.Email := EdtEmail.Text;

    for I := 0 to CLCursos.Items.Count - 1 do
    begin
      if CLCursos.State[I] = cbChecked then
      begin

        Professor.Tamanho := Professor.Tamanho + 1;
        SetLength(Professor.Cursos, Professor.Tamanho);
        Professor.Cursos[Professor.Tamanho - 1] := CLCursos.Items[I]
      end;

    end;

  except
    MessageDlg('Erro ao cadastrar professor', mtError, [mbOK], 0);
    abort
  end;
end;

procedure TFrmCadProfessor.Crialista(pQuery: TFDQuery);
begin
  CLCursos.Clear;
  while not pQuery.Eof do
  begin
    CLCursos.Items.Add(pQuery.FieldByName('nome').AsString);

    pQuery.Next;
  end;
end;

procedure TFrmCadProfessor.FormCreate(Sender: TObject);
begin

  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;

  pCadProfessor.Height := 0;
  pCadProfessor.Height := pInfo.Height + pHorario.Height + pEndereçoAluno.Height
    + pCursos.Height;
  ScrollBar1.Max := pCadProfessor.Height - FrmCadProfessor.Height;

  ProfessorDAO := TProfessorDAO.Create;
  EnderecoDAO := TEnderecoDAO.Create;
  CursoDAO := TCursoDAO.Create;

  Crialista(CursoDAO.ListaCurso);

end;

procedure TFrmCadProfessor.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(ProfessorDAO) then
      FreeAndNil(ProfessorDAO);

    if Assigned(EnderecoDAO) then
      FreeAndNil(EnderecoDAO);

    if Assigned(Endereco) then
      FreeAndNil(Endereco);

    if Assigned(Professor) then
      FreeAndNil(Professor);

    if Assigned(CursoDAO) then
      FreeAndNil(CursoDAO);
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

procedure TFrmCadProfessor.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBar1.Position := ScrollBar1.Position + 80;
end;

procedure TFrmCadProfessor.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBar1.Position := ScrollBar1.Position - 80;
end;

procedure TFrmCadProfessor.LimparEdits;
begin
  EdtContato.Clear;
  EdtCpf.Clear;
  EdtRg.Clear;
  EdtNome.Clear;
  EdtEmail.Clear;
  EdtRua.Clear;
  EdtNumero.Clear;
  EdtCidade.Clear;
  EdtBairro.Clear;
  EdtCnpj.Clear;
end;

procedure TFrmCadProfessor.ScrollBar1Change(Sender: TObject);
begin
  pCadProfessor.top := -ScrollBar1.Position;
end;

end.
