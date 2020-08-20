object dmConexao: TdmConexao
  OldCreateOrder = False
  Height = 191
  Width = 355
  object connectionSSMS: TFDConnection
    Params.Strings = (
      'Database=dbagrotis'
      'Server=DESKTOP-FPNQ6CD'
      'OSAuthent=No'
      'User_Name=delphi'
      'Password=delphi'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 144
    Top = 64
  end
  object fdQueryAux: TFDQuery
    Connection = connectionSSMS
    Left = 144
    Top = 120
  end
end
