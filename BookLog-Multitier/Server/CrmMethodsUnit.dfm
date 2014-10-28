object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 316
  Width = 353
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projects\BookLogFMX\BookLog-Multitier\Server\DB\CUST' +
        'MGR.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 40
  end
  object FDQuery1: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM CUST_MGR'
      'ORDER BY CUST_SEQ ASC')
    Left = 72
    Top = 128
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 184
    Top = 40
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = FDQuery1
    Left = 72
    Top = 216
  end
end
