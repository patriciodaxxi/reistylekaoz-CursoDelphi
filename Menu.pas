unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmMenu = class(TForm)
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    Fornecedores1: TMenuItem;
    Movimentaes1: TMenuItem;
    Relatrios1: TMenuItem;
    Estoque1: TMenuItem;
    Sair1: TMenuItem;
    Usuarios1: TMenuItem;
    Funcionarios1: TMenuItem;
    Cargos1: TMenuItem;
    procedure Usuarios1Click(Sender: TObject);
    procedure Funcionarios1Click(Sender: TObject);
    procedure Cargos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses Usuarios, Funcionarios, Cargos;

procedure TFrmMenu.Cargos1Click(Sender: TObject);
begin
    FrmCargos := TFrmCargos.Create(self);
    FrmCargos.Show;
end;

procedure TFrmMenu.Funcionarios1Click(Sender: TObject);
begin
    FrmFuncionarios := TFrmFuncionarios.Create(self);
    FrmFuncionarios.Show;
end;

procedure TFrmMenu.Usuarios1Click(Sender: TObject);
begin
    FrmUsuarios := TFrmUsuarios.Create(self);
    FrmUsuarios.Show;
end;

end.
