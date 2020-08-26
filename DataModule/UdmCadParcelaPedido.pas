unit UdmCadParcelaPedido;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCadParcelaPedido = class(TDataModule)
    FDQueryCadParcelaPedido: TFDQuery;
    FDQueryCadParcelaPedidoCodigo: TFDQuery;
    FDQueryValidaParcelamentoPedido: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure inicializaConsultaParcelaPedido;
    procedure pesquisaParcelaPedido(const conteudo : string);

    function parcelamentoPedidoValido(const valorParcela :Integer;
    codigo_pedido: integer): Boolean;
    function carregaComboParcelaPedidoCodigo: String;
  end;

var
  dmCadParcelaPedido: TdmCadParcelaPedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UdmConexao;

{$R *.dfm}

{ TdmCadParcelaPedido }

function TdmCadParcelaPedido.carregaComboParcelaPedidoCodigo : String;
var lista : TStringList;
begin
  lista := TStringList.Create();
  try
    FDQueryCadParcelaPedidoCodigo.Connection := UdmConexao.dmConexao.getConnection;
    FDQueryCadParcelaPedidoCodigo.Close;
    FDQueryCadParcelaPedidoCodigo.SQL.Clear;
    FDQueryCadParcelaPedidoCodigo.SQL.Text :=
    'SELECT codigo FROM PEDIDO ';
    FDQueryCadParcelaPedidoCodigo.Open;

    while not(FDQueryCadParcelaPedidoCodigo.eof) do
    begin
      lista.Add(FDQueryCadParcelaPedidoCodigo.FieldByName('codigo').AsString);
      FDQueryCadParcelaPedidoCodigo.Next;
    end;

    Result := lista.Text;
  finally
    lista.Free;
  end;
end;

procedure TdmCadParcelaPedido.inicializaConsultaParcelaPedido;
begin
  Try
    if string.Equals(FDQueryCadParcelaPedido.ConnectionName, EmptyStr) then
      FDQueryCadParcelaPedido.connection := UdmConexao.dmConexao.getConnection;

    FDQueryCadParcelaPedido.Close;
    FDQueryCadParcelaPedido.SQL.Clear;
    FDQueryCadParcelaPedido.SQL.Text :=
      'SELECT '+
      '       codigo_parcela,forma_pgto,data_vencimento,valor_parcela,codigo_pedido  '+
      '  FROM PEDIDO_PARCELA ';
  Finally
    FDQueryCadParcelaPedido.Open;
  End;
end;

function TdmCadParcelaPedido.parcelamentoPedidoValido(
  const valorParcela: Integer; codigo_pedido: integer): Boolean;
begin
  //if string.Equals(FDQueryValidaParcelamentoPedido.ConnectionName, EmptyStr) then
  //FDQueryValidaParcelamentoPedido.connection := UdmConexao.dmConexao.getConnection;

  FDQueryValidaParcelamentoPedido.Close;
  FDQueryValidaParcelamentoPedido.SQL.Clear;
  FDQueryValidaParcelamentoPedido.SQL.Text :=
  'SELECT total_pedido FROM PEDIDO WHERE codigo =:codigo_pedido';
  FDQueryValidaParcelamentoPedido.ParamByName('codigo_pedido').AsInteger := codigo_pedido;
  FDQueryValidaParcelamentoPedido.Open;

  result := (valorParcela > FDQueryValidaParcelamentoPedido.Fields[0].AsInteger);
  FDQueryValidaParcelamentoPedido.Close;
end;

procedure TdmCadParcelaPedido.pesquisaParcelaPedido(const conteudo: string);
begin
   Try
    if string.Equals(FDQueryCadParcelaPedido.ConnectionName, EmptyStr) then
      FDQueryCadParcelaPedido.connection := UdmConexao.dmConexao.getConnection;

    FDQueryCadParcelaPedido.Close;
    FDQueryCadParcelaPedido.SQL.Clear;
    FDQueryCadParcelaPedido.SQL.Text :=
      'SELECT '+
      '       codigo_parcela,forma_pgto,data_vencimento,valor_parcela,codigo_pedido '+
      '  FROM PEDIDO_PARCELA '+
      ' WHERE codigo_parcela LIKE ' + QuotedStr('%' + conteudo + '%') + ' OR ' +
      '       codigo_parcela LIKE ' + QuotedStr(conteudo + '%') + ' OR ' +
      '       codigo_parcela LIKE ' + QuotedStr('%' + conteudo + '%');
  Finally
    FDQueryCadParcelaPedido.Open;
  End;
end;

end.
