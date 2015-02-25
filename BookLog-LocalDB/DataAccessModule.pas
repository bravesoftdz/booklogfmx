unit DataAccessModule;

interface

uses
  System.SysUtils, System.Classes, Fmx.Bind.GenData, Data.Bind.GenData,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Graphics, FireDAC.FMXUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDQuery1BOOK_SEQ: TIntegerField;
    FDQuery1BOOK_TITLE: TWideStringField;
    FDQuery1BOOK_AUTHOR: TWideStringField;
    FDQuery1BOOK_PUBLISHER: TWideStringField;
    FDQuery1BOOK_PHONE: TWideStringField;
    FDQuery1BOOK_WEBSITE: TWideStringField;
    FDQuery1BOOK_COMMENT: TWideStringField;
    FDQuery1BOOK_THUMB: TBlobField;
    FDQuery1BOOK_IMAGE: TBlobField;
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InsertMode; // 입력 모드로 변경
    procedure EditMode; // 수정 모드로 변경
    procedure SaveItem; // 항목 저장(입력/수정)
    procedure CancelItem; // 입력/수정 모드 취소
    procedure DeleteItem; // 선택항목 삭제
    procedure SetImage(ABitmap: TBitmap); // 이미지저장(본문, 목록의 썸네일 이미지)
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  System.IOUtils;

{ TDataModule1 }

// 입력모드
procedure TDataModule1.InsertMode;
begin
  FDQuery1.Append;
  FDQuery1.FieldByName('BOOK_SEQ').AsInteger := 0;
end;

// 수정모드
procedure TDataModule1.EditMode;
begin
  FDQuery1.Edit;
end;

procedure TDataModule1.FDConnection1BeforeConnect(Sender: TObject);
begin
// 윈도우가 아닌 경우 데이터베이스 경로를 배포경로로 조정
{$IFNDEF MSWINDOWS}
  FDConnection1.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'BOOKLOG.GDB');
{$ENDIF}
end;

// 항목 저장
procedure TDataModule1.SaveItem;
begin
  FDQuery1.Post;
  FDQuery1.ApplyUpdates(0);
  FDQuery1.CommitUpdates;
  FDQuery1.Refresh;
end;

// 입력/수정 모드 취소
procedure TDataModule1.CancelItem;
begin
  if FDQuery1.UpdateStatus = TUpdateStatus.usInserted then
    FDQuery1.Cancel;
end;

// 현재항목 삭제
procedure TDataModule1.DeleteItem;
begin
  FDQuery1.Delete;
  FDQuery1.ApplyUpdates(0);
  FDQuery1.CommitUpdates;
  FDQuery1.Refresh;
end;

// 이미지 저장(본문이미지와 목록에 표시할 썸네일)
procedure TDataModule1.SetImage(ABitmap: TBitmap);
var
  Thumbnail: TBitmap;
  ImgStream, ThumbStream: TMemoryStream;
begin
  ImgStream := TMemoryStream.Create;
  ThumbStream := TMemoryStream.Create;
  try
    ABitmap.SaveToStream(ImgStream);
    Thumbnail := ABitmap.CreateThumbnail(100, 100);
    Thumbnail.SaveToStream(ThumbStream);

    (FDQuery1.FieldByName('BOOK_IMAGE') as TBlobField).LoadFromStream(ImgStream);
    (FDQuery1.FieldByName('BOOK_THUMB') as TBlobField).LoadFromStream(ThumbStream);
  finally
    ImgStream.Free;
    ThumbStream.Free;
  end;
end;

end.
