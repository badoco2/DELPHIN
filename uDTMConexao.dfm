object DTMPrincipal: TDTMPrincipal
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Connected = True
    SQLHourGlass = True
    HostName = '.\SERVECURSO'
    Port = 0
    Database = 'VENDAS'
    User = 'sa'
    Password = 'aeade'
    Protocol = 'mssql'
    LibraryLocation = 
      'C:\Users\alexa\Documents\Delphin\VendasSistema\DELPHIN\ntwdblib.' +
      'dll'
    Left = 80
    Top = 64
  end
end
