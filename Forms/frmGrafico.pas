unit frmGrafico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, VCLTee.TeEngine, VCLTee.Series,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  TformGraficoPedido = class(TForm)
    FDConnectionGrafico: TFDConnection;
    FDQueryGrafico: TFDQuery;
    imgFundo: TImage;
    imgLogo: TImage;
    lblTitulo: TLabel;
    shpFundo: TShape;
    grpgGrafico: TGroupBox;
    btnFechar: TButton;
    dbchtGraficoPedido: TDBChart;
    Series1: TBarSeries;
    btnImprimir: TButton;
    procedure btnImprimirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formGraficoPedido: TformGraficoPedido;

implementation

{$R *.dfm}

procedure TformGraficoPedido.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TformGraficoPedido.btnImprimirClick(Sender: TObject);
begin
  dbchtGraficoPedido.PrintProportional := True;
  dbchtGraficoPedido.Print;
end;

procedure TformGraficoPedido.FormCreate(Sender: TObject);
begin
  FDQueryGrafico.Close;
  FDQueryGrafico.Open;
end;

end.
