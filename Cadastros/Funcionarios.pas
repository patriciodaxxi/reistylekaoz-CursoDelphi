unit Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.Grids,
  Vcl.ComCtrls, Vcl.Buttons;

type
  TFrmFuncionarios = class(TForm)
    PageControl1: TPageControl;
    TbConsulta: TTabSheet;
    Label1: TLabel;
    edtPesquisa: TEdit;
    StringGrid1: TStringGrid;
    tbCadastro: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtNome: TEdit;
    edtEnd: TEdit;
    edtCpf: TMaskEdit;
    edtFone: TMaskEdit;
    cmbCargo: TComboBox;
    BtnNovo: TSpeedButton;
    BtnSalvar: TSpeedButton;
    BtnDeletar: TSpeedButton;
    SpeedButton1: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFuncionarios: TFrmFuncionarios;

implementation

{$R *.dfm}

end.
