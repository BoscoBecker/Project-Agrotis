unit UdmConexao;

interface

uses
  System.SysUtils, Dialogs ,System.Classes, Forms, Data.DB, Data.Win.ADODB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;


type
  TdmConexao = class(TDataModule)
    connectionSSMS: TFDConnection;
    fdQueryAux: TFDQuery;
  private
    { Private declarations }

  public
    { Public declarations }


    procedure disconnectConnection;
    function getConnection : TFDConnection;
    function getVersionMSSQLSERVER : string;

  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



{ TdmConexao }

procedure TdmConexao.disconnectConnection;
begin
  connectionSSMS.Connected := False;
end;

function TdmConexao.getConnection: TFDConnection;
begin
  connectionSSMS.ConnectionName := 'TFDConnection : ' + FormatDateTime('HH:MM:SS', now);
  connectionSSMS.Connected := True;

  result := connectionSSMS;
end;

function TdmConexao.getVersionMSSQLSERVER: string;
 var value : String;
begin
  value := EmptyStr;

  fdQueryAux.Connection := getConnection;
  fdQueryAux.Close;
  fdQueryAux.SQL.Clear;
  fdQueryAux.SQL.Text := 'SELECT @@version';
  fdQueryAux.Open;

  value := fdQueryAux.Fields[0].Value;
  fdQueryAux.Close;

  result := value;
end;

end.
