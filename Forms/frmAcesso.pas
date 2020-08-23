unit frmAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TformAcesso = class(TForm)
    imgAcesso: TImage;
    btnAcesso: TButton;
    lblStatus: TLabel;
    imgLogo: TImage;
    imgFechar: TImage;
    shpLayout: TShape;
    actvtyndctranimador: TActivityIndicator;
    lblInfo: TLabel;
    procedure btnAcessoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAcesso: TformAcesso;

implementation

{$R *.dfm}

uses frmPrincipal;

procedure TformAcesso.btnAcessoClick(Sender: TObject);
begin
  FormPrincipal := TFormPrincipal.Create(self);
  FormPrincipal.ShowModal;
end;

procedure TformAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FormAcesso:= Nil;
end;

procedure TformAcesso.imgFecharClick(Sender: TObject);
begin
  Close;
end;

end.
