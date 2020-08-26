unit UdmCadItemPedido;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCadPedidoItem = class(TDataModule)
    FDQueryItemPedido: TFDQuery;
    FDQueryItemPedidoProduto: TFDQuery;
    FDQueryItemPedidoPedido: TFDQuery;
    FDCommandAtualizaTotalPedido: TFDCommand;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure inicializaConsultaItemPedido;
    procedure pesquisaItemPedido(const conteudo:string);
    procedure carregaComboItemPedidoCodigoProduto;

    procedure atualizaCampoTotalPedido(codigo:Integer);
    function carregaComboItemPedidoCodigoPedido: String;
  end;

var
  dmCadPedidoItem: TdmCadPedidoItem;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UdmConexao;

{$R *.dfm}

{ TdmCadPedidoItem }

procedure TdmCadPedidoItem.atualizaCampoTotalPedido(codigo:Integer);
begin
  FDCommandAtualizaTotalPedido.Connection := dmConexao.getConnection;
  FDCommandAtualizaTotalPedido.ParamByName('CODIGO_PEDIDO').Asinteger := codigo;
  FDCommandAtualizaTotalPedido.Execute();
end;

function TdmCadPedidoItem.carregaComboItemPedidoCodigoPedido : String;
var lista : TStringList;
begin
  lista := TStringList.Create();

  try
    FDQueryItemPedidoPedido.Close;
    FDQueryItemPedidoPedido.Connection := UdmConexao.dmConexao.getConnection;
    FDQueryItemPedidoPedido.Close;
    FDQueryItemPedidoPedido.SQL.Clear;
    FDQueryItemPedidoPedido.SQL.Text :=
    'SELECT codigo FROM PEDIDO ';
    FDQueryItemPedidoPedido.Open;

    while not(FDQueryItemPedidoPedido.eof) do
    begin
      lista.Add(FDQueryItemPedidoPedido.FieldByName('codigo').AsString);
      FDQueryItemPedidoPedido.Next;
    end;

    Result := lista.Text;
  finally
    lista.Free;
  end;
end;

procedure TdmCadPedidoItem.carregaComboItemPedidoCodigoProduto;
begin
  FDQueryItemPedidoProduto.Close;
  FDQueryItemPedidoProduto.Connection := UdmConexao.dmConexao.getConnection;
  FDQueryItemPedidoProduto.SQL.Clear;
  FDQueryItemPedidoProduto.SQL.Text :=
  'SELECT codigo_produto,descricao FROM PRODUTO ';
  FDQueryItemPedidoProduto.Open;
end;

procedure TdmCadPedidoItem.inicializaConsultaItemPedido;
begin
  Try
    if string.Equals(FDQueryItemPedido.ConnectionName, EmptyStr) then
      FDQueryItemPedido.connection := UdmConexao.dmConexao.getConnection;

    FDQueryItemPedido.Close;
    FDQueryItemPedido.SQL.Clear;
    FDQueryItemPedido.SQL.Text :=
      'SELECT '+
      '       codigo_produto, codigo_pedido, qtd, valor_unit, total_item '+
      '  FROM PEDIDO_ITEM  ';
  Finally
    FDQueryItemPedido.Open;
  End;
end;

procedure TdmCadPedidoItem.pesquisaItemPedido(const conteudo: string);
begin
  Try
    if string.Equals(FDQueryItemPedido.ConnectionName, EmptyStr) then
      FDQueryItemPedido.connection := UdmConexao.dmConexao.getConnection;

    FDQueryItemPedido.Close;
    FDQueryItemPedido.SQL.Clear;
    FDQueryItemPedido.SQL.Text :=
      'SELECT ' +
      '       codigo_produto, codigo_pedido, qtd, valor_unit, total_item ' +
      ' FROM PEDIDO_ITEM ' +
      ' WHERE codigo_pedido LIKE ' + QuotedStr('%' + conteudo + '%') + ' OR ' +
      '       codigo_pedido LIKE ' + QuotedStr(conteudo + '%') + ' OR ' +
      '       codigo_pedido LIKE ' + QuotedStr('%' + conteudo + '%');
  Finally
    FDQueryItemPedido.Open;
  End;
end;
end.
