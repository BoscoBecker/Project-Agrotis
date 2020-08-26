unit frmCadItemPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Mask,FireDAC.Comp.Client;

type
  TformCadItemPedido = class(TForm)
    lblTitulo: TLabel;
    shpFundo: TShape;
    imgFundo: TImage;
    shpLayout: TShape;
    grpGrid: TGroupBox;
    lblPesquisa: TLabel;
    dbgrdItemPedido: TDBGrid;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnAlterar: TButton;
    btnNovo: TButton;
    grpDados: TGroupBox;
    lblCodigoProduto: TLabel;
    edtpesquisa: TSearchBox;
    lblQtd: TLabel;
    lblValorUnit: TLabel;
    lblTotalItem: TLabel;
    imgLogo: TImage;
    lblCodigoPedido: TLabel;
    dsItemPedido: TDataSource;
    btnFechar: TButton;
    dbedtqtd: TDBEdit;
    dbedtvalor_unit: TDBEdit;
    dbedttotal_item: TDBEdit;
    dsProduto: TDataSource;
    dbcbbcodigo: TDBComboBox;
    dblkcbbcodigo_produto: TDBLookupComboBox;
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtpesquisaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCadItemPedido: TformCadItemPedido;
  editandoItemPedido : Boolean;

implementation

{$R *.dfm}

uses UdmCadItemPedido, UdmConexao, UdmCadProduto;

procedure TformCadItemPedido.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TformCadItemPedido.btnAlterarClick(Sender: TObject);
begin
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
  btnNovo.Enabled := False;

  dbcbbcodigo.Enabled := True;
  dblkcbbcodigo_produto.Enabled := True;
  dbedtqtd.Enabled := True;
  dbedtvalor_unit.Enabled := True;
  dbedttotal_item.Enabled := True;

  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;

  try
    dmCadPedidoItem.FDQueryItemPedido.Edit;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Alterar, Messagem de erro: ' + E.Message),
         'Erro ao Alterar',MB_ICONERROR+MB_OK);
  end;
end;

procedure TformCadItemPedido.btnCancelarClick(Sender: TObject);
begin
  dbcbbcodigo.Enabled := False;
  dblkcbbcodigo_produto.Enabled := False;
  dbedtqtd.Enabled := False;
  dbedtvalor_unit.Enabled := False;
  dbedttotal_item.Enabled := False;

  btnExcluir.Enabled := True;
  btnAlterar.Enabled := True;
  btnNovo.Enabled := True;

  btnCancelar.Enabled:= False;
  btnSalvar.Enabled := False;
  try
    dmCadPedidoItem.FDQueryItemPedido.Cancel;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Cancelar, Messagem de erro: ' + E.Message),
         'Erro ao Cancelar',MB_ICONERROR+MB_OK);
  end;

  if dmCadPedidoItem.FDQueryItemPedido.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;
end;

procedure TformCadItemPedido.btnExcluirClick(Sender: TObject);
var codigoPedido: Integer;
begin
  codigoPedido:= StrToInt(dbgrdItemPedido.Columns[1].Field.Value);

  try
    dmCadPedidoItem.FDQueryItemPedido.Delete;
  except on E: Exception do
    begin
      Application.MessageBox(
        pchar('Erro ao Excluir, Messagem de erro: ' + E.Message),
           'Erro ao Excluir',MB_ICONERROR+MB_OK);
      Exit;
    end;
   end;

  // Total do Pedido (calculado a partir do somatório do TOTAL DOS ITENS)
  dmCadPedidoItem.atualizaCampoTotalPedido(codigoPedido);

  dbcbbcodigo.Items.Text:= dmCadPedidoItem.carregaComboItemPedidoCodigoPedido;

  dmCadPedidoItem.carregaComboItemPedidoCodigoProduto;
  dsProduto.DataSet := dmCadPedidoItem.FDQueryItemPedidoProduto;

  dmCadPedidoItem.inicializaConsultaItemPedido;
  dsItemPedido.DataSet := dmCadPedidoItem.FDQueryItemPedido;

  if dmCadPedidoItem.FDQueryItemPedido.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;
end;

procedure TformCadItemPedido.btnNovoClick(Sender: TObject);
begin
  btnNovo.Enabled:= False;
  try
    dmCadPedidoItem.FDQueryItemPedido.Append;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao criar um novo registro!, Messagem de erro: ' + E.Message),
       'Erro ao criar um novo registro!',MB_ICONERROR+MB_OK);
  end;

  btnExcluir.Enabled := False;
  btnAlterar.Enabled := False;

  dbcbbcodigo.Enabled := True;
  dblkcbbcodigo_produto.Enabled := True;

  dbedtqtd.Enabled := True;
  dbedtvalor_unit.Enabled := True;
  dbedttotal_item.Enabled := True;

  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
end;

procedure TformCadItemPedido.btnSalvarClick(Sender: TObject);
var codigoPedido: Integer;
begin

  if string.Equals(Trim(dbcbbcodigo.Text), EmptyStr) or
     string.Equals(Trim(dblkcbbcodigo_produto.Text), EmptyStr) or
     string.Equals(Trim(dbedtqtd.Text), EmptyStr) or
     string.Equals(Trim(dbedtvalor_unit.Text), EmptyStr)
  then
  begin
    Application.MessageBox('Os Campos não podem estar vazios!',
      'Campos vazios',MB_ICONERROR+MB_OK);
    Exit;
  end;

  codigoPedido:= StrToInt(dbgrdItemPedido.Columns[1].Field.Value);


  try
    dmCadPedidoItem.FDQueryItemPedido.Post;
  except on E: Exception do
    begin
      Application.MessageBox(
        pchar('Erro ao Salvar, Messagem de erro: ' + E.Message +
        ' DICA: TALVEZ O PEDIDO/PRODUTO JÁ ESTEJA CADASTRADO. '),
         'Erro ao Salvar',MB_ICONERROR+MB_OK);
      Exit;
    end;
  end;

  // Total do Pedido (calculado a partir do somatório do TOTAL DOS ITENS)
  dmCadPedidoItem.atualizaCampoTotalPedido(codigoPedido);

  dbcbbcodigo.Items.Text:= dmCadPedidoItem.carregaComboItemPedidoCodigoPedido;

  dmCadPedidoItem.carregaComboItemPedidoCodigoProduto;
  dsProduto.DataSet := dmCadPedidoItem.FDQueryItemPedidoProduto;

  dmCadPedidoItem.inicializaConsultaItemPedido;
  dsItemPedido.DataSet := dmCadPedidoItem.FDQueryItemPedido;

  btnExcluir.Enabled := True;
  btnAlterar.Enabled := True;
  btnNovo.Enabled := True;

  btnCancelar.Enabled := False;
  btnSalvar.Enabled := False;

  dbcbbcodigo.Enabled := False;
  dblkcbbcodigo_produto.Enabled := False;
  dbedtqtd.Enabled := False;
  dbedtvalor_unit.Enabled := False;
  dbedttotal_item.Enabled := False;
end;

procedure TformCadItemPedido.FormShow(Sender: TObject);
begin
  dmCadPedidoItem.inicializaConsultaItemPedido;
  dsItemPedido.DataSet := dmCadPedidoItem.FDQueryItemPedido;

  dbcbbcodigo.Items.Text:= dmCadPedidoItem.carregaComboItemPedidoCodigoPedido;

  dmCadPedidoItem.carregaComboItemPedidoCodigoProduto;
  dsProduto.DataSet := dmCadPedidoItem.FDQueryItemPedidoProduto;

  dmCadPedidoItem.inicializaConsultaItemPedido;
  dsItemPedido.DataSet := dmCadPedidoItem.FDQueryItemPedido;

  if dmCadPedidoItem.FDQueryItemPedido.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;

  btnSalvar.Enabled := False;
end;

procedure TformCadItemPedido.edtpesquisaChange(Sender: TObject);
begin
  dmCadPedidoItem.pesquisaItemPedido(edtpesquisa.Text);
end;
end.
