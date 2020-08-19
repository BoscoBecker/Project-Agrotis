unit frmAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFormAcesso = class(TForm)
    imgAcesso: TImage;
    btn2: TButton;
    lblStatus: TLabel;
    img1: TImage;
    img2: TImage;
    shp1: TShape;
    actvtyndctr1: TActivityIndicator;
    procedure btn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure img2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAcesso: TFormAcesso;

implementation

{$R *.dfm}

uses frmPrincipal;

procedure TFormAcesso.btn2Click(Sender: TObject);
begin
  FormPrincipal := TFormPrincipal.Create(self);
  FormPrincipal.ShowModal;
end;

procedure TFormAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FormAcesso:= Nil;
end;

procedure TFormAcesso.FormShow(Sender: TObject);
begin
  btn2.Brush.Color := clWhite;
end;

procedure TFormAcesso.img2Click(Sender: TObject);
begin
  Close;
end;

end.
