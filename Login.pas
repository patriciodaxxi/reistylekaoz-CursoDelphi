unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmLogin = class(TForm)
    PanelLogin: TPanel;
    ImgLoginFundo: TImage;
    PanelImglogin: TPanel;
    ImgLogin: TImage;
    EdtSenha: TEdit;
    EdtLogin: TEdit;
    BtnLogin: TSpeedButton;
    LblAvisoLogin: TLabel;
    procedure pesquisarLogin;
    procedure pesquisarsenha;

    procedure centralizarpainel;
    procedure login;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure BtnLoginClick(Sender: TObject);
    procedure EdtLoginExit(Sender: TObject);
    procedure EdtSenhaEnter(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses Menu, dmodule;

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
begin
    if Trim(EdtLogin.Text) = '' then
        begin
          LblAvisoLogin.Caption := 'Digite o usu�rio!';
          EdtLogin.SetFocus;
          exit;
        end
        else
        begin

        end;

    if Trim(EdtSenha.Text) = '' then
    begin
        LblAvisoLogin.Caption := 'Digite a Senha!';
          EdtSenha.SetFocus;
          exit;
    end
    else
    begin
      pesquisarsenha;
    end;


end;

procedure TFrmLogin.centralizarpainel;
begin
   PanelImglogin.top := (self.Height div 2) - 180;
    PanelImglogin.left := (Self.Width div 2) - 182;
end;

procedure TFrmLogin.EdtLoginExit(Sender: TObject);
begin
pesquisarLogin;
end;

procedure TFrmLogin.EdtSenhaEnter(Sender: TObject);
begin
LblAvisoLogin.Caption := '';
end;

procedure TFrmLogin.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
    centralizarpainel;
end;

 procedure TFrmLogin.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_RETURN then
   begin
     BtnLogin.Click;
   end;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
EdtLogin.SetFocus;
end;

procedure TFrmLogin.login;
begin
    USUARIOID := DMod.QRcon.FieldByName('id').AsInteger;
USUARIO := DMod.QRcon.FieldByName('login').Value;
grupoid := DMod.QRcon.FieldByName('grupo_usuario_id').AsInteger;
superusuario := DMod.QRcon.FieldByName('super_usuario').Value;
    FrmMenu := TFrmMenu.Create(self);
    FrmMenu.ShowModal;
    LblAvisoLogin.Caption := 'Login Efetuado';
end;

procedure TFrmLogin.pesquisarLogin;
begin
//
DMod.QRcon.SQL.Clear;
DMod.QRcon.SQL.Add('select * from usuarios where login = :login');
DMod.QRcon.ParamByName('login').Value := EdtLogin.Text;
DMod.QRcon.Open();
if DMod.QRcon.RecordCount = 0 then
begin
  LblAvisoLogin.Caption := 'Usu�rio n�o encontrado!!!';
  EdtLogin.SetFocus;
end;

end;

procedure TFrmLogin.pesquisarsenha;
begin
   //

DMod.QRcon.SQL.Clear;
DMod.QRcon.SQL.Add('select u.id, u.senha, u.login, u.grupo_usuario_id, g.super_usuario from usuarios u left join grupo_usuarios g on(u.grupo_usuario_id = g.id) where login = :login and senha = :senha');
DMod.QRcon.ParamByName('login').Value := EdtLogin.Text;
DMod.QRcon.ParamByName('senha').Value := EdtSenha.Text;
DMod.QRcon.Open();

if DMod.QRcon.RecordCount = 0 then
begin
  LblAvisoLogin.Caption := 'Usu�rio e senha incorretos!!!';
  EdtLogin.SetFocus;
end
else

login;
end;

end.
