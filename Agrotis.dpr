program Agrotis;

uses
  Vcl.Forms,
  frmAcesso in 'Forms\frmAcesso.pas' {formAcesso},
  frmPrincipal in 'Forms\frmPrincipal.pas' {formPrincipal},
  frmCadProduto in 'Forms\frmCadProduto.pas' {FormCadProduto},
  frmCadPedido in 'Forms\frmCadPedido.pas' {formCadPedido},
  frmCadItemPedido in 'Forms\frmCadItemPedido.pas' {formCadItemPedido},
  frmCadParcelaPedido in 'Forms\frmCadParcelaPedido.pas' {formCadParcelaPedido},
  UdmConexao in 'DataModule\UdmConexao.pas' {dmConexao: TDataModule},
  UdmCadProduto in 'DataModule\UdmCadProduto.pas' {dmCadProduto: TDataModule},
  UdmCadPedido in 'DataModule\UdmCadPedido.pas' {dmCadPedido: TDataModule},
  UdmCadItemPedido in 'DataModule\UdmCadItemPedido.pas' {dmCadPedidoItem: TDataModule},
  UdmCadParcelaPedido in 'DataModule\UdmCadParcelaPedido.pas' {dmCadParcelaPedido: TDataModule},
  frmGrafico in 'Forms\frmGrafico.pas' {formGraficoPedido},
  frmConfiguraDB in 'Forms\frmConfiguraDB.pas' {formConfiguraDB};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformAcesso, formAcesso);
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.CreateForm(TFormCadProduto, FormCadProduto);
  Application.CreateForm(TformCadPedido, formCadPedido);
  Application.CreateForm(TformCadItemPedido, formCadItemPedido);
  Application.CreateForm(TformCadParcelaPedido, formCadParcelaPedido);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmCadProduto, dmCadProduto);
  Application.CreateForm(TdmCadPedido, dmCadPedido);
  Application.CreateForm(TdmCadPedidoItem, dmCadPedidoItem);
  Application.CreateForm(TdmCadParcelaPedido, dmCadParcelaPedido);
  Application.CreateForm(TformGraficoPedido, formGraficoPedido);
  Application.CreateForm(TformConfiguraDB, formConfiguraDB);
  Application.Run;
end.
