unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.Menus,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormPrincipal = class(TForm)
    img1: TImage;
    mm1: TMainMenu;
    Cadastros1: TMenuItem;
    Sobre1: TMenuItem;
    Ajuda1: TMenuItem;
    Relatrios1: TMenuItem;
    img2: TImage;
    stat1: TStatusBar;
    Produto1: TMenuItem;
    Pedido1: TMenuItem;
    ItemPedido1: TMenuItem;
    Parcelapedido1: TMenuItem;
    CadastroPedido1: TMenuItem;
    CadastroProduto1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadastroPedido1Click(Sender: TObject);
    procedure CadastroProduto1Click(Sender: TObject);
    procedure ItemPedido1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses frmAcesso, frmCadProduto, frmCadPedido,frmCadItemPedido;

procedure TFormPrincipal.CadastroPedido1Click(Sender: TObject);
begin
  FormCadPedido := TFormCadPedido.Create(Self);
  FormCadPedido.ShowModal;
end;

procedure TFormPrincipal.CadastroProduto1Click(Sender: TObject);
begin
  FormCadProduto := TFormCadProduto.Create(self);
  FormCadProduto.ShowModal;
end;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  FormAcesso.Visible:= false;
end;

procedure TFormPrincipal.ItemPedido1Click(Sender: TObject);
begin
  FormCadItemPedido := TFormCadItemPedido.Create(self);
  FormCadItemPedido.ShowModal;
end;

end.
