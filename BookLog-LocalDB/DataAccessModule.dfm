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
    object FDQuery1BOOK_SEQ: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'BOOK_SEQ'
      Origin = 'BOOK_SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQuery1BOOK_TITLE: TWideStringField
      FieldName = 'BOOK_TITLE'
      Origin = 'BOOK_TITLE'
      Required = True
      Size = 200
    end
    object FDQuery1BOOK_AUTHOR: TWideStringField
      FieldName = 'BOOK_AUTHOR'
      Origin = 'BOOK_AUTHOR'
      Required = True
      Size = 120
    end
    object FDQuery1BOOK_PUBLISHER: TWideStringField
      FieldName = 'BOOK_PUBLISHER'
      Origin = 'BOOK_PUBLISHER'
      Size = 120
    end
    object FDQuery1BOOK_PHONE: TWideStringField
      FieldName = 'BOOK_PHONE'
      Origin = 'BOOK_PHONE'
      Size = 80
    end
    object FDQuery1BOOK_WEBSITE: TWideStringField
      FieldName = 'BOOK_WEBSITE'
      Origin = 'BOOK_WEBSITE'
      Size = 400
    end
    object FDQuery1BOOK_COMMENT: TWideStringField
      FieldName = 'BOOK_COMMENT'
      Origin = 'BOOK_COMMENT'
      Size = 4000
    end
    object FDQuery1BOOK_THUMB: TBlobField
      FieldName = 'BOOK_THUMB'
      Origin = 'BOOK_THUMB'
    end
    object FDQuery1BOOK_IMAGE: TBlobField
      FieldName = 'BOOK_IMAGE'
      Origin = 'BOOK_IMAGE'
    end
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
