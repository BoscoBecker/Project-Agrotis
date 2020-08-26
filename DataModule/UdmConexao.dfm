object dmConexao: TdmConexao
  OldCreateOrder = False
  Height = 191
  Width = 355
  object connectionSSMS: TFDConnection
    Params.Strings = (
      'OSAuthent=No'
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
