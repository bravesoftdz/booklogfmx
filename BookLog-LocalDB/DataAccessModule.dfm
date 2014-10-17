object dmDataAccess: TdmDataAccess
  OldCreateOrder = False
  Height = 340
  Width = 256
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Projects\BookLogFMX\DB\BOOKLOG.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 40
    Top = 40
  end
  object FDQuery1: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM BOOK_LOG')
    Left = 40
    Top = 112
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 136
    Top = 40
  end
end
