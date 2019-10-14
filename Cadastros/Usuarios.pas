unit Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Mask, Data.DB, Vcl.DBGrids, Vcl.Buttons;

type
  TFrmUsuarios = class(TForm)
    PageControl1: TPageControl;
    TbConsulta: TTabSheet;
    Label1: TLabel;
    BtnNovo: TSpeedButton;
    btnAlterar: TSpeedButton;
    BtnDeletar: TSpeedButton;
    edtPesquisa: TEdit;
    grid: TDBGrid;
    tbCadastro: TTabSheet;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    BtnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    Label8: TLabel;
    edtLogin: TEdit;
    edtSenha: TMaskEdit;
    cmbFuncionario: TComboBox;
    edtID: TEdit;
    cmbIDfuncionario: TComboBox;
    Label7: TLabel;
    Label10: TLabel;
    cmbGrupousuarios: TComboBox;
    cmbIDGrupousuarios: TComboBox;
    DS: TDataSource;
    PROCEDUre salvar;
    procedure alterar;
    procedure pesquisar;
    procedure delete(id: String);
    procedure listarfuncionariosegrupo;
    procedure limparcampos;
    procedure liberarcampos;
    procedure bloquearcampos;
    procedure FormShow(Sender: TObject);
    procedure cmbFuncionarioChange(Sender: TObject);
    procedure cmbGrupousuariosChange(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtPesquisaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure gridDblClick(Sender: TObject);
    procedure TbConsultaShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUsuarios: TFrmUsuarios;
  CRUD: String;

implementation

{$R *.dfm}

uses dmodule;

{ TFrmUsuarios }

procedure TFrmUsuarios.alterar;
begin
DMod.QRcon.SQL.Clear;
  DMod.QRcon.SQL.Add('update usuarios set ');
  DMod.QRcon.SQL.Add('LOGIN = :login,');
  DMod.QRcon.SQL.Add('Senha = :senha,');
  DMod.QRcon.SQL.Add('funcionario_ID = :funcionario_id,');
  DMod.QRcon.SQL.Add('grupo_usuario_id = :grupo_usuario_id');
  DMod.QRcon.SQL.Add('WHERE ID = :ID');

  DMod.QRcon.ParamByName('login').Value := edtLogin.Text;
  DMod.QRcon.ParamByName('ID').Value := edtID.Text;
  DMod.QRcon.ParamByName('senha').Value := edtSenha.Text;
  DMod.QRcon.ParamByName('funcionario_ID').Value := cmbIDfuncionario.Text;
  DMod.QRcon.ParamByName('grupo_usuario_ID').Value := cmbIDGrupousuarios.Text;
  DMod.QRcon.ExecSQL;
  MessageDlg('Cargos Alterado com Sucesso!', mtInformation, [mbOK], 0);
  CRUD := 'R';
end;

procedure TFrmUsuarios.bloquearcampos;
begin
   // bloqueia os edits do formul�rio

  edtLogin.Enabled := false;
  edtSenha.Enabled := false;
  edtID.Enabled := false;

  cmbFuncionario.Enabled := false;
  cmbGrupousuarios.Enabled := false;
end;

procedure TFrmUsuarios.btnAlterarClick(Sender: TObject);
begin
 // CHECA Se o crud j� est� em altera��o, caso sim, n�o permite alterar
  if CRUD <> 'R' then
  BEGIN
    MessageDlg('Existe um cadastro em aberto', mtWarning, [mbOK], 0);
    PageControl1.ActivePageIndex := 1;
    edtLogin.SetFocus;
    Exit;
  END
  else
  begin
    // se n�o estiver em altera��o, prepara o formul�rio para altera��o
    edtID.Text := grid.Columns.Items[0].Field.Text;
    DMod.QRcon.SQL.Clear;
    DMod.QRcon.SQL.Add('SELECT * FROM usuarios WHERE ID = :ID');
    DMod.QRcon.ParamByName('ID').Value := edtID.Text;
    DMod.QRcon.Open();
    edtLogin.Text := DMod.QRcon.FieldByName('LOGIN').Value;
    edtSenha.Text := DMod.QRcon.FieldByName('SENHA').Value;
    cmbIDfuncionario.ItemIndex := cmbIDfuncionario.Items.IndexOf
      (DMod.QRcon.FieldByName('FUNCIONARIO_ID').Value);
    cmbFuncionario.ItemIndex := cmbIDfuncionario.ItemIndex;
    cmbIDGrupousuarios.ItemIndex := cmbIDGrupousuarios.Items.IndexOf
      (DMod.QRcon.FieldByName('GRUPO_USUARIO_ID').Value);
    cmbGrupousuarios.ItemIndex := cmbIDGrupousuarios.ItemIndex;
    DMod.QRcon.Close;

    liberarcampos;
    PageControl1.ActivePageIndex := 1;
    edtLogin.SetFocus;
    CRUD := 'U';
  end;
end;

procedure TFrmUsuarios.btnCancelarClick(Sender: TObject);
begin
 PageControl1.ActivePageIndex := 0;
  edtPesquisa.SetFocus;
  bloquearcampos;
  CRUD := 'R';
end;

procedure TFrmUsuarios.BtnDeletarClick(Sender: TObject);
begin
CRUD := 'D';
  delete(grid.Columns.Items[0].Field.Text);
  pesquisar;
end;

procedure TFrmUsuarios.BtnNovoClick(Sender: TObject);
begin
if CRUD <> 'R' then
  BEGIN
    MessageDlg('Existe um cadastro em aberto', mtWarning, [mbOK], 0);
    PageControl1.ActivePageIndex := 1;
    edtLogin.SetFocus;
    Exit;
  END
  else
  begin

    limparcampos;
    liberarcampos;
    PageControl1.ActivePageIndex := 1;
    cmbIDfuncionario.ItemIndex := cmbFuncionario.ItemIndex;
    cmbIDGrupousuarios.ItemIndex := cmbGrupousuarios.ItemIndex;
    edtLogin.SetFocus;
    CRUD := 'C';
  end;
end;

procedure TFrmUsuarios.BtnSalvarClick(Sender: TObject);
begin
 if Trim(edtLogin.Text) = '' then
  begin
    MessageDlg('Campo Cargo v�zio!!', mtWarning, [mbOK], 0);
    edtLogin.SetFocus;
    Exit;
  end;
  salvar;
  bloquearcampos;
end;

procedure TFrmUsuarios.cmbFuncionarioChange(Sender: TObject);
begin
// Momento McGyver, aqui eu clono o item selecionado no combobox de cargo para o de ID, para conseguir manipular o banco de dados.
  cmbIDfuncionario.ItemIndex := cmbFuncionario.ItemIndex;
end;

procedure TFrmUsuarios.cmbGrupousuariosChange(Sender: TObject);
begin
// Momento McGyver, aqui eu clono o item selecionado no combobox  para o de ID, para conseguir manipular o banco de dados.
  cmbIDGrupousuarios.ItemIndex := cmbGrupousuarios.ItemIndex;
end;

procedure TFrmUsuarios.delete(id: String);
begin
    // fun��o que checa se o edit funcion�rio foi preenchido

  if Trim(id) = '' then
  begin
    MessageDlg('Nenhum Registro Selecionado', mtInformation, [mbOK], 0);
    Exit;
  end;

  // fun��o para deletar o funcion�rio.
  if MessageDlg('Deseja mesmo excluir esse Registro', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then

  begin
    DMod.QRcon.SQL.Clear;
    DMod.QRcon.SQL.Add('delete from grupo_usuarios where id = :id');
    DMod.QRcon.ParamByName('ID').Value := id;
    DMod.QRcon.ExecSQL;
    MessageDlg('Registro deletado com sucesso', mtInformation, [mbOK], 0);
    CRUD := 'R';
  end;

end;

procedure TFrmUsuarios.edtPesquisaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 pesquisar;
end;

procedure TFrmUsuarios.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_ESCAPE then
      Self.close;
end;

procedure TFrmUsuarios.FormShow(Sender: TObject);
begin
   // quando abre o formul�rio, o pagecontrol � colocado na primeira p�gina e o crud � coloca no modo de visualiza��o.

  PageControl1.ActivePageIndex := 0;
  listarfuncionariosegrupo;
  pesquisar;
  bloquearcampos;
  CRUD := 'R';
  grid.EditorMode := false;
  edtPesquisa.SetFocus;
end;

procedure TFrmUsuarios.gridDblClick(Sender: TObject);
begin
btnAlterar.Click;
end;

procedure TFrmUsuarios.liberarcampos;
begin
   // habilita os edits do formul�rio
  edtLogin.Enabled := true;
  edtSenha.Enabled := true;

  cmbFuncionario.Enabled := true;
  cmbGrupousuarios.Enabled := true;
end;

procedure TFrmUsuarios.limparcampos;
begin
     // limpa os edits do formul�rio
  edtLogin.Text := '';
  edtSenha.Text := '';
  edtID.Text := '';

  cmbFuncionario.ItemIndex := 0;
  cmbGrupousuarios.ItemIndex := 0;
end;



procedure TFrmUsuarios.listarfuncionariosegrupo;
begin
 // fun��o para inserir os funcionarios e grupos de usuarios no combobox, criei um cmbbox auxiliar que fica invisivel, s� para registrar o ID

  DMod.QRcon.SQL.Clear;
  DMod.QRcon.SQL.Add('select id, nome from funcionarios order by id');
  DMod.QRcon.Open();

  while not DMod.QRcon.Eof do
  begin
    cmbFuncionario.Items.Add(DMod.QRcon.FieldByName('NOME').Value);
    cmbIDfuncionario.Items.Add(DMod.QRcon.FieldByName('id').Value);
    DMod.QRcon.Next;
  end;

  DMod.QRcon.SQL.Clear;
  DMod.QRcon.SQL.Add('select id, nome from grupo_usuarios order by id');
  DMod.QRcon.Open();

  while not DMod.QRcon.Eof do
  begin
    cmbGrupousuarios.Items.Add(DMod.QRcon.FieldByName('NOME').Value);
    cmbIDGrupousuarios.Items.Add(DMod.QRcon.FieldByName('id').Value);
    DMod.QRcon.Next;
  end;
end;

procedure TFrmUsuarios.pesquisar;
begin
     // pesquisa o funcion�rio, baseado pelo campo pesquisa
  DMod.QRcon.SQL.Clear;
  DMod.QRcon.SQL.Add
    ('select F.id, F.login, c.nome as Funcionario, ci.nome AS grupo_usuario from usuarios F ');
  DMod.QRcon.SQL.Add('LEFT JOIN funcionarios C ON(F.funcionario_id = C.id)');
  DMod.QRcon.SQL.Add('LEFT JOIN grupo_usuarios ci ON(F.grupo_usuario_id = Ci.id)');
  DMod.QRcon.SQL.Add(' where F.login containing :pesquisa order by id');
  DMod.QRcon.ParamByName('pesquisa').Value := edtPesquisa.Text;
  DMod.QRcon.Open;
  grid.Columns[0].FieldName := 'ID';
  grid.Columns[1].FieldName := 'LOGIN';
  grid.Columns[2].FieldName := 'funcionario';
  grid.Columns[3].FieldName := 'grupo_usuario';
end;

procedure TFrmUsuarios.salvar;
begin
    if CRUD = 'C' then

  begin
    // Inser��o do registro na tabela
    DMod.QRcon.SQL.Clear;
    DMod.QRcon.SQL.Add
      ('INSERT INTO USUARIOS (LOGIN, SENHA, FUNCIONARIO_ID, GRUPO_USUARIO_ID) VALUES ( :LOGIN, :SENHA, :FUNCIONARIO_ID, :GRUPO_USUARIO_ID);');
    DMod.QRcon.ParamByName('LOGIN').Value := edtLogin.Text;
    DMod.QRcon.ParamByName('SENHA').Value := edtSenha.Text;
    DMod.QRcon.ParamByName('FUNCIONARIO_ID').Value := cmbIDfuncionario.Text;
    DMod.QRcon.ParamByName('GRUPO_USUARIO_ID').Value := cmbIDGrupousuarios.Text;

    DMod.QRcon.ExecSQL;

    // Consulta o ID gerado na tabela e repassa para o edt de ID
    DMod.QRcon.SQL.Clear;
    DMod.QRcon.SQL.Add
      ('select id from usuarios where id = (select max(id) from usuarios)');
    DMod.QRcon.Open;
    edtID.Text := DMod.QRcon.FieldByName('ID').Value;

    DMod.QRcon.SQL.Clear;
    CRUD := 'R';
    MessageDlg('Salvo com sucesso', mtInformation, [mbOK], 0);
  end
  else if CRUD = 'U' then

  begin
    alterar;
  end;
end;

procedure TFrmUsuarios.TbConsultaShow(Sender: TObject);
begin
pesquisar;
  edtPesquisa.SetFocus;
end;

end.
