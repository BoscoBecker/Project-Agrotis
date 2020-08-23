object dmCadPedidoItem: TdmCadPedidoItem
  OldCreateOrder = False
  Height = 221
  Width = 368
  object FDQueryItemPedido: TFDQuery
    Left = 104
    Top = 136
  end
  object FDQueryItemPedidoProduto: TFDQuery
    Connection = dmConexao.connectionSSMS
    Left = 104
    Top = 32
  end
  object FDQueryItemPedidoPedido: TFDQuery
    Left = 104
    Top = 80
  end
  object FDCommandAtualizaTotalPedido: TFDCommand
    CommandText.Strings = (
      'UPDATE PEDIDO'
      'SET total_pedido = (total_pedido + :VALOR_PEDIDO)'
      'WHERE codigo  =:CODIGO')
    ParamData = <
      item
        Name = 'VALOR_PEDIDO'
        ParamType = ptInput
      end
      item
        Name = 'CODIGO'
        ParamType = ptInput
      end>
    Left = 240
    Top = 56
  end
  object FDCommandDeletaTotalPedido: TFDCommand
    CommandText.Strings = (
      'UPDATE PEDIDO'
      'SET total_pedido = (total_pedido - :VALOR_PEDIDO)'
      'WHERE codigo  =:CODIGO')
    ParamData = <
      item
        Name = 'VALOR_PEDIDO'
        ParamType = ptInput
      end
      item
        Name = 'CODIGO'
        ParamType = ptInput
      end>
    Left = 240
    Top = 112
  end
end
