unit frmCadParcelaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Mask;

type
  TformCadParcelaPedido = class(TForm)
    lblTitulo: TLabel;
    shp2: TShape;
    imgFundo: TImage;
    imgLogo: TImage;
    shp1: TShape;
    grpGrid: TGroupBox;
    lblPesquisa: TLabel;
    dbgrdParcelaPedido: TDBGrid;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnAlterar: TButton;
    btnNovo: TButton;
    grpDados: TGroupBox;
    lblCodigo_Parcela: TLabel;
    lblData_vencimento: TLabel;
    btnFechar: TButton;
    dbedtdata_vencimento: TDBEdit;
    dbedtvalor_parcela: TDBEdit;
    dbcbbforma_pgto: TDBComboBox;
    lblCodigo_pedido: TLabel;
    lblValor_parcela: TLabel;
    dbcbbcodigo_pedido: TDBComboBox;
    lblForma_pgto: TLabel;
    lblExemplo: TLabel;
    dsParcelaPedido: TDataSource;
    dbedtcodigo_parcela: TDBEdit;
    PesquisaParcelaPedido: TSearchBox;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure PesquisaParcelaPedidoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCadParcelaPedido: TformCadParcelaPedido;

implementation

{$R *.dfm}

uses UdmCadParcelaPedido;

procedure TformCadParcelaPedido.btnAlterarClick(Sender: TObject);
begin
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
  btnNovo.Enabled := False;

  dbedtcodigo_parcela.Enabled := True;
  dbcbbcodigo_pedido.Enabled := True;

  dbcbbforma_pgto.Enabled := True;
  dbedtvalor_parcela.Enabled := True;
  dbedtdata_vencimento.Enabled := True;

  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;

  try
    dmCadParcelaPedido.FDQueryCadParcelaPedido.Edit;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Alterar, Messagem de erro: ' + E.Message),
         'Erro ao Alterar',MB_ICONERROR+MB_OK);
  end;
end;

procedure TformCadParcelaPedido.btnCancelarClick(Sender: TObject);
begin
  dbedtcodigo_parcela.Enabled := False;
  dbcbbcodigo_pedido.Enabled := False;

  dbcbbforma_pgto.Enabled := False;
  dbedtvalor_parcela.Enabled := False;
  dbedtdata_vencimento.Enabled := False;

  btnExcluir.Enabled := True;
  btnAlterar.Enabled := True;
  btnNovo.Enabled := True;

  btnCancelar.Enabled:= False;
  btnSalvar.Enabled := False;
  try
    dmCadParcelaPedido.FDQueryCadParcelaPedido.Cancel;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Cancelar, Messagem de erro: ' + E.Message),
         'Erro ao Cancelar',MB_ICONERROR+MB_OK);
  end;

  if dmCadParcelaPedido.FDQueryCadParcelaPedido.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;
end;

procedure TformCadParcelaPedido.btnExcluirClick(Sender: TObject);
begin
  try
    dmCadParcelaPedido.FDQueryCadParcelaPedido.Delete;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Excluir, Messagem de erro: ' + E.Message),
         'Erro ao Excluir',MB_ICONERROR+MB_OK);
   end;

  dbcbbcodigo_pedido.Items.Text:= dmCadParcelaPedido.carregaComboParcelaPedidoCodigo;

  dmCadParcelaPedido.inicializaConsultaParcelaPedido;
  dsParcelaPedido.DataSet := dmCadParcelaPedido.FDQueryCadParcelaPedido;

  if dmCadParcelaPedido.FDQueryCadParcelaPedido.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;
end;

procedure TformCadParcelaPedido.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TformCadParcelaPedido.btnNovoClick(Sender: TObject);
begin
  btnNovo.Enabled:= False;
  try
    dmCadParcelaPedido.FDQueryCadParcelaPedido.Append;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao criar um novo registro!, Messagem de erro:' + E.Message),
       'Erro ao criar um novo registro!',MB_ICONERROR+MB_OK);
  end;

  btnExcluir.Enabled := False;
  btnAlterar.Enabled := False;

  dbedtcodigo_parcela.Enabled := True;
  dbcbbcodigo_pedido.Enabled := True;
  dbcbbforma_pgto.Enabled := True;
  dbedtvalor_parcela.Enabled := True;
  dbedtdata_vencimento.Enabled := True;

  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
end;

procedure TformCadParcelaPedido.btnSalvarClick(Sender: TObject);
var codigoPedido, valorParcela : Integer;
begin
  if string.Equals(Trim(dbedtcodigo_parcela.Text), EmptyStr) or
     string.Equals(Trim(dbcbbcodigo_pedido.Text), EmptyStr) or
     string.Equals(Trim(dbcbbforma_pgto.Text), EmptyStr) or
     string.Equals(Trim(dbedtvalor_parcela.Text), EmptyStr) or
     string.Equals(Trim(dbedtdata_vencimento.Text), EmptyStr)
  then
  begin
    Application.MessageBox('Os Campos não podem estar vazios',
      'Campos vazios',MB_ICONERROR+MB_OK);
    Exit;
  end;

  codigoPedido:= StrToInt(dbgrdParcelaPedido.Columns[1].Field.Value);
  valorParcela:= StrToInt(dbgrdParcelaPedido.Columns[3].Field.Value);

  /// VALIDAÇÃO: o TOTAL DA(S) PARCELA(S) não pode ser maior do que o TOTAL DO PEDIDO
  if dmCadParcelaPedido.parcelamentoPedidoValido(valorParcela,codigoPedido) then
  begin
    Application.MessageBox(
      PChar('O TOTAL DA(S) '+'[ '+IntToStr(valorParcela)+' ]'+' PARCELA(S) NÃO PODE SER '+
            'MAIOR DO QUE O TOTAL DO PEDIDO, CÓDIGO '+'[ '+IntToStr(codigoPedido)+' ] !!!'),
            'VALIDAÇÃO', MB_ICONSTOP+MB_OK);

    dmCadParcelaPedido.FDQueryCadParcelaPedido.Cancel;

    dbcbbcodigo_pedido.Items.Text:= dmCadParcelaPedido.carregaComboParcelaPedidoCodigo;
    dmCadParcelaPedido.inicializaConsultaParcelaPedido;
    dsParcelaPedido.DataSet := dmCadParcelaPedido.FDQueryCadParcelaPedido;

    btnExcluir.Enabled := True;
    btnAlterar.Enabled := True;
    btnNovo.Enabled := True;

    btnCancelar.Enabled := False;
    btnSalvar.Enabled := False;

    dbedtcodigo_parcela.Enabled := False;
    dbcbbcodigo_pedido.Enabled := False;
    dbcbbforma_pgto.Enabled := False;
    dbedtvalor_parcela.Enabled := False;
    dbedtdata_vencimento.Enabled := False;

    Exit;
  end;

  try
    dmCadParcelaPedido.FDQueryCadParcelaPedido.Post;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Salvar, Messagem de erro:' + E.Message),
       'Erro ao Salvar',MB_ICONERROR+MB_OK);
  end;

  dbcbbcodigo_pedido.Items.Text:= dmCadParcelaPedido.carregaComboParcelaPedidoCodigo;

  dmCadParcelaPedido.inicializaConsultaParcelaPedido;
  dsParcelaPedido.DataSet := dmCadParcelaPedido.FDQueryCadParcelaPedido;

  btnExcluir.Enabled := True;
  btnAlterar.Enabled := True;
  btnNovo.Enabled := True;

  btnCancelar.Enabled := False;
  btnSalvar.Enabled := False;

  dbedtcodigo_parcela.Enabled := False;
  dbcbbcodigo_pedido.Enabled := False;
  dbcbbforma_pgto.Enabled := False;
  dbedtvalor_parcela.Enabled := False;
  dbedtdata_vencimento.Enabled := False;
end;

procedure TformCadParcelaPedido.FormCreate(Sender: TObject);
begin
  dbcbbcodigo_pedido.Items.Text:= dmCadParcelaPedido.carregaComboParcelaPedidoCodigo;

  dmCadParcelaPedido.inicializaConsultaParcelaPedido;
  dsParcelaPedido.DataSet := dmCadParcelaPedido.FDQueryCadParcelaPedido;

  if dmCadParcelaPedido.FDQueryCadParcelaPedido.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;

  btnSalvar.Enabled := False;
end;

procedure TformCadParcelaPedido.PesquisaParcelaPedidoChange(Sender: TObject);
begin
  dmCadParcelaPedido.pesquisaParcelaPedido(PesquisaParcelaPedido.Text);
end;
end.
