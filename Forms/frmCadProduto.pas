unit frmCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFormCadProduto = class(TForm)
    lbl1: TLabel;
    shp2: TShape;
    img2: TImage;
    img1: TImage;
    shp1: TShape;
    grp1: TGroupBox;
    dbgrd1: TDBGrid;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnAlterar: TButton;
    btnNovo: TButton;
    SearchBox1: TSearchBox;
    grp2: TGroupBox;
    lbl2: TLabel;
    edtCodProduto: TEdit;
    lbl3: TLabel;
    mmoDescProduto: TMemo;
    lbl9: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadProduto: TFormCadProduto;

implementation

{$R *.dfm}

end.
