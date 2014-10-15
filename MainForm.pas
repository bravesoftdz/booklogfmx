unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.MultiView, FMX.ListView.Types, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  FMX.Effects, FMX.Objects, System.Actions, FMX.ActnList, FMX.TabControl,
  Data.Bind.Components, FMX.Controls.Presentation, FMX.Edit, FMX.ListView,
  FMX.Memo;

type
  TfrmMain = class(TForm)
    TabControl1: TTabControl;
    tabItemList: TTabItem;
    ToolBar1: TToolBar;
    Label1: TLabel;
    btnNewItem: TButton;
    lstBooks: TListView;
    tabItemDetail: TTabItem;
    ToolBar2: TToolBar;
    Label2: TLabel;
    btnBack: TButton;
    btnDetailModify: TButton;
    lytContentsDetail: TLayout;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    tabitemNew: TTabItem;
    ToolBar3: TToolBar;
    Label3: TLabel;
    btnNewCancel: TButton;
    btnNewSave: TButton;
    vsbEditFocus: TVertScrollBox;
    lytContentsNew: TLayout;
    Layout2: TLayout;
    Image2: TImage;
    ListBox2: TListBox;
    ListBoxItem5: TListBoxItem;
    edtTitle: TEdit;
    ListBoxItem6: TListBoxItem;
    edtAuthor: TEdit;
    ListBoxItem7: TListBoxItem;
    edtPublisher: TEdit;
    ListBoxItem8: TListBoxItem;
    edtWebSite: TEdit;
    BindingsList1: TBindingsList;
    ActionList1: TActionList;
    ChangeTabAction: TChangeTabAction;
    ListBoxItem9: TListBoxItem;
    lblComment: TLabel;
    Layout4: TLayout;
    Rectangle2: TRectangle;
    imgPhotoDetail: TImage;
    Layout5: TLayout;
    lblTitle: TLabel;
    lblAuthor: TLabel;
    ShadowEffect2: TShadowEffect;
    lblWebSite: TLabel;
    lblPhone: TLabel;
    lblPublisher: TLabel;
    ListBoxItem10: TListBoxItem;
    mmoComment: TMemo;
    LinkListControlToField1: TLinkListControlToField;
    LinkPropertyToFieldBitmap: TLinkPropertyToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    LinkControlToField1: TLinkControlToField;
    ListBoxItem4: TListBoxItem;
    edtPhone: TEdit;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    OverflowMenu: TListBox;
    ListBoxItem11: TListBoxItem;
    ListBoxItem12: TListBoxItem;
    ShadowEffect1: TShadowEffect;
    procedure btnNewItemClick(Sender: TObject);
    procedure lstBooksItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnBackClick(Sender: TObject);
    procedure btnNewCancelClick(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Image2Click(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDetailModifyClick(Sender: TObject);
    procedure ListBoxItem12Click(Sender: TObject);
    procedure ListBoxItem11Click(Sender: TObject);
    procedure lblPhoneClick(Sender: TObject);
    procedure lblWebSiteClick(Sender: TObject);
  private
    { Private declarations }

    // 입력컨트롤 화면에 보이도록 처리
    FKBBounds: TRectF;
    FNeedOffset: Boolean;

    procedure CalcContentBoundsProc(Sender: TObject;
                                    var ContentBounds: TRectF);
    procedure RestorePosition;
    procedure UpdateKBBounds;
    //////////////////////

    procedure InitControl;

    procedure GotoList;
    procedure GotoDetail;
    procedure GotoNew;

    procedure ChangeImageEvent(Image: TBitmap);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}
{$R *.iPhone4in.fmx IOS}

uses
  System.Math, FMX.Platform, FMX.PhoneDialer,
  DataAccessModule,
  PhotoFrame, WebBrowserFrame;

{ TfrmMain }

procedure TfrmMain.Image2Click(Sender: TObject);
begin
  TfrPhoto.CreateAndShow(Self, ChangeImageEvent, nil);
end;

procedure TfrmMain.InitControl;
begin
  vsbEditFocus.OnCalcContentBounds := CalcContentBoundsProc;

  TabControl1.TabPosition := TTabPosition.None;
  TabControl1.TabIndex := 0;

  OverflowMenu.Visible := False;
end;

procedure TfrmMain.lblPhoneClick(Sender: TObject);
var
  PhoneDlrSvc: IFMXPhoneDialerService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService, IInterface(PhoneDlrSvc)) then
    PhoneDlrSvc.Call(lblPhone.Text);
end;

procedure TfrmMain.lblWebSiteClick(Sender: TObject);
begin
  TfrWebBrowser.CreateAndShow(Self, lblWebSite.Text);
end;

procedure TfrmMain.ListBoxItem11Click(Sender: TObject);
begin
  OverflowMenu.Visible := False;
  GotoDetail;
end;

procedure TfrmMain.ListBoxItem12Click(Sender: TObject);
begin
  OverflowMenu.Visible := False;

  MessageDlg('등록한 정보를 삭제하시겠습니까?', TMsgDlgType.mtWarning,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
      begin
        ShowMessage('Say yes');
      end;
    end);

  // 삭제 처리
end;

procedure TfrmMain.lstBooksItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  GotoDetail;
end;

procedure TfrmMain.btnBackClick(Sender: TObject);
begin
  GotoList;
end;

procedure TfrmMain.btnDetailModifyClick(Sender: TObject);
  function CalcOverflowMenuHeight: Single;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to OverflowMenu.Count - 1 do
      Result := Result + OverflowMenu.ListItems[I].Height;
  end;
begin
  OverflowMenu.Visible := not OverflowMenu.Visible;
  if OverflowMenu.Visible then
  begin
    OverflowMenu.ItemIndex := -1;
    OverflowMenu.BringToFront;
    OverflowMenu.ApplyStyleLookup;
    OverflowMenu.RealignContent;
    OverflowMenu.Height := CalcOverflowMenuHeight;
  end;
end;

procedure TfrmMain.btnNewCancelClick(Sender: TObject);
begin
  GotoList;
end;

procedure TfrmMain.ChangeImageEvent(Image: TBitmap);
begin
  Image2.Bitmap.Assign(Image);
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if Assigned(frPhoto) then
    begin
      frPhoto.CloseFrame;
      Key := 0;
    end;

    if Assigned(frWebBrowser) then
    begin
      frWebBrowser.CloseFrame;
      Key := 0;
    end;
  end;
end;

procedure TfrmMain.btnNewItemClick(Sender: TObject);
begin
  GotoNew;
end;

{$REGION '입력컨트롤 화면에 보이도록 처리'}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  InitControl;
end;

procedure TfrmMain.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;

procedure TfrmMain.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TfrmMain.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TfrmMain.CalcContentBoundsProc(Sender: TObject;
  var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
                                2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TfrmMain.RestorePosition;
begin
  vsbEditFocus.ViewportPosition := PointF(vsbEditFocus.ViewportPosition.X, 0);
  lytContentsNew.Align := TAlignLayout.Client;
  vsbEditFocus.RealignContent;
end;

procedure TfrmMain.UpdateKBBounds;
var
  LFocused : TControl;
  LFocusRect: TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);

    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(vsbEditFocus.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
       (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
      lytContentsNew.Align := TAlignLayout.Horizontal;
      vsbEditFocus.RealignContent;
      Application.ProcessMessages;
      vsbEditFocus.ViewportPosition := PointF(vsbEditFocus.ViewportPosition.X,
                                              LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;
  if not FNeedOffset then
    RestorePosition;
end;
{$ENDREGION}

procedure TfrmMain.GotoList;
begin
  ChangeTabAction.Tab := tabItemList;
  ChangeTabAction.ExecuteTarget(nil);
end;

procedure TfrmMain.GotoDetail;
begin
  ChangeTabAction.Tab := tabItemDetail;
  ChangeTabAction.ExecuteTarget(nil);
end;

procedure TfrmMain.GotoNew;
begin
  TabControl1.ActiveTab := tabitemNew;
end;

end.
