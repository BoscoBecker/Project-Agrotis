unit frmCadItemPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFormCadItemPedido = class(TForm)
    lbl1: TLabel;
    shp2: TShape;
    img2: TImage;
    img1: TImage;
    shp1: TShape;
    grp1: TGroupBox;
    lbl9: TLabel;
    dbgrd1: TDBGrid;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnAlterar: TButton;
    btnNovo: TButton;
    grp2: TGroupBox;
    lbl2: TLabel;
    edtCodProduto: TEdit;
    SearchBox1: TSearchBox;
    edt1: TEdit;
    lbl3: TLabel;
    edt2: TEdit;
    lbl4: TLabel;
    edt3: TEdit;
    lbl5: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadItemPedido: TFormCadItemPedido;

implementation

{$R *.dfm}

end.
