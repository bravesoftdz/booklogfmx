{
  작성자 : 김현수(Humphery, Kim / http://blog.hfj.pe.kr / hjfactory@gmail.com)
  소스설명 : http://blog.hjf.pe.kr/255
  원소스 : https://github.com/hjfactory/booklogfmx
}
unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView, FMX.StdCtrls, FMX.TabControl, FMX.Memo,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Effects, FMX.ListBox,
  FMX.Layouts, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, System.Actions,
  FMX.ActnList;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Button1: TButton;
    ListView1: TListView;
    ToolBar2: TToolBar;
    Label2: TLabel;
    Button2: TButton;
    Button3: TButton;
    Layout1: TLayout;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    Image1: TImage;
    Layout2: TLayout;
    lblTitle: TLabel;
    lblAuthor: TLabel;
    lblPublisher: TLabel;
    lblPhone: TLabel;
    lblWebSite: TLabel;
    lblComment: TLabel;
    ToolBar3: TToolBar;
    Label3: TLabel;
    Button4: TButton;
    Button5: TButton;
    lytContentsNew: TLayout;
    Layout4: TLayout;
    imgNewItem: TImage;
    ListBox2: TListBox;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    ListBoxItem9: TListBoxItem;
    ListBoxItem10: TListBoxItem;
    ListBoxItem11: TListBoxItem;
    ListBoxItem12: TListBoxItem;
    edtTitle: TEdit;
    edtAuthor: TEdit;
    edtPublisher: TEdit;
    edtPhone: TEdit;
    edtWebSite: TEdit;
    mmoComment: TMemo;
    vsbEditFocus: TVertScrollBox;
    OverflowMenu: TListBox;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LinkPropertyToFieldBitmap: TLinkPropertyToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    LinkPropertyToFieldText7: TLinkPropertyToField;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    LinkPropertyToFieldBitmap2: TLinkPropertyToField;
    ShadowEffect2: TShadowEffect;
    Rectangle2: TRectangle;
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBoxItem5Click(Sender: TObject);
    procedure ListBoxItem6Click(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure lblWebSiteClick(Sender: TObject);
    procedure imgNewItemClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    FKBBounds: TRectF;
    FNeedOffset: Boolean;

    procedure CalcContentBoundsProc(Sender: TObject;
                                    var ContentBounds: TRectF);
    procedure RestorePosition;
    procedure UpdateKBBounds;

    procedure GotoList;
    procedure GotoDetail;
    procedure GotoNew;

    procedure ChangeImageEvent(Image: TBitmap);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses DataAccessModule, System.Math, WebBrowserFrame, PhotoFrame;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  GotoNew;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  GotoList;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  OverflowMenu.Visible := not OverflowMenu.Visible;
  if OverflowMenu.Visible then
  begin
    OverflowMenu.ItemIndex := -1;
    OverflowMenu.BringToFront;
    OverflowMenu.ApplyStyleLookup;
    OverflowMenu.RealignContent;
    OverflowMenu.Position.X := Width - OverflowMenu.Width - 5;
    OverflowMenu.Position.Y := Toolbar2.Height;
  end;
end;

// 수정
procedure TForm1.ListBoxItem5Click(Sender: TObject);
begin
  OverflowMenu.Visible := False;
  GotoNew;
end;

// 삭제
procedure TForm1.ListBoxItem6Click(Sender: TObject);
begin
  OverflowMenu.Visible := False;

  MessageDlg('해당 정보를 삭제하시겠습니까?', TMsgDlgType.mtWarning,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
      begin
        ShowMessage('Say yes');
      end;
    end);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  GotoList;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  GotoList;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TabControl1.TabPosition := TTabPosition.None;
  TabControl1.TabIndex := 0;

  OverflowMenu.Visible := False;

  vsbEditFocus.OnCalcContentBounds := CalcContentBoundsProc;
end;

procedure TForm1.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
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

procedure TForm1.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TForm1.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TForm1.GotoDetail;
begin
  ChangeTabAction1.Tab := TabItem2;
  ChangeTabAction1.ExecuteTarget(nil);
end;

procedure TForm1.GotoList;
begin
  ChangeTabAction1.Tab := TabItem1;
  ChangeTabAction1.ExecuteTarget(nil);
end;

procedure TForm1.GotoNew;
begin
  ChangeTabAction1.Tab := TabItem3;
  ChangeTabAction1.ExecuteTarget(nil);
end;

procedure TForm1.imgNewItemClick(Sender: TObject);
begin
  TfrPhoto.CreateAndShow(Self, ChangeImageEvent, nil);
end;

procedure TForm1.lblWebSiteClick(Sender: TObject);
begin
  TfrWebBrowser.CreateAndShow(Self, lblWebSite.Text);
end;

procedure TForm1.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  GotoDetail;
end;

procedure TForm1.CalcContentBoundsProc(Sender: TObject;
  var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(
          ContentBounds.Bottom, 2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TForm1.ChangeImageEvent(Image: TBitmap);
begin
  imgNewItem.Bitmap.Assign(Image);
end;

procedure TForm1.RestorePosition;
begin
  vsbEditFocus.ViewportPosition := PointF(vsbEditFocus.ViewportPosition.X, 0);
  lytContentsNew.Align := TAlignLayout.Client;
  vsbEditFocus.RealignContent;
end;

procedure TForm1.UpdateKBBounds;
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

end.
