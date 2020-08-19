unit frmCadPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFormCadPedido = class(TForm)
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
    edt2: TEdit;
    lbl5: TLabel;
    edt3: TEdit;
    lbl8: TLabel;
    edt6: TEdit;
    edt4: TEdit;
    lbl6: TLabel;
    lbl4: TLabel;
    edt1: TEdit;
    edt5: TEdit;
    lbl7: TLabel;
    lbl9: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadPedido: TFormCadPedido;

implementation

{$R *.dfm}

end.
