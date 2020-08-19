program Agrotis;

uses
  Vcl.Forms,
  frmAcesso in 'Forms\frmAcesso.pas' {FormAcesso},
  frmPrincipal in 'Forms\frmPrincipal.pas' {FormPrincipal},
  frmCadProduto in 'Forms\frmCadProduto.pas' {FormCadProduto},
  frmCadPedido in 'Forms\frmCadPedido.pas' {FormCadPedido},
  frmCadItemPedido in 'Forms\frmCadItemPedido.pas' {FormCadItemPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormAcesso, FormAcesso);
  Application.CreateForm(TFormCadProduto, FormCadProduto);
  Application.CreateForm(TFormCadPedido, FormCadPedido);
  Application.CreateForm(TFormCadItemPedido, FormCadItemPedido);
  Application.Run;
end.
