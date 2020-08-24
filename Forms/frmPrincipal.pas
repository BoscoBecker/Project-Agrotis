unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.Menus,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.ComCtrls, Winapi.ShellAPI, Vcl.StdCtrls,
  Vcl.WinXCalendars;

type
  TformPrincipal = class(TForm)
    mmMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Sobre1: TMenuItem;
    Ajuda1: TMenuItem;
    Relatrios1: TMenuItem;
    imgFundo: TImage;
    statusRodape: TStatusBar;
    Produto1: TMenuItem;
    Pedido1: TMenuItem;
    ItemPedido1: TMenuItem;
    Parcelapedido1: TMenuItem;
    CadastroPedido1: TMenuItem;
    CadastroProduto1: TMenuItem;
    imgLogo: TImage;
    tmrStatus: TTimer;
    Pedidoem1: TMenuItem;
    Suporte1: TMenuItem;
    lbl1: TLabel;
    Calendario: TCalendarView;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadastroPedido1Click(Sender: TObject);
    procedure CadastroProduto1Click(Sender: TObject);
    procedure ItemPedido1Click(Sender: TObject);
    procedure Parcelapedido1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrStatusTimer(Sender: TObject);
    procedure Pedidoem1Click(Sender: TObject);
    procedure Suporte1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formPrincipal: TformPrincipal;

implementation

{$R *.dfm}

uses frmAcesso, frmCadProduto, frmCadPedido,frmCadItemPedido,
  frmCadParcelaPedido, UdmConexao, frmGrafico;

procedure TformPrincipal.CadastroPedido1Click(Sender: TObject);
begin
  FormCadPedido := TFormCadPedido.Create(Self);
  FormCadPedido.ShowModal;
end;

procedure TformPrincipal.CadastroProduto1Click(Sender: TObject);
begin
  FormCadProduto := TFormCadProduto.Create(self);
  FormCadProduto.ShowModal;
end;

procedure TformPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (Application.MessageBox('Deseja encerrar a aplicação?',
                              'Informação',MB_ICONQUESTION+MB_YESNO) = ID_YES)
  then
    Application.Terminate
  else
    Action := caNone;
end;

procedure TformPrincipal.FormCreate(Sender: TObject);
begin
 statusRodape.Panels[0].Text := 'Sistemas inteligentes para o agronegócio';
 statusRodape.Panels[2].Text := 'Olá, seja Bem Vindo';
end;

procedure TformPrincipal.FormShow(Sender: TObject);
begin
  FormAcesso.Visible:= false;
end;

procedure TformPrincipal.ItemPedido1Click(Sender: TObject);
begin
  FormCadItemPedido := TFormCadItemPedido.Create(self);
  FormCadItemPedido.ShowModal;
end;

procedure TformPrincipal.Parcelapedido1Click(Sender: TObject);
begin
  FormCadParcelaPedido := TFormCadParcelaPedido.Create(Self);
  FormCadParcelaPedido.ShowModal;
end;

procedure TformPrincipal.Pedidoem1Click(Sender: TObject);
begin
  formGraficoPedido := TformGraficoPedido.Create(self);
  formGraficoPedido.ShowModal;
end;

procedure TformPrincipal.Sobre1Click(Sender: TObject);
begin
  application.MessageBox(PChar(dmConexao.getVersionMSSQLSERVER),'Sobre o SQL SERVER.', MB_ICONINFORMATION+MB_OK);
end;

procedure TformPrincipal.Suporte1Click(Sender: TObject);
begin
  ShellExecute(Handle,'open','https://agrotis.atlassian.net/servicedesk/customer/portal/6',nil,nil,SW_SHOW);
end;

procedure TformPrincipal.tmrStatusTimer(Sender: TObject);
begin
 statusRodape.Panels[1].Text := FormatDateTime('DD/MM/YYY - hh:mm:ss', now);
end;

end.
