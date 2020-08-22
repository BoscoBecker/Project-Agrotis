unit frmCadPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls;

type
  TFormCadPedido = class(TForm)
    lbl1: TLabel;
    shp2: TShape;
    img2: TImage;
    shp1: TShape;
    grp1: TGroupBox;
    dbgrd1: TDBGrid;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnAlterar: TButton;
    btnNovo: TButton;
    SearchBox1: TSearchBox;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl8: TLabel;
    lbl6: TLabel;
    lbl4: TLabel;
    lbl7: TLabel;
    lbl9: TLabel;
    img1: TImage;
    dsPedido: TDataSource;
    dbedtCodigo: TDBEdit;
    dbedtReferencia: TDBEdit;
    dbedtNumeroPedido: TDBEdit;
    dbedtDataEmissao: TDBEdit;
    dbedtCodigoCliente: TDBEdit;
    dbedtTotalPedido: TDBEdit;
    dbcbbtipo_operacao: TDBComboBox;
    btnFechar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadPedido: TFormCadPedido;

implementation

{$R *.dfm}

uses UdmCadPedido;

procedure TFormCadPedido.btnAlterarClick(Sender: TObject);
begin
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
  btnNovo.Enabled := False;

  dbedtCodigo.Enabled := True;
  dbedtReferencia.Enabled := True;
  dbedtNumeroPedido.Enabled := True;
  dbedtDataEmissao.Enabled := True;
  dbedtCodigoCliente.Enabled:=True;
  //dbedtTipoOperacao.Enabled:=True;
  //dbedtTotalPedido.Enabled := True;
  dbcbbtipo_operacao.Enabled := True;

  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  try
    dmCadPedido.FDQueryPedido.Edit;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Alterar, Messagem de erro: ' + E.Message),
         'Erro ao Alterar',MB_ICONERROR+MB_OK);
  end;
end;

procedure TFormCadPedido.btnCancelarClick(Sender: TObject);
begin
  dbedtCodigo.Enabled := False;
  dbedtReferencia.Enabled := False;
  dbedtNumeroPedido.Enabled := False;
  dbedtDataEmissao.Enabled := False;
  dbedtCodigoCliente.Enabled:=False;
  dbcbbtipo_operacao.Enabled:=False;
  dbedtTotalPedido.Enabled := False;

  btnExcluir.Enabled := True;
  btnAlterar.Enabled := True;
  btnNovo.Enabled := True;

  btnCancelar.Enabled:= False;
  btnSalvar.Enabled := False;

  try
    dmCadPedido.FDQueryPedido.Cancel;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Cancelar, Messagem de erro: ' + E.Message),
         'Erro ao Cancelar',MB_ICONERROR+MB_OK);
  end;
end;

procedure TFormCadPedido.btnExcluirClick(Sender: TObject);
begin
   try
    dmCadPedido.FDQueryPedido.Delete;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Excluir, Messagem de erro: ' + E.Message),
         'Erro ao Excluir',MB_ICONERROR+MB_OK);
  end;

  if dmCadPedido.FDQueryPedido.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;
end;

procedure TFormCadPedido.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCadPedido.btnNovoClick(Sender: TObject);
begin
  btnNovo.Enabled:= False;
  try
    dmCadPedido.FDQueryPedido.Append;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao criar um novo registro!, Messagem de erro:' + E.Message),
       'Erro ao criar um novo registro!',MB_ICONERROR+MB_OK);
  end;

  btnExcluir.Enabled := False;
  btnAlterar.Enabled := False;

  dbcbbtipo_operacao.Enabled:= True;
  dbedtCodigo.Text := '';
  dbedtCodigo.Enabled := True;
  dbedtReferencia.Text := '';
  dbedtReferencia.Enabled := True;
  dbedtNumeroPedido.Text := '';
  dbedtNumeroPedido.Enabled := True;
  dbedtDataEmissao.Text :='';
  dbedtDataEmissao.Enabled := True;
  dbedtCodigoCliente.Text:='';
  dbedtCodigoCliente.Enabled:=True;
  dbedtTotalPedido.Text := '';
  dbedtTotalPedido.Enabled := True;

  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
end;

procedure TFormCadPedido.btnSalvarClick(Sender: TObject);
begin
  dbedtTotalPedido.Text:= '0';
  if string.Equals(Trim(dbedtCodigo.Text), EmptyStr) or
     string.Equals(Trim(dbedtReferencia.Text), EmptyStr) or
     string.Equals(Trim(dbedtNumeroPedido.Text), EmptyStr) or
     string.Equals(Trim(dbedtDataEmissao.Text), EmptyStr) or
     string.Equals(Trim(dbedtCodigoCliente.Text), EmptyStr) or
     string.Equals(Trim(dbedtTotalPedido.Text), EmptyStr) or
     string.Equals(Trim(dbcbbtipo_operacao.Text), EmptyStr)
  then
  begin
    Application.MessageBox('Os Campos não podem estar vazios',
      'Campos vazios',MB_ICONERROR+MB_OK);
    Exit;
  end;

  try
    dmCadPedido.FDQueryPedido.Post;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Salvar, Messagem de erro:' + E.Message),
       'Erro ao Salvar',MB_ICONERROR+MB_OK);
  end;

  btnExcluir.Enabled := True;
  btnAlterar.Enabled := True;
  btnNovo.Enabled := True;

  btnCancelar.Enabled := False;
  btnSalvar.Enabled := False;

  dbedtCodigo.Enabled := False;
  dbedtReferencia.Enabled := False;
  dbedtNumeroPedido.Enabled := False;
  dbedtDataEmissao.Enabled := False;
  dbedtCodigoCliente.Enabled:=False;
  dbcbbtipo_operacao.Enabled:=False;
  dbedtTotalPedido.Enabled := False;
end;

procedure TFormCadPedido.FormCreate(Sender: TObject);
begin
  dmCadPedido.inicializaConsultaPedido;
  dsPedido.DataSet := dmCadPedido.FDQueryPedido;

  if dmCadPedido.FDQueryPedido.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;

  btnSalvar.Enabled := False;
end;

end.
