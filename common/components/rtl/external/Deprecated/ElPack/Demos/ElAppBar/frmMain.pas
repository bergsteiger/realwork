unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ElACtrls, ElSpin, ExtCtrls, ElPanel, ElClock, ElBtnCtl,
  ElPopBtn, ElAppBar, Menus, ElToolBar, ElXPThemedControl, ToolWin,
  ComCtrls;

type
  TfrmBar = class(TForm)
    LeftImage: TImage;
    TopImage: TImage;
    PopupMenu1: TPopupMenu;
    miExit: TMenuItem;
    ToolBar: TToolBar;
    AppBar: TElAppBar;
    Timer1: TTimer;
    btnOptions: TToolButton;
    btnTime: TToolButton;
    procedure miExitClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AppBarEdgeChanged(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToolBarResize(Sender: TObject);
  protected
    procedure SetWindowSize;
    procedure WMNcHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
  end;

var
  frmBar: TfrmBar;

implementation

uses frmOpts;

{$R *.DFM}

procedure TfrmBar.WMNcHitTest(var Msg : TWMNCHitTest); 
var p : TPoint;
begin
  inherited;
  p := ScreenToClient(SmallPointToPoint(Msg.Pos));
  if PtInRect(LeftImage.BoundsRect, p) or PtInRect(TopImage.BoundsRect, p) then
  Msg.result := HTCaption;
end;

procedure TfrmBar.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBar.btnOptionsClick(Sender: TObject);
var aEdges : TAppBarFlags;
begin
  with OptionsForm, AppBar do
  begin
    LeftCB.Enabled   := Edge <> abeLeft;
    LeftCB.checked   := abfAllowLeft in Flags;

    RightCB.Enabled  := Edge <> abeRight;
    RightCB.checked  := abfAllowRight in Flags;

    TopCB.Enabled    := Edge <> abeTop;
    TopCB.checked    := abfAllowTop in Flags;

    BottomCB.Enabled := Edge <> abeBottom;
    BottomCB.Checked := abfAllowBottom in Flags;

    FloatingCB.Enabled := Edge <> abeFloat;
    FloatingCB.Checked := abfAllowFloat in Flags;

    KeepSizeCB.Checked := KeepSize;
    AutohideCB.Checked := AutoHide;
    TopmostCB.Checked  := AlwaysOnTop;
    OnScreenCB.Checked := PreventOffScreen;
    TaskBarCB.Checked  := TaskEntry <> abtHide;
  end;
  if OptionsForm.ShowModal = mrOk then
  with OptionsForm do
  begin
    aEdges := [];

    if LeftCB.Checked then include(aEdges, abfAllowLeft);
    if RightCB.Checked then include(aEdges, abfAllowRight);
    if TopCB.Checked then include(aEdges, abfAllowTop);
    if BottomCB.Checked then include(aEdges, abfAllowBottom);
    if FloatingCB.Checked then include(aEdges, abfAllowFloat);

    AppBar.Flags := aEdges;
    AppBar.KeepSize := KeepSizeCB.Checked;
    AppBar.AutoHide := AutohideCB.Checked;
    AppBar.AlwaysOnTop := TopmostCB.Checked;
    AppBar.PreventOffScreen := OnScreenCB.Checked;
    if TaskBarCB.Checked then
      AppBar.TaskEntry := abtShow
    else
      AppBar.TaskEntry := abtHide;
  end;
end;

procedure TfrmBar.FormCreate(Sender: TObject);
var r : TRect;
    hb, vb : integer;
begin
  hb := Width - ClientWidth;
  vb := Height - ClientHeight;
  btnTime.Caption := TimeToStr(Now);
  r.Left := Toolbar.ButtonWidth + hb;
  r.Right := Toolbar.ButtonWidth + hb;
  r.Top := Toolbar.ButtonHeight + vb;
  r.Bottom := Toolbar.ButtonHeight + vb;
  AppBar.DockDims := r;
end;

procedure TfrmBar.AppBarEdgeChanged(Sender: TObject);
begin
  SetWindowSize;
end;

procedure TfrmBar.Timer1Timer(Sender: TObject);
begin
  btnTime.Caption := TimeToStr(Now);
end;

procedure TfrmBar.SetWindowSize;
begin
  if AppBar.Edge in [abeLeft, abeRight] then
  begin
    if not AppBar.KeepSize then
    begin
      LeftImage.Visible := false;
      TopImage.Visible := true;
    end;
    Toolbar.Align := alClient;
  end
  else
  if AppBar.Edge in [abeTop, abeBottom] then
  begin
    LeftImage.Visible := true;
    TopImage.Visible := false;
  end
  else
  begin
    if not AppBar.KeepSize then
    begin
      LeftImage.Visible := true;
      TopImage.Visible := false;
    end;
  end;
end;

procedure TfrmBar.ToolBarResize(Sender: TObject);
begin
  SetWindowSize;
end;

end.

