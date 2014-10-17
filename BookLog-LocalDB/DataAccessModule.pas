unit DataAccessModule;

interface

uses
  System.SysUtils, System.Classes, Data.Bind.Components, Data.Bind.ObjectScope,
  Fmx.Bind.GenData, Data.Bind.GenData, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.FMXUI.Wait;

type
  TdmDataAccess = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Connect;
    procedure NewItem;
    procedure SaveItem(AImage, AThumbnail: TStream);
    procedure CancelItem;
    procedure DeleteItem;
  end;

var
  dmDataAccess: TdmDataAccess;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  System.IOUtils, FMX.Types;

{ TdmDataAccess }

procedure TdmDataAccess.NewItem;
begin
  FDQuery1.Append;
end;

procedure TdmDataAccess.CancelItem;
begin
  if FDQuery1.UpdateStatus = TUpdateStatus.usInserted then
    FDQuery1.Cancel;
end;

procedure TdmDataAccess.Connect;
begin
{$IFNDEF MSWINDOWS}
  Log.d(TPath.Combine(TPath.GetDocumentsPath, 'BOOKLOG.GDB'));
  FDConnection1.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'BOOKLOG.GDB');
{$ENDIF}
  FDConnection1.Connected := True;
  FDQuery1.Active := True;
end;

procedure TdmDataAccess.DeleteItem;
begin
  // 추가 중(입력되지 않음)인 경우 취소
  if FDQuery1.UpdateStatus = TUpdateStatus.usInserted then
  begin
    FDQuery1.Cancel;
  end
  else if FDQuery1.UpdateStatus = TUpdateStatus.usUnmodified then
  begin
    FDQuery1.Delete;
    FDQuery1.ApplyUpdates(0);
    FDQuery1.CommitUpdates;
    FDQuery1.Refresh;
  end;
end;

procedure TdmDataAccess.FDConnection1BeforeConnect(Sender: TObject);
begin
{$IFNDEF MSWINDOWS}
  Log.d(TPath.Combine(TPath.GetDocumentsPath, 'BOOKLOG.GDB'));
  FDConnection1.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'BOOKLOG.GDB');
{$ENDIF}
end;

procedure TdmDataAccess.SaveItem(AImage, AThumbnail: TStream);
begin
  if FDQuery1.UpdateStatus = TUpdateStatus.usUnmodified then
    FDQuery1.Edit;

  // 입력 시  EMP_NO은 자동생성되지만 미 입력 시 오류
  if FDQuery1.UpdateStatus = TUpdateStatus.usInserted then
    FDQuery1.FieldByName('BOOK_SEQ').AsInteger := 0;

  // 이미지 스트림 적용
  (FDQuery1.FieldByName('BOOK_IMAGE') as TBlobField).LoadFromStream(AImage);
  (FDQuery1.FieldByName('BOOK_THUMB') as TBlobField).LoadFromStream(AThumbnail);
  FDQuery1.Post;
  FDQuery1.ApplyUpdates(0);
  FDQuery1.CommitUpdates;
  FDQuery1.Refresh;
end;

end.
