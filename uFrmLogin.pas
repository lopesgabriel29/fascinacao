unit uFrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.StdCtrls,
  uAdmDAO, uDM, FireDAC.Comp.Client, System.ImageList, Vcl.ImgList,
  uFrmCadAluno, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  uFrmListagem;

type
  TFrmLogin = class(TForm)
    EdtUser: TEdit;
    EdtPassw: TEdit;
    SBLogin: TSpeedButton;
    SBExit: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    BtnViewPassw: TImage;
    BtnUnviewPassw: TImage;
    procedure SBExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Login;
    procedure SBLoginClick(Sender: TObject);
    procedure ViewPassw;
    procedure BtnUnviewPasswClick(Sender: TObject);
    procedure BtnViewPasswClick(Sender: TObject);
    procedure EdtPasswKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;
  AdmDAO: TAdmDAO;
  fails: integer = 0;

implementation

{$R *.dfm}

procedure TFrmLogin.BtnUnviewPasswClick(Sender: TObject);
begin
  ViewPassw;
  BtnUnviewPassw.Hide;
  BtnViewPassw.Show
end;

procedure TFrmLogin.BtnViewPasswClick(Sender: TObject);
begin
ViewPassw;
BtnViewPassw.Hide;
BtnUnviewPassw.Show;
end;

procedure TFrmLogin.EdtPasswKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    login;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  left := (Screen.Width - Width) div 2;
  top := (Screen.Height - Height) div 2;
end;

procedure TFrmLogin.Login;
begin
  AdmDAO := TAdmDAO.Create;

  if AdmDAO.VerificaLogin(EdtUser.Text, EdtPassw.Text) = True then //tenta logar
  begin //sucesso
    hide;
    FrmListar.ShowModal;
    EdtUser.Clear;
    EdtPassw.Clear;
    show;
    EdtUser.SetFocus;
  end
  else if fails <= 3 then //aviso de primeiras 4 falhas
  begin
    ShowMessage('Usuário ou senha incorretos.' + #13 + #13 +
      'Tentativas restantes: ' + inttostr(4 - fails));
    EdtPassw.Clear;
    EdtPassw.SetFocus;
    fails := fails + 1;
  end
  else
  begin //aviso de 5° falha clear geral do login
    MessageDlg
      ('5 erros consecutivos.'+ #13 + #13 +
       'Verifique se senha e cadastro estão corretos.',
      mtWarning, [mbok], 0);
    EdtUser.Clear;
    EdtUser.SetFocus;
    EdtPassw.Clear;
  end;
end;

procedure TFrmLogin.SBExitClick(Sender: TObject);
begin
  FrmLogin.close;
end;

procedure TFrmLogin.SBLoginClick(Sender: TObject);
begin
   Login;
end;

procedure TFrmLogin.ViewPassw;
begin
if EdtPassw.PasswordChar = '●' then
  begin
    EdtPassw.PasswordChar := #0;
  end
  else
    EdtPassw.PasswordChar := '●';
end;

end.
