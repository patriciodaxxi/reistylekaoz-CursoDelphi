unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TFrmLogin = class(TForm)
    PanelLogin: TPanel;
    ImgLoginFundo: TImage;
    PanelImglogin: TPanel;
    ImgLogin: TImage;
    BtnLogin: TButton;
    EdtSenha: TEdit;
    EdtLogin: TEdit;
    procedure centralizarpainel;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

procedure TFrmLogin.centralizarpainel;
begin
   PanelImglogin.top := (self.Height div 2) - 180;
    PanelImglogin.left := (Self.Width div 2) - 182;
end;

procedure TFrmLogin.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
    centralizarpainel;
end;

end.
