unit frmCadPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls;

type
  TformCadPedido = class(TForm)
    lblTitulo: TLabel;
    shpFundo: TShape;
    imgFundo: TImage;
    shpLayout: TShape;
    grpGrid: TGroupBox;
    dbgrdPedido: TDBGrid;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnAlterar: TButton;
    btnNovo: TButton;
    grpCampos: TGroupBox;
    lblCodigo: TLabel;
    lblReferencia: TLabel;
    lblDataEmissao: TLabel;
    lblTotalPedido: TLabel;
    lblCodigoCliente: TLabel;
    lblNroPedido: TLabel;
    lblTipoOperacao: TLabel;
    lblPesquisar: TLabel;
    imgLogo: TImage;
    dsPedido: TDataSource;
    dbedtCodigo: TDBEdit;
    dbedtReferencia: TDBEdit;
    dbedtNumeroPedido: TDBEdit;
    dbedtDataEmissao: TDBEdit;
    dbedtCodigoCliente: TDBEdit;
    dbedtTotalPedido: TDBEdit;
    dbcbbtipo_operacao: TDBComboBox;
    btnFechar: TButton;
    lblExemplo: TLabel;
    edtPesquisa: TSearchBox;
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCadPedido: TformCadPedido;

implementation

{$R *.dfm}

uses UdmCadPedido, UdmCadProduto;

procedure TformCadPedido.btnAlterarClick(Sender: TObject);
begin
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
  btnNovo.Enabled := False;

  dbedtCodigo.Enabled := True;
  dbedtReferencia.Enabled := True;
  dbedtNumeroPedido.Enabled := True;
  dbedtDataEmissao.Enabled := True;
  dbedtCodigoCliente.Enabled:=True;
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

procedure TformCadPedido.btnCancelarClick(Sender: TObject);
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

  if dmCadPedido.FDQueryPedido.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;
end;

procedure TformCadPedido.btnExcluirClick(Sender: TObject);
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

procedure TformCadPedido.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TformCadPedido.btnNovoClick(Sender: TObject);
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

procedure TformCadPedido.btnSalvarClick(Sender: TObject);
begin
  // Is used in first record
  if string.Equals(dbedtTotalPedido.Text, EmptyStr) then
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
    begin
      Application.MessageBox(
        pchar('Erro ao Salvar, Messagem de erro:' + E.Message),
         'Erro ao Salvar',MB_ICONERROR+MB_OK);
         Exit;
    end;
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

procedure TformCadPedido.FormShow(Sender: TObject);
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

procedure TformCadPedido.edtPesquisaChange(Sender: TObject);
begin
  dmCadPedido.pesquisaPedido(edtPesquisa.Text);
end;

end.
