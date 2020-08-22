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
    dbcbbcodigo_pedido: TDBComboBox;
    dbcbbcodigo_produto: TDBComboBox;
    dsItemPedido: TDataSource;
    btn1: TButton;
    dbedtqtd: TDBEdit;
    dbedtvalor_unit: TDBEdit;
    dbedttotal_item: TDBEdit;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadItemPedido: TFormCadItemPedido;

implementation

{$R *.dfm}

uses UdmCadItemPedido, UdmConexao;

procedure TFormCadItemPedido.btn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormCadItemPedido.btnNovoClick(Sender: TObject);
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

procedure TFormCadItemPedido.FormCreate(Sender: TObject);
 var fdQueryProduto, fdQueryPedido : TFDQuery;
begin
  dmCadPedidoItem.inicializaConsultaItemPedido;
  dsItemPedido.DataSet := dmCadPedidoItem.FDQueryItemPedido;

  dbcbbcodigo_produto.Items.Add(
      dmCadPedidoItem.carregaComboItemPedidoCodigoProduto);

  dbcbbcodigo_pedido.Items.Add( dmCadPedidoItem.carregaComboItemPedidoCodigoPedido);




end;

end.
