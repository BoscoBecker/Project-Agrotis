unit UdmCadProduto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCadProduto = class(TDataModule)
    FDQueryProduto: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  procedure inicializaConsultaProduto;
  procedure pesquisaProduto(const conteudo : string);
  end;

var
  dmCadProduto: TdmCadProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UdmConexao;

{$R *.dfm}

{ TdmCadProduto }

procedure TdmCadProduto.inicializaConsultaProduto;
begin
  Try
    if string.Equals(FDQueryProduto.ConnectionName, EmptyStr) then
      FDQueryProduto.connection := UdmConexao.dmConexao.getConnection;

    FDQueryProduto.Close;
    FDQueryProduto.SQL.Clear;
    FDQueryProduto.SQL.Text :=
      'SELECT '+
      '       codigo_produto, descricao '+
      '  FROM PRODUTO';
  Finally
    FDQueryProduto.Open;
  End;
end;

procedure TdmCadProduto.pesquisaProduto(const conteudo : string);
begin
  Try
    if string.Equals(FDQueryProduto.ConnectionName, EmptyStr) then
      FDQueryProduto.connection := UdmConexao.dmConexao.getConnection;

    FDQueryProduto.Close;
    FDQueryProduto.SQL.Clear;
    FDQueryProduto.SQL.Text :=
      'SELECT ' +
      '       codigo_produto,descricao ' +
      '  FROM PRODUTO' +
      ' WHERE descricao LIKE ' + QuotedStr('%' + conteudo + '%') + ' OR ' +
      '       descricao LIKE ' + QuotedStr(conteudo + '%') + ' OR ' +
      '       descricao LIKE ' + QuotedStr('%' + conteudo + '%'); 
  Finally
    FDQueryProduto.Open;
  End;
end;

end.
