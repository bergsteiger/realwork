{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

(*

Version History

12/15/2002

  Added Font property

08/23/2002

  Added optional Close button

05/15/2002

  Added InfoForm property to access the info form when it is shown.
  This can be used to set custom window region for the form

12/02/2001

  Added Color property

10/01/2001

  OnLinkClick event added

03/02/2001

  Fixed horizontal positioning of the window when taskbar is attached
  to left or right sides

11/19/2000

  Fixed the problem with info window causing AV when invoked from or after
  CloseQuery of the main window.

10/22/2000

  Support for HTML added.

*)
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

{.$define ELPACK_SINGLE_COMP}

unit ElTrayInfo;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Forms,
  ElTools,
  ElVCLUtils,
  ElHTMLLbl,
  ElTopmost,
{$ifdef VCL_6_USED}
Types,
{$endif}
  ElStrUtils,
  HTMLRender,
  {$ifndef ELPACK_SINGLECOMP}
  ElPopBtn,
  ElTmSchema,
  {$else}
  Buttons,
  {$endif}
  StdCtrls,
  Graphics,
  ExtCtrls,
  ElCLabel,
  ElGlyphs;

type
  TElTrayInfoType = (titInformation, titWarning, titError);

type
  TTrayInfoForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Timer: TTimer;
    InfoLabel: TElHTMLLabel;
    procedure TimerTimer(Sender: TObject);
    procedure ClickHandler(Sender: TObject);
    procedure DblClickHandler(Sender: TObject);
    procedure ShowHandler(Sender: TObject);
    procedure HideHandler(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure WMMouseActivate(var Msg: TMessage); message WM_MOUSEACTIVATE;
  protected
    FOnShow,
    FOnHide,
    FOnClick,
    FOnDblClick : TNotifyEvent;
    {$ifndef ELPACK_SINGLE_COMP}
    FCloseBtn : TElGraphicButton;
    {$else}
    FCloseBtn : TSpeedButton;
    {$endif}
    FTopmost : TElTopmost;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CloseBtnClick(Sender : TObject);
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
  end;

  TElTrayInfo = class(TComponent)
  private
    FIsHTML : Boolean;
    FInfoForm : TTrayInfoForm;
    FShowTime : Cardinal;
    FInfoType : TElTrayInfoType;
    FMessage  : TElFString;
    FColor    : TColor;
    FShowCloseButton : boolean;
    FOnImageNeeded : TElHTMLImageNeededEvent;
    FOnLinkClick   : TElHTMLLinkClickEvent;
    FOnShow,
    FOnHide,
    FOnClick,
    FOnDblClick : TNotifyEvent;
  protected
    FFont: TFont;
    FParentFont: Boolean;
    procedure SetShowTime(newValue : Cardinal); virtual;
    procedure SetInfoType(newValue : TElTrayInfoType); virtual;
    procedure SetMessage(newValue: TElFString); virtual;
    procedure AdjustFormIcon;
    procedure AdjustFormSize(X, Y : integer);
    function SuggestedHeight : integer;
    function SuggestedWidth : integer;
    procedure SetIsHTML(newValue : Boolean); virtual;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure ClickHandler(Sender: TObject);
    procedure DblClickHandler(Sender: TObject);
    procedure ShowHandler(Sender: TObject);
    procedure HideHandler(Sender: TObject);
    procedure SetColor(Value : TColor);
    procedure SetFont(Value: TFont);
    procedure FontChange(Sender : TObject);
    procedure SetParentFont(Value: Boolean);
  public
    procedure Show;
    procedure Hide;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure ShowEx(X, Y : integer; AdjustY : boolean);
    property InfoForm : TTrayInfoForm read FInfoForm;
  published
    property Color : TColor read FColor write SetColor default clInfoBk;
    property ShowTime : Cardinal read FShowTime write SetShowTime;  { Published }
    property InfoType : TElTrayInfoType read FInfoType write SetInfoType;  { Published }
    property Message: TElFString read FMessage write SetMessage;
    property IsHTML   : Boolean read FIsHTML write SetIsHTML default false;  { Published }
    property ShowCloseButton : boolean read FShowCloseButton write FShowCloseButton;

    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnLinkClick   : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnShow : TNotifyEvent read FOnShow write FOnShow;
    property OnHide : TNotifyEvent read FOnHide write FOnHide;
    property OnClick : TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick : TNotifyEvent read FOnDblClick write FOnDblClick;
    property Font: TFont read FFont write SetFont;
    property ParentFont: Boolean read FParentFont write SetParentFont default true;
  end;

  TTrayInfoFormClass = class of TTrayInfoForm;

{$ifndef VCL_6_USED}
const
{$else}
var
{$endif}
  TrayInfoFormClass: TTrayInfoFormClass = TTrayInfoForm;

implementation

{$R TrayInfo.res}

{$ifndef ELPACK_SINGLE_COMP}
type

  TElTrayInfoCloseButton = class(TElGraphicButton)
  protected
    function GetThemePartID: Integer; override;
    function GetThemeStateID: Integer; override;
    function GetThemedClassName: WideString; override;
  end;

function TElTrayInfoCloseButton.GetThemePartID: Integer;
begin
  result := WP_CLOSEBUTTON;
end;

function TElTrayInfoCloseButton.GetThemeStateID: Integer;
begin
  //case Self.FButtonType of
  //  ebtButton:
      begin
        if not Enabled then
          result := CBS_DISABLED
        else
        if FState in [ebsDown, ebsExclusive] then
          result := CBS_PUSHED
        else
        if FMouseInControl or FMouseInArrow or FInMenu then
          result := CBS_HOT
        else
          result := CBS_NORMAL;
      end;
  //end;
end;

function TElTrayInfoCloseButton.GetThemedClassName: WideString;
begin
  Result := 'WINDOW';
end;
{$endif}

constructor TElTrayInfo.Create(AOwner : TComponent);
begin
  inherited;
  FFont := Tfont.Create;
  FFont.OnChange := Fontchange;
  ParentFont := true;
  FColor := clInfoBk;
  if FInfoForm <> nil then
    FInfoForm.Panel1.Color := FColor;
end;

procedure TElTrayInfo.SetColor(Value : TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if FInfoForm <> nil then
      FInfoForm.Panel1.Color := FColor;
  end;
end;

procedure TElTrayInfo.SetShowTime(newValue : Cardinal);
{ Sets data member FShowTime to newValue. }
begin
  if (FShowTime <> newValue) then
  begin
    FShowTime := newValue;
  end;  { if }
end;  { SetShowTime }

procedure TElTrayInfo.SetInfoType(newValue : TElTrayInfoType);
{ Sets data member FInfoType to newValue. }
begin
  if (FInfoType <> newValue) then
  begin
    FInfoType := newValue;
    if (FInfoForm <> nil) and (FInfoForm.Visible) then Show;
  end;  { if }
end;  { SetInfoType }

procedure TElTrayInfo.SetMessage(newValue: TElFString);
{ Sets data member FMessage to newValue. }
begin
  if (FMessage <> newValue) then
  begin
    FMessage := newValue;
    if (FInfoForm <> nil) and (FInfoForm.Visible) then Show;
  end;  { if }
end;  { SetMessage }

var AppWndProc : Pointer;

function NoActWndProc(Window: HWND; Message, WParam: Longint;
                    LParam: Longint): Longint; stdcall;
begin
  if (Message = WM_ACTIVATEAPP) and (wParam = 1) then
  begin
    result := 0;
  end
  else
  if (Message = WM_WINDOWPOSCHANGING) then
  begin
    PWindowPos(lParam)^.flags := PWindowPos(lParam)^.flags and (not SWP_SHOWWINDOW);
    result := 0;
  end
  else
    result := CallWindowProc(AppWndProc, Window, Message, wParam, lParam);
end;

procedure HookAppl;
begin
  AppWndProc := Pointer(GetWindowLong(Application.Handle, GWL_WNDPROC));
  SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(@NoActWndProc));
end;

procedure UnHookAppl;
begin
  SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(AppWndProc));
end;

procedure TElTrayInfo.Show;  { public }
var X,
    Y : integer;
    H1,
    H2 : HWND;
    R,
    R1 : TRect;
    TBarAlign : TTaskBarEdge;
    DesktopWidth,
    DesktopHeight : integer;
begin
  if FInfoForm = nil then
  begin
     FInfoForm := TTrayInfoForm.Create(Application);
     FInfoForm.InfoLabel.OnImageNeeded := FOnImageNeeded;
     FInfoForm.InfoLabel.OnLinkClick := FOnLinkClick;

     FInfoForm.Panel1.Color := FColor;
     FInfoForm.FOnClick := ClickHandler;
     FInfoForm.FOnDblClick := DblClickHandler;
     FInfoForm.FOnShow := ShowHandler;
     FInfoForm.FOnHide := HideHandler;
     FInfoForm.FreeNotification(Self);
  end
  else
    if FInfoForm.Visible then
      FInfoForm.Hide;
  FInfoForm.InfoLabel.IsHTML := IsHTML;
  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
  begin
    H2 := FindWindowEx(H1, 0, 'TrayNotifyWnd', nil);
    if H2 <> 0 then
    begin
      R := GetWorkspaceRect;
      DesktopWidth  := R.Right;
      DesktopHeight := R.Bottom;

      GetWindowRect(H1, R1);
      GetWindowRect(H2, R);
      TBarAlign := GetTaskBarEdge;

      FInfoForm.InfoLabel.Caption := FMessage;

      case TBarAlign of
        tbeBottom: begin
             Y := R1.Top - SuggestedHeight;
             X := DesktopWidth - SuggestedWidth;
           end;
        tbeLeft: begin
             X := R1.Right;
             Y := DesktopHeight - SuggestedHeight;
           end;
        tbeTop: begin
             Y := R1.Bottom;
             X := DesktopWidth - SuggestedWidth;
           end;
        tbeRight: begin
             X := R1.Left - SuggestedWidth;
             Y := DesktopHeight - SuggestedHeight;
           end;
        else
           begin
             Y := R1.Top - SuggestedHeight;
             X := DesktopWidth - SuggestedWidth;
           end;
      end;
      ShowEx(X, Y, false);
    end;
  end;
end;  { Show }

procedure TElTrayInfo.Hide;  { public }
begin
  if FInfoForm <> nil then FInfoForm.Hide;
end;  { Hide }

procedure TElTrayInfo.AdjustFormIcon;  { protected }
var s : string;
begin
  case FInfoType of
    titInformation: s := 'HINTICONINFO';
    titWarning:     s := 'HINTICONWARNING';
    titError:       s := 'HINTICONERROR';
  end;
  if FInfoForm <> nil then
    FInfoForm.Image1.Picture.Bitmap.LoadFromResourceName(HInstance, s);
end;  { AdjustFormIcon }

function TElTrayInfo.SuggestedHeight : integer;
begin
  result := Max(20 + (FInfoForm.Panel1.Height - FInfoForm.Panel1.ClientHeight), (FInfoForm.Panel1.Height - FInfoForm.Panel1.ClientHeight) + FInfoForm.InfoLabel.Height + 4);
end;

function TElTrayInfo.SuggestedWidth : integer;
begin
  result := (FInfoForm.Panel1.Width - FInfoForm.Panel1.ClientWidth) + 38 + FInfoForm.InfoLabel.Width;
  if ShowCloseButton then
    inc(result, 20);
end;

procedure TElTrayInfo.AdjustFormSize(X, Y : integer);  { protected }
var R : TRect;
    DesktopWidth,
    DesktopHeight  : integer;
begin
  if FInfoForm <> nil then
  begin
    R := GetWorkspaceRect;
    DesktopWidth  := R.Right;
    DesktopHeight := R.Bottom;

    R.Left := X;
    R.Top  := Y;
    R.Right := SuggestedWidth;
    R.Bottom := SuggestedHeight;

    if R.Left + R.Right > DesktopWidth then
                R.Left := DesktopWidth - R.Right;
    if R.Top + R.Bottom > DesktopHeight then
                R.Top := DesktopHeight - R.Bottom;

    with R do FInfoForm.SetBounds(Left, Top, Right, Bottom);
  end;
end;  { AdjustFormSize }

procedure TElTrayInfo.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FInfoForm) then
  begin
    FInfoForm.FOnClick := nil;
    FInfoForm.FOnDblClick := nil;
    FInfoForm.FOnShow := nil;
    FInfoForm.FOnHide := nil;

    FInfoForm := nil;
  end;
end;

procedure TElTrayInfo.SetIsHTML(newValue : Boolean);
{ Sets data member FIsHTML to newValue. }
begin
  if (FIsHTML <> newValue) then
  begin
    FIsHTML := newValue;
    if FInfoForm <> nil then
       FInfoForm.InfoLabel.IsHTML := newValue;
  end;  { if }
end;  { SetIsHTML }

procedure TElTrayInfo.ShowHandler(Sender: TObject);
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

procedure TElTrayInfo.HideHandler(Sender: TObject);
begin
  if Assigned(FOnHide) then FOnHide(Self);
end;

procedure TElTrayInfo.ClickHandler(Sender: TObject);
begin
  if assigned(FOnClick) then FOnClick(Self);
end;

procedure TElTrayInfo.DblClickHandler(Sender: TObject);
begin
  if assigned(FOnDblClick) then FOnDblClick(Self);
end;

destructor TElTrayInfo.Destroy;  { public }
begin
  if (FInfoForm <> nil) and (not (csDestroying in ComponentState)) then
  begin
    FInfoForm.Hide;
    FInfoForm.Free;
    FInfoForm := nil;
  end;
  inherited;
  FFont.Free;
end;  { Destroy }

procedure TElTrayInfo.ShowEx(X, Y : integer; AdjustY : boolean);
var cX,
    cY : integer;
    H1,
    H2 : HWND;
    R,
    R1 : TRect;
    TBarAlign : TTaskBarEdge;
    DesktopWidth,
    DesktopHeight : integer;
    i : integer;
begin
  if FInfoForm = nil then
  begin
     FInfoForm := TTrayInfoForm.Create(Application);
     FInfoForm.InfoLabel.OnImageNeeded := FOnImageNeeded;
     FInfoForm.InfoLabel.OnLinkClick := FOnLinkClick;

     FInfoForm.Panel1.Color := FColor;
     FInfoForm.FOnClick := ClickHandler;
     FInfoForm.FOnDblClick := DblClickHandler;
     FInfoForm.FOnShow := ShowHandler;
     FInfoForm.FOnHide := HideHandler;
     FInfoForm.FreeNotification(Self);
  end
  else
    if FInfoForm.Visible then
      FInfoForm.Hide;

  FInfoForm.InfoLabel.Font := FFont;
  FInfoForm.InfoLabel.IsHTML := IsHTML;
  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
  begin
    H2 := FindWindowEx(H1, 0, 'TrayNotifyWnd', nil);
    if H2 <> 0 then
    begin
      R := GetWorkspaceRect;
      DesktopWidth  := R.Right;
      DesktopHeight := R.Bottom;

      GetWindowRect(H1, R1);
      GetWindowRect(H2, R);
      TBarAlign := GetTaskBarEdge;

      FInfoForm.InfoLabel.Caption := FMessage;

      case TBarAlign of
        tbeBottom:
          begin
            if AdjustY then
              Dec(Y, SuggestedHeight);
            cy := SuggestedHeight;
            if Y + cy > DesktopHeight then
              Y := DesktopHeight - cy;
            cx := SuggestedWidth;
            if X + cx > DesktopWidth then
              X := DesktopWidth - CX;
          end;
        tbeLeft:
          begin
            cx := SuggestedWidth;
            if X + cx > DesktopWidth then
              X := DesktopWidth - CX;
            cy := SuggestedHeight;
            if Y + cy > DesktopHeight then
              Y := DesktopHeight - cy;
          end;
        tbeTop:
          begin
            if AdjustY then
              Dec(Y, SuggestedHeight);
            cy := SuggestedHeight;
            if Y + cy < 0 then
              Y := 0;
            cx := SuggestedWidth;
            if X + cx > DesktopWidth then
              X := DesktopWidth - CX;
          end;
        tbeRight:
          begin
            cx := SuggestedWidth;
            if X + cx > DesktopWidth then
              X := DesktopWidth - CX;
            cy := SuggestedHeight;
            if Y + cy > DesktopHeight then
              Y := DesktopHeight - cy;
          end;
        else
          begin
            Y := R1.Top - SuggestedHeight;
            X := DesktopWidth - SuggestedWidth;
          end;
      end;

      FInfoForm.Timer.Enabled  := false;
      FInfoForm.Timer.Interval := FShowTime;

      AdjustFormIcon;

      R.Left := max(X, 0);
      R.Top  := max(Y, 0);
      i := SuggestedWidth;
      if i > DesktopWidth then
        FInfoForm.InfoLabel.WordWrap := true;
      R.Right := min(i, DesktopWidth);
      R.Bottom := min(SuggestedHeight, DesktopHeight);
      with R do
        FInfoForm.SetBounds(Left, Top, Right, Bottom);
      FInfoForm.FCloseBtn.Parent := FInfoForm.Panel1;
      {$ifndef ELPACK_SINGLE_COMP}
      FInfoForm.FCloseBtn.Color := Color;
      {$endif}
      FInfoForm.FCloseBtn.Visible := ShowCloseButton;
      FInfoForm.FCloseBtn.SetBounds(R.Right - 20, 1, 18, Min(18, R.Bottom - 2));
      H1 := GetForegroundWindow;
      with FInfoForm do
        if InfoLabel.Height < Image1.Height then
          InfoLabel.Top := Image1.Top + (Image1.Height - InfoLabel.Height) div 2
        else
          InfoLabel.Top := Image1.Top;
      HookAppl;
      FInfoForm.Visible := true;
      SetWindowPos(FInfoForm.Handle, HWND_TOPMOST, 0,0,0,0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE {or SWP_SHOWWINDOW});
      SetForegroundWindow(H1);
      FInfoForm.Timer.Enabled := FShowTime > 0;
      UnhookAppl;
    end;
  end;
end;

procedure TElTrayInfo.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  if FInfoForm <> nil then
    FInfoForm.InfoLabel.Font := FFont;
end;

procedure TElTrayInfo.FontChange(Sender : TObject);
begin
  FParentFont := false;
  if FInfoForm <> nil then
    FInfoForm.InfoLabel.Font := FFont;
end;

procedure TElTrayInfo.SetParentFont(Value: Boolean);
var AForm : TForm;
begin
  if FParentFont <> Value then
  begin
    if Value then
    begin
      AForm := GetOwnerForm(Self);
      if AForm <> nil then
        Font := AForm.Font;
      FParentFont := true;
    end
    else
      FParentFont := false;
  end;
end;

{$R *.DFM}

procedure TTrayInfoForm.TimerTimer(Sender: TObject);
begin
  Hide;
end;

procedure TTrayInfoForm.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent is TElTrayInfo) then
  begin
    FOnClick := nil;
    FOnDblClick := nil;
  end;
end;

procedure TTrayInfoForm.CloseBtnClick(Sender : TObject);
begin
  Close;
end;

procedure TTrayInfoForm.CreateParams(var Params: TCreateParams);  { protected }
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    WndParent := GetDesktopWindow;
  end;
end;  { CreateParams }

procedure TTrayInfoForm.ClickHandler(Sender: TObject);
begin
  if assigned(FOnClick) then FOnClick(Self);
end;

procedure TTrayInfoForm.DblClickHandler(Sender: TObject);
begin
  if assigned(FOnDblClick) then FOnDblClick(Self);
end;

procedure TTrayInfoForm.ShowHandler(Sender: TObject);
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

procedure TTrayInfoForm.HideHandler(Sender: TObject);
begin
  if Assigned(FOnHide) then FOnHide(Self);
end;

procedure TTrayInfoForm.WMMouseActivate(var Msg: TMessage);
begin
  Msg.Result := MA_NOACTIVATE;
end;

procedure TTrayInfoForm.FormCreate(Sender: TObject);
var Bmp : TBitmap;
    i, j: integer;
begin
  FTopmost := TElTopmost.Create(Self);
  {$ifndef ELPACK_SINGLE_COMP}
  FCloseBtn := TElTrayInfoCloseButton.Create(Self);
  {$else}
  FCloseBtn := TSpeedButton.Create(Self);
  {$endif}
  FCloseBtn.OnClick := CloseBtnClick;
  Bmp := TBitmap.Create;
  Bmp.Width := 16;
  Bmp.Height := 16;
  {$ifndef ELPACK_SINGLE_COMP}
  FCloseBtn.AdjustSpaceForGlyph := false;
  {$endif}
  FCloseBtn.Flat := true;
  Bmp.Canvas.Brush.Color := Panel1.Color;
  Bmp.Canvas.FillRect(Rect(0, 0, 16, 16));
  DrawFrameControl(Bmp.Canvas.Handle, Rect(-1, -1, 18, 18), DFC_CAPTION, DFCS_CAPTIONCLOSE);
  for i := 0 to bmp.Width do
    for j := 0 to Bmp.Height do
    begin
      if Bmp.Canvas.Pixels[i, j] = colorToRGB(clBtnFace) then
        Bmp.Canvas.Pixels[i, j] := Panel1.Color
      else
        Bmp.Canvas.Pixels[i, j] := clInfoText;
    end;
  FCloseBtn.Glyph := Bmp;
  Bmp.Free;
end;

end.
