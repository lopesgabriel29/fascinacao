program Fascinação;

uses
  Vcl.Forms,
  uFrmLogin in 'uFrmLogin.pas' {FrmLogin},
  uDM in 'uDM.pas' {DM: TDataModule},
  uDAO in 'DAO\uDAO.pas',
  uAdm in 'Model\uAdm.pas',
  uAdmDAO in 'DAO\uAdmDAO.pas',
  uFrmCadAluno in 'uFrmCadAluno.pas' {FrmPrincipal},
  uAluno in 'Model\uAluno.pas',
  uResponsavel in 'Model\uResponsavel.pas',
  uAlunoDAO in 'DAO\uAlunoDAO.pas',
  uEndereco in 'Model\uEndereco.pas',
  uFrmListagem in 'uFrmListagem.pas' {FrmListar},
  uFrmCadProfessor in 'uFrmCadProfessor.pas' {Form1},
  uProfessorDAO in 'DAO\uProfessorDAO.pas',
  uProfessor in 'Model\uProfessor.pas',
  uCurso in 'Model\uCurso.pas',
  uSala in 'Model\uSala.pas',
  uFrmCadCurso in 'uFrmCadCurso.pas' {FrmNovoCurso},
  uSalaDAO in 'DAO\uSalaDAO.pas',
  uCursoDAO in 'DAO\uCursoDAO.pas',
  uEnderecoDAO in 'DAO\uEnderecoDAO.pas',
  uFrmEditProfessor in 'Editable\uFrmEditProfessor.pas' {FrmEditProfessor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmListar, FrmListar);
  Application.CreateForm(TFrmCadProfessor, FrmCadProfessor);
  Application.CreateForm(TFrmNovoCurso, FrmNovoCurso);
  Application.CreateForm(TFrmEditProfessor, FrmEditProfessor);
  Application.Run;
end.
