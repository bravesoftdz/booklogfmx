object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 213
  Width = 264
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Projects\BookLogFMX\BookLog-LocalDB\DB\BOOKLOG.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 40
    Top = 24
  end
  object FDQuery1: TFDQuery
    Active = True
    CachedUpdates = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM BOOK_LOG'
      'ORDER BY BOOK_SEQ')
    Left = 40
    Top = 88
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 120
    Top = 88
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 120
    Top = 144
  end
end
