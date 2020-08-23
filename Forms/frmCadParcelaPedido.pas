unit frmCadParcelaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFormCadParcelaPedido = class(TForm)
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
    SearchBox1: TSearchBox;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    edtCodProduto: TEdit;
    mmoDescProduto: TMemo;
    btn1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadParcelaPedido: TFormCadParcelaPedido;

implementation

{$R *.dfm}

end.
