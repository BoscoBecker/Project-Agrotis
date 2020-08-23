object dmCadPedidoItem: TdmCadPedidoItem
  OldCreateOrder = False
  Height = 286
  Width = 228
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
      'UPDATE PEDIDO '
      
        'SET total_pedido = ((SELECT ISNULL(SUM(TOTAL_ITEM),0) FROM PEDID' +
        'O_ITEM WHERE CODIGO_PEDIDO =:CODIGO_PEDIDO))'
      'WHERE codigo =:CODIGO_PEDIDO')
    ParamData = <
      item
        Name = 'CODIGO_PEDIDO'
        ParamType = ptInput
      end>
    Left = 104
    Top = 192
  end
end
