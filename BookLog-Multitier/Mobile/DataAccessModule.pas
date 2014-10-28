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
    function Connect(AHost, APort: string): Boolean; // �����ͺ��̽� ����
    procedure AppendMode; // �Է� ���� ����
    procedure EditMode; // ���� ���� ����
    procedure SetImage(ABitmap: TBitmap); // �̹�������(����, ����� ����� �̹���)
    procedure SaveItem; // �׸� ����(�Է�/����)
    procedure CancelItem; // �Է�/���� ��� ���
    procedure DeleteItem; // �����׸� ����
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

// �Է�/���� ��� ���
procedure TDataModule1.CancelItem;
begin
//  if FDQuery1.UpdateStatus = TUpdateStatus.usInserted then
//    FDQuery1.Cancel;
  if ClientDataSet1.UpdateStatus = TUpdateStatus.usInserted then
    ClientDataSet1.Cancel;
end;

// �����ͺ��̽� ����
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

// �����׸� ����
procedure TDataModule1.DeleteItem;
begin
  ClientDataSet1.Delete;
  ClientDataSet1.ApplyUpdates(0);
//  ClientDataSet1.CommitUpdates;
  ClientDataSet1.Refresh;
end;

// �������
procedure TDataModule1.EditMode;
begin
//  FDQuery1.Edit;
  ClientDataSet1.Edit;
end;

procedure TDataModule1.Refresh;
begin
  ClientDataSet1.Refresh;
end;

// �Է¸��
procedure TDataModule1.AppendMode;
begin
//  FDQuery1.Append;
  ClientDataSet1.Append;
end;

// �׸� ����
procedure TDataModule1.SaveItem;
begin
  // �Է� ��  BOOK_SEQ �ڵ����������� �� �Է� �� ����
  if ClientDataSet1.UpdateStatus = TUpdateStatus.usInserted then
    ClientDataSet1.FieldByName('CUST_SEQ').AsInteger := 0;

  ClientDataSet1.Post;
  ClientDataSet1.ApplyUpdates(0);
//  ClientDataSet1.CommitUpdates;
  ClientDataSet1.Refresh;
end;

// �̹��� ����(�����̹����� ��Ͽ� ǥ���� �����)
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
