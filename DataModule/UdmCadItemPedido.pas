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
  private
    { Private declarations }
  public
    { Public declarations }
    procedure inicializaConsultaItemPedido;
    procedure pesquisaItemPedido(const conteudo : string);

    function carregaComboItemPedidoCodigoProduto : String;
    function carregaComboItemPedidoCodigoPedido : String;
  end;

var
  dmCadPedidoItem: TdmCadPedidoItem;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UdmConexao;

{$R *.dfm}

{ TdmCadPedidoItem }

function TdmCadPedidoItem.carregaComboItemPedidoCodigoPedido: String;
var fdQueryPedido : TFDQuery;
begin
  fdQueryPedido := TFDQuery.Create(self);
  fdQueryPedido.Connection := UdmConexao.dmConexao.getConnection;
  fdQueryPedido.Close;
  fdQueryPedido.SQL.Clear;
  fdQueryPedido.SQL.Text :=
  'SELECT codigo FROM PEDIDO ';
  fdQueryPedido.Open;

  Result := fdQueryPedido.FieldByName('codigo').AsString;

end;

function TdmCadPedidoItem.carregaComboItemPedidoCodigoProduto: String;
 var fdQueryProduto : TFDQuery;
begin
  fdQueryProduto := TFDQuery.Create(self);
  fdQueryProduto.Connection := UdmConexao.dmConexao.getConnection;
  fdQueryProduto.Close;
  fdQueryProduto.SQL.Clear;
  fdQueryProduto.SQL.Text :=
  'SELECT codigo_produto FROM PRODUTO ';
  fdQueryProduto.Open;

  Result := fdQueryProduto.FieldByName('codigo_produto').AsString;
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
