unit frmConfiguraDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,UdmConexao,frmGrafico , Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.WinXCtrls,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, Data.DBXMsSQL, Data.SqlExpr ;

type
  TformConfiguraDB = class(TForm)
    imgLogo: TImage;
    lblTitulo: TLabel;
    imgFundo: TImage;
    shp1: TShape;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    edtSenha: TEdit;
    edtUsuario: TEdit;
    edtDriver: TEdit;
    edtServidor: TEdit;
    btnTestar: TButton;
    edtDataBase: TEdit;
    lbl5: TLabel;
    conexaoTest: TFDConnection;
    btn2: TButton;
    shpStatus: TShape;
    lblStatus: TLabel;
    shpLuz: TShape;
    procedure btnTestarClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  formConfiguraDB: TformConfiguraDB;

implementation

{$R *.dfm}

uses frmAcesso;

procedure TformConfiguraDB.btn2Click(Sender: TObject);
begin
 Close;  
end;

procedure TformConfiguraDB.btnTestarClick(Sender: TObject);
begin
  shpLuz.Brush.Color := clYellow;
  shpLuz.Repaint;
  try
    conexaoTest.ConnectionName := 'TFDConnection : ' + FormatDateTime('HH:MM:SS', now);
    conexaoTest.Params.Clear;
    conexaoTest.Params.Values['DriverID']  := edtDriver.Text;
    conexaoTest.Params.Values['Server'] := edtServidor.text;
    conexaoTest.Params.Values['Database'] := edtDataBase.Text;
    conexaoTest.Params.Values['User_name'] := edtUsuario.Text ;
    conexaoTest.Params.Values['Password'] := edtSenha.Text;
    conexaoTest.Connected := True;
  except on E: Exception do
    begin
      lblStatus.Caption :=
      'Erro ao conectar no SQL SERVER '+ #13#10 +
      'Mensagem de Erro do Driver: '+ #13#10 +  #13#10+
      E.Message;

      shpLuz.Brush.Color := clRed;

      Application.ProcessMessages;

      Exit;
    end;
  end;

  lblStatus.Caption := 'Base de dados Conectado.';
  shpLuz.Brush.Color := clGreen;
  
  if conexaoTest.Connected then  
  Begin
    dmConexao.setConnection(edtDriver.Text,edtServidor.text,edtDataBase.Text,
      edtUsuario.Text,edtSenha.Text);
  End;
end;

procedure TformConfiguraDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  formConfiguraDB:= Nil;
end;

end.
