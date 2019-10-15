unit DefinicoesdeAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TfrmDefinicoes = class(TForm)
    MainMenu: TMainMenu;
    Cadastros: TMenuItem;
    CadProdutos: TMenuItem;
    CadFornecedores: TMenuItem;
    CadUsuarios: TMenuItem;
    CadFuncionarios: TMenuItem;
    CadCargos: TMenuItem;
    CadGrupoUsuarios: TMenuItem;
    Estoque: TMenuItem;
    Movimentacoes: TMenuItem;
    Relatorios: TMenuItem;
    Config: TMenuItem;
    ConfDefAcesso: TMenuItem;
    Sair1: TMenuItem;
    PanelGrp: TCategoryPanelGroup;
    OutrasEntradas1: TMenuItem;
    edtPesquisa: TEdit;
    btnSalvar: TSpeedButton;
    btnListar: TSpeedButton;

    procedure listarfuncoes;
    procedure btnListarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDefinicoes: TfrmDefinicoes;

implementation

{$R *.dfm}

uses dmodule;

procedure TfrmDefinicoes.btnListarClick(Sender: TObject);
begin
  listarfuncoes;
end;

procedure TfrmDefinicoes.listarfuncoes;

var
  i: integer;
  j: integer;

  toplb: integer;
  CheckInsere: TCheckBox;
  CheckAltera: TCheckBox;
  CheckExcluir: TCheckBox;
  LPanel: TCategoryPanel;
  LabelFunc: TLabel;

begin
  for i := 0 to Menu.Items.Count - 2 do
  begin

    Menu.Items[i].Enabled := false;
    LPanel := TCategoryPanel.Create(PanelGrp);
    LPanel.Caption := Menu.Items[i].Caption;
    LPanel.Name := 'Panel' + (Menu.Items[i].Name);
    LPanel.PanelGroup := PanelGrp;
    LPanel.Collapsed := True;
    toplb := 0;

    for j := 0 to Menu.Items[i].Count - 1 do

    begin
      Menu.Items[i].Items[j].Enabled := false;
      LabelFunc := TLabel.Create(self);
      LabelFunc.Parent := LPanel;
      LabelFunc.Caption := Menu.Items[i].Items[j].Caption;
      LabelFunc.Name := 'Label' + (Menu.Items[i].Items[j].Name);
      LabelFunc.Top := toplb;

      CheckInsere := TCheckBox.Create(self);
      CheckInsere.Caption := 'Inserir';
      CheckInsere.Name := 'chkInsere' + Menu.Items[i].Items[j].Name;
      CheckInsere.Parent := LPanel;
      CheckInsere.Top := toplb;
      CheckInsere.left := 136;

      CheckAltera := TCheckBox.Create(self);
      CheckAltera.Caption := 'Alterar';
      CheckAltera.Name := 'chkAlterar' + Menu.Items[i].Items[j].Name;
      CheckAltera.Parent := LPanel;
      CheckAltera.Top := toplb;
      CheckAltera.left := 232;

      CheckExcluir := TCheckBox.Create(self);
      CheckExcluir.Caption := 'Excluir';
      CheckExcluir.Name := 'chkExcluir' + Menu.Items[i].Items[j].Name;
      CheckExcluir.Parent := LPanel;
      CheckExcluir.Top := toplb;
      CheckExcluir.left := 328;

      toplb := toplb + 20;

      DMod.QRcon.SQL.Clear;
      DMod.QRcon.SQL.Add
        ('select g.id, g.grupo_usuarios_id, gu.nome as nomegrupo, g.funcoes_id, f.nome as nomefuncao, g.alterar, g.excluir, g.inserir, g.entrar from funcoes_grupo_usuarios g');
      DMod.QRcon.SQL.Add
        ('left join grupo_usuarios gu on(g.grupo_usuarios_id = gu.id)');
      DMod.QRcon.SQL.Add('left join funcoes f on(g.funcoes_id = f.id)');
      DMod.QRcon.SQL.Add('where g.grupo_usuarios_id = :id');
      DMod.QRcon.ParamByName('ID').Value := edtPesquisa.Text;
      DMod.QRcon.open;

      while not DMod.QRcon.Eof do
      begin
        if DMod.QRcon.FieldByName('entrar').Value = 'S' then
        begin

          TMenuItem(FindComponent(DMod.QRcon.FieldByName('nomefuncao').Value))
            .Enabled := True;
        end;
        if DMod.QRcon.FieldByName('inserir').Value = 'S' then
        begin



        end;

        DMod.QRcon.Next;

      end;

    end;
  end;
end;

end.
