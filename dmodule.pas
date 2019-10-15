unit dmodule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, inifiles,
  FireDAC.Phys.IBBase, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDMod = class(TDataModule)
    FDCon: TFDConnection;
    TBcon: TFDTable;
    QRcon: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMod: TDMod;
  ConfigINI : TIniFile;
  caminhoexe : string;
  USUARIO: STRING;
  USUARIOID: Integer;
  grupoid: Integer;
  superusuario: string;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMod.DataModuleCreate(Sender: TObject);
begin
    caminhoexe := extractfiledir(getcurrentdir);
     ConfigINI := TIniFile.Create(caminhoexe+'\Debug\Config.ini');
     FDCon.Params.Database :=  ConfigINI.ReadString('Configuracao','Banco','Erro ao conectar no banco de dados!!');
     ConfigINI.Free;
     FDCon.Connected := true;
end;

end.
