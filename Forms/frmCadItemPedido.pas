unit frmCadItemPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Mask,FireDAC.Comp.Client;

type
  TFormCadItemPedido = class(TForm)
    lbl1: TLabel;
    shp2: TShape;
    img2: TImage;
    shp1: TShape;
    grp1: TGroupBox;
    lbl9: TLabel;
    dbgrd1: TDBGrid;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnAlterar: TButton;
    btnNovo: TButton;
    grp2: TGroupBox;
    lbl2: TLabel;
    SearchBox1: TSearchBox;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    img1: TImage;
    lbl6: TLabel;
    dsItemPedido: TDataSource;
    btn1: TButton;
    dbedtqtd: TDBEdit;
    dbedtvalor_unit: TDBEdit;
    dbedttotal_item: TDBEdit;
    dsProduto: TDataSource;
    dbcbbcodigo: TDBComboBox;
    dblkcbbcodigo_produto: TDBLookupComboBox;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadItemPedido: TFormCadItemPedido;

implementation

{$R *.dfm}

uses UdmCadItemPedido, UdmConexao, UdmCadProduto;

procedure TFormCadItemPedido.btn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormCadItemPedido.btnAlterarClick(Sender: TObject);
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

procedure TFormCadItemPedido.btnCancelarClick(Sender: TObject);
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
end;

procedure TFormCadItemPedido.btnExcluirClick(Sender: TObject);
begin
  try
    dmCadPedidoItem.FDQueryItemPedido.Delete;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Excluir, Messagem de erro: ' + E.Message),
         'Erro ao Excluir',MB_ICONERROR+MB_OK);
   end;

  dmCadPedidoItem.subtraiCampoTotalPedido(StrToint(dbedttotal_item.Text),
    StrToint(dbcbbcodigo.Text));

  // Methods
  dbcbbcodigo.Items.Text:= dmCadPedidoItem.carregaComboItemPedidoCodigoPedido;

  dmCadPedidoItem.carregaComboItemPedidoCodigoProduto;
  dsProduto.DataSet := dmCadPedidoItem.FDQueryItemPedidoProduto;

  dmCadPedidoItem.inicializaConsultaItemPedido;
  dsItemPedido.DataSet := dmCadPedidoItem.FDQueryItemPedido;

  ///
  if dmCadPedidoItem.FDQueryItemPedido.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;
end;

procedure TFormCadItemPedido.btnNovoClick(Sender: TObject);
begin
  btnNovo.Enabled:= False;
  try
    dmCadPedidoItem.FDQueryItemPedido.Append;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao criar um novo registro!, Messagem de erro:' + E.Message),
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

procedure TFormCadItemPedido.btnSalvarClick(Sender: TObject);
begin

  if string.Equals(Trim(dbcbbcodigo.Text), EmptyStr) or
     string.Equals(Trim(dblkcbbcodigo_produto.Text), EmptyStr) or
     string.Equals(Trim(dbedtqtd.Text), EmptyStr) or
     string.Equals(Trim(dbedtvalor_unit.Text), EmptyStr)
  then
  begin
    Application.MessageBox('Os Campos não podem estar vazios',
      'Campos vazios',MB_ICONERROR+MB_OK);
    Exit;
  end;

  try
    dmCadPedidoItem.FDQueryItemPedido.Post;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Salvar, Messagem de erro:' + E.Message),
       'Erro ao Salvar',MB_ICONERROR+MB_OK);
  end;

  dmCadPedidoItem.atualizaCampoTotalPedido(StrToint(dbedttotal_item.Text),
    StrToint(dbcbbcodigo.Text));

  // Methods
  dbcbbcodigo.Items.Text:= dmCadPedidoItem.carregaComboItemPedidoCodigoPedido;

  dmCadPedidoItem.carregaComboItemPedidoCodigoProduto;
  dsProduto.DataSet := dmCadPedidoItem.FDQueryItemPedidoProduto;

  dmCadPedidoItem.inicializaConsultaItemPedido;
  dsItemPedido.DataSet := dmCadPedidoItem.FDQueryItemPedido;

  ///

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

procedure TFormCadItemPedido.FormCreate(Sender: TObject);
begin

  // Methods
  dbcbbcodigo.Items.Text:= dmCadPedidoItem.carregaComboItemPedidoCodigoPedido;

  dmCadPedidoItem.carregaComboItemPedidoCodigoProduto;
  dsProduto.DataSet := dmCadPedidoItem.FDQueryItemPedidoProduto;

  dmCadPedidoItem.inicializaConsultaItemPedido;
  dsItemPedido.DataSet := dmCadPedidoItem.FDQueryItemPedido;
end;

end.
