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
    procedure setConnection(_DriverID, _Server, _Database, _User_name, _Password : String);
    function getConnection : TFDConnection;
    function getVersionMSSQLSERVER : string;
    function baseConectada : Boolean;
 end;

var
  dmConexao: TdmConexao;
  DriverID, Server, Database, User_name, Password : String ;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



{ TdmConexao }

function TdmConexao.baseConectada: Boolean;
begin
  result := True;
  connectionSSMS.ConnectionName := 'TFDConnection : ' + FormatDateTime('HH:MM:SS', now);
  connectionSSMS.Params.Clear;
  connectionSSMS.Params.Values['DriverID']  := DriverID;
  connectionSSMS.Params.Values['Server'] := Server;
  connectionSSMS.Params.Values['Database'] := Database;
  connectionSSMS.Params.Values['User_name'] := User_name ;
  connectionSSMS.Params.Values['Password'] := Password;
  try
    connectionSSMS.Connected := True;
  except on E: Exception do
    result := False;
  end;
end;

procedure TdmConexao.disconnectConnection;
begin
  connectionSSMS.Connected := False;
end;

function TdmConexao.getConnection: TFDConnection;
begin
  result := connectionSSMS;

  if Trim(DriverID) = '' then
  begin
    ShowMessage('A conexão não pode estar vazia');
    Exit;
  end;

  connectionSSMS.ConnectionName := 'TFDConnection : ' + FormatDateTime('HH:MM:SS', now);
  connectionSSMS.Params.Clear;
  connectionSSMS.Params.Values['DriverID']  := DriverID;
  connectionSSMS.Params.Values['Server'] := Server;
  connectionSSMS.Params.Values['Database'] := Database;
  connectionSSMS.Params.Values['User_name'] := User_name ;
  connectionSSMS.Params.Values['Password'] := Password;
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

procedure TdmConexao.setConnection(_DriverID, _Server, _Database, _User_name,
  _Password: String);
begin
  DriverID:= _DriverID;
  Server:= _Server;
  Database:= _Database;
  User_name:= _User_name;
  Password:= _Password;
end;

end.
