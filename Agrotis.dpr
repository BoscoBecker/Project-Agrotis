program Agrotis;

uses
  Vcl.Forms,
  frmAcesso in 'Forms\frmAcesso.pas' {FormAcesso},
  frmPrincipal in 'Forms\frmPrincipal.pas' {FormPrincipal},
  frmCadProduto in 'Forms\frmCadProduto.pas' {FormCadProduto},
  frmCadPedido in 'Forms\frmCadPedido.pas' {FormCadPedido},
  frmCadItemPedido in 'Forms\frmCadItemPedido.pas' {FormCadItemPedido},
  frmCadParcelaPedido in 'Forms\frmCadParcelaPedido.pas' {FormCadParcelaPedido},
  UdmConexao in 'DataModule\UdmConexao.pas' {dmConexao: TDataModule},
  UdmCadProduto in 'DataModule\UdmCadProduto.pas' {dmCadProduto: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormAcesso, FormAcesso);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmCadProduto, dmCadProduto);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormCadProduto, FormCadProduto);
  Application.CreateForm(TFormCadPedido, FormCadPedido);
  Application.CreateForm(TFormCadItemPedido, FormCadItemPedido);
  Application.CreateForm(TFormCadParcelaPedido, FormCadParcelaPedido);
  Application.Run;
end.
