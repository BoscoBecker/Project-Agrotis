unit UdmCadPedido;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCadPedido = class(TDataModule)
    FDQueryPedido: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure inicializaConsultaPedido;
    procedure pesquisaPedido(const conteudo : string);
  end;

var
  dmCadPedido: TdmCadPedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UdmConexao;

{$R *.dfm}

{ TdmCadPedido }

procedure TdmCadPedido.inicializaConsultaPedido;
begin
  Try
    if string.Equals(FDQueryPedido.ConnectionName, EmptyStr) then
      FDQueryPedido.connection := UdmConexao.dmConexao.getConnection;

    FDQueryPedido.Close;
    FDQueryPedido.SQL.Clear;
    FDQueryPedido.SQL.Text :=
      'SELECT '+
      '       codigo,referencia,nro_pedido,data_emissao,codigo_cliente,'+
      '       tipo_operacao,total_pedido '+
      '  FROM PEDIDO ';
  Finally
    FDQueryPedido.Open;
  End;
end;

procedure TdmCadPedido.pesquisaPedido(const conteudo: string);
begin
  Try
    if string.Equals(FDQueryPedido.ConnectionName, EmptyStr) then
      FDQueryPedido.connection := UdmConexao.dmConexao.getConnection;

    FDQueryPedido.Close;
    FDQueryPedido.SQL.Clear;
    FDQueryPedido.SQL.Text :=
      'SELECT ' +
      '       codigo,referencia,nro_pedido,data_emissao,codigo_cliente, ' +
      '       tipo_operacao,total_pedido '+
      '  FROM PEDIDO' +
      ' WHERE codigo LIKE ' + QuotedStr('%' + conteudo + '%') + ' OR ' +
      '       codigo LIKE ' + QuotedStr(conteudo + '%') + ' OR ' +
      '       codigo LIKE ' + QuotedStr('%' + conteudo + '%');
  Finally
    FDQueryPedido.Open;
  End;
end;

end.
