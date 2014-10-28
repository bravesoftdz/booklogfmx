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
  FireDAC.Phys.IBBase, Data.DbxDatasnap, IPPeerClient, Data.DBXCommon,
  Datasnap.DBClient, Datasnap.DSConnect, Data.SqlExpr;

type
  TDataModule1 = class(TDataModule)
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
    function Connect(AHost, APort: string): Boolean; // 데이터베이스 연결
    procedure AppendMode; // 입력 모드로 변경
    procedure EditMode; // 수정 모드로 변경
    procedure SetImage(ABitmap: TBitmap); // 이미지저장(본문, 목록의 썸네일 이미지)
    procedure SaveItem; // 항목 저장(입력/수정)
    procedure CancelItem; // 입력/수정 모드 취소
    procedure DeleteItem; // 선택항목 삭제
    procedure Refresh;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  System.IOUtils, FMX.Types;

{ TDataModule1 }

// 입력/수정 모드 취소
procedure TDataModule1.CancelItem;
begin
//  if FDQuery1.UpdateStatus = TUpdateStatus.usInserted then
//    FDQuery1.Cancel;
  if ClientDataSet1.UpdateStatus = TUpdateStatus.usInserted then
    ClientDataSet1.Cancel;
end;

// 데이터베이스 연결
function TDataModule1.Connect(AHost, APort: string): Boolean;
begin
//  FDConnection1.Connected := True;
//  FDQuery1.Active := True;
  Result := False;
  try
    SQLConnection1.Params.Values['HostName'] := AHost;
    SQLConnection1.Params.Values['Port'] := APort;
    SQLConnection1.Connected := True;

    ClientDataSet1.Active := True;
    ClientDataSet1.Refresh;
    Result := True;
  except on E: Exception do
    Log.d(E.Message);
  end;
end;

// 현재항목 삭제
procedure TDataModule1.DeleteItem;
begin
  ClientDataSet1.Delete;
  ClientDataSet1.ApplyUpdates(0);
//  ClientDataSet1.CommitUpdates;
  ClientDataSet1.Refresh;
end;

// 수정모드
procedure TDataModule1.EditMode;
begin
//  FDQuery1.Edit;
  ClientDataSet1.Edit;
end;

procedure TDataModule1.Refresh;
begin
  ClientDataSet1.Refresh;
end;

// 입력모드
procedure TDataModule1.AppendMode;
begin
//  FDQuery1.Append;
  ClientDataSet1.Append;
end;

// 항목 저장
procedure TDataModule1.SaveItem;
begin
  // 입력 시  BOOK_SEQ 자동생성되지만 미 입력 시 오류
  if ClientDataSet1.UpdateStatus = TUpdateStatus.usInserted then
    ClientDataSet1.FieldByName('CUST_SEQ').AsInteger := 0;

  ClientDataSet1.Post;
  ClientDataSet1.ApplyUpdates(0);
//  ClientDataSet1.CommitUpdates;
  ClientDataSet1.Refresh;
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

    (ClientDataSet1.FieldByName('CUST_IMAGE') as TBlobField).LoadFromStream(ImgStream);
    (ClientDataSet1.FieldByName('CUST_THUMB') as TBlobField).LoadFromStream(ThumbStream);
  finally
    ImgStream.Free;
    ThumbStream.Free;
  end;
end;

end.
