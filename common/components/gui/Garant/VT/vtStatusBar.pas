unit vtStatusBar;
{TvtStatusBar}

{$Include vtDefine.inc}

interface

uses
  Windows, Classes, Messages, Controls, ComCtrls, Graphics, Forms,
  ExtCtrls, ActnList, ImgList,

  l3Defaults
  ;

const
 cDefBack = {$IfDef Nemesis}cGarant2011ToolbarsColor{$Else}clBtnFace{$EndIf};

type
  TvtStatusPanelType = (
     sptNormal,            // Nothing special, same as a regular TStatusPanel
     sptDate,              // Current date.  Uses DateFormat property for format
     sptTime,              // Current time.  Uses TimeFormat property for format
     sptDateTime,          // Current date and time.  Uses DateFormat and
                           //   TimeFormat properties for format
     sptTimeDate,          // Current time and date.  Uses DateFormat and
                           //   TimeFormat properties for format
     sptEllipsisText,      // Shorten text at the end with '...' when won't fit.
     sptEllipsisPath,      // Shorten by removing path info with '...' when
                           //   won't fit.
     sptGlyph,             // Displays a TPicture object in the Panel.
     sptGauge,             // A progress meter.  Use GaugeAttrs to customize it.
     sptOwnerDraw,         // Same as the old TStatusPanel.Style = psOwnerDraw.
     sptAction             // Display Hyperlink to execute linked action 
    );

  TPercent = 0..100;

  TvtGaugeStyle = (
     gsPercent,        // Your basic progress meeter.
     gsIndeterminate,  // A progress indicator where the min/max are not
                       //   known.  That is, you want to show something
                       //   going on, but don't know how long it will take.
                       //   It's a little ball that "bounces" back and forth.
     gsIndeterminate2  // Same as above, but looks more Netscape-ish.
    );
  TvtGaugeStyles = set of TvtGaugeStyle;

  TvtCustomStatusBar = class; // forward declaration
  TvtStatusPanel = class; // forward declaration


  TvtDrawPanelEvent = procedure(StatusBar: TvtCustomStatusBar;
     Panel: TvtStatusPanel; const Rect: TRect) of object;
  TvtPanelHintTextEvent = procedure (StatusBar: TvtCustomStatusBar;
     Panel: TvtStatusPanel; var Hint: AnsiString) of object;


  TvtGaugeAttrs = class(TPersistent)
  private
    FStyle: TvtGaugeStyle;
    FOwner: TvtStatusPanel;
    FPosition: TPercent;
    FSpeed: integer;
    FColor: TColor;
    FTextColor: TColor;
    procedure SetPosition(const Value: TPercent);
    procedure SetStyle(const Value: TvtGaugeStyle);
    procedure SetSpeed(const Value: integer);
    procedure SetColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
  public
    constructor Create(AOwner: TvtStatusPanel);
    procedure Assign(Source: TPersistent); override;

    property Owner: TvtStatusPanel
       read FOwner;
  published
    property Style: TvtGaugeStyle
       read FStyle
       write SetStyle
       default gsPercent;
    property Position: TPercent
       read FPosition
       write SetPosition
       default 0;
    property Speed: integer
       read FSpeed
       write SetSpeed
       default 4;
    property Color: TColor
       read FColor
       write SetColor
       default clHighlight;
    property TextColor: TColor
       read FTextColor
       write SetTextColor
       default clHighlightText;
  end;

  TvtStatusPanelActionLink = class(TActionLink)
  protected
    FClient: TvtStatusPanel;
    procedure AssignClient(AClient: TObject); override;
    function IsCaptionLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    procedure SetCaption(const Value: String); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetHint(const Value: String); override;
  end;

  _l3Unknown_Parent_ = TCollectionItem;
  {$Define _UnknownNeedsQI}
  {$Include l3Unknown.imp.pas}
  TvtStatusPanel = class(_l3Unknown_)
  private
    FKeyOn: boolean;
    FPanelType: TvtStatusPanelType;
    FAutoFit: boolean;
    FEnabled: boolean;
    FTimeFormat: AnsiString;
    FDateFormat: AnsiString;
    FText: AnsiString;
    FGlyph: TPicture;
    FGaugeLastPos: integer;
    FGaugeDirection: integer;
    FOnDrawPanel: TvtDrawPanelEvent;
    FHint: AnsiString;
    FOnHintText: TvtPanelHintTextEvent;
    FOnClick: TNotifyEvent;
    FGaugeAttrs: TvtGaugeAttrs;
    FGaugeBitmap: TBitmap;
    FBorderWidth: TBorderWidth;
    FActionLink: TvtStatusPanelActionLink;
    FImageIndex: TImageIndex;
    f_ShowActionCaption: Boolean;
    FToolTipID: LongWord;

    procedure SetPanelType(const Val: TvtStatusPanelType);
    function GetAlignment: TAlignment;
    function GetBevel: TStatusPanelBevel;
    function IsBiDiModeStored: Boolean;
    function GetBiDiMode: TBiDiMode;
    function GetParentBiDiMode: Boolean;
    function GetWidth: Integer;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetBevel(const Value: TStatusPanelBevel);
    procedure SetBiDiMode(const Value: TBiDiMode);
    procedure SetParentBiDiMode(const Value: Boolean);
    procedure SetText(const Value: AnsiString);
    procedure SetWidth(const Value: Integer);
    procedure SetAutoFit(const Value: boolean);
    procedure SetDateFormat(const Value: AnsiString);
    procedure SetEnabled(const Value: boolean);
    procedure SetGlyph(const Value: TPicture);
    procedure SetTimeFormat(const Value: AnsiString);
    procedure SetImageIndex(Value: TImageIndex);
    function GetStatusBar: TvtCustomStatusBar;
    function GetEnabled: boolean;
    function GetHint: AnsiString;
    procedure SetGaugeAttrs(const Value: TvtGaugeAttrs);
    function GetLinkedPanel: TStatusPanel;
    function GetGaugeBitmap: TBitmap;
    procedure SetBorderWidth(const Value: TBorderWidth);
    function IsTextStored: Boolean;
    procedure SetAction(aValue: TBasicAction);
    function GetAction: TBasicAction;
    procedure DoActionChange(Sender: TObject);
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean);
    procedure pm_SetShowActionCaption(const Value: Boolean);
  protected
    procedure SetCollection(Value: TCollection); override;
    procedure SetIndex(Value: integer); override;
    function GetDisplayName: String; override;
    procedure TimerNotification;
    procedure UpdateAutoFitWidth; virtual;
    procedure UpdateDateTime; virtual;
    procedure GlyphChanged(Sender: TObject); virtual;
    procedure DrawPanel(Rect: TRect); virtual;
    procedure EnabledChanged; virtual;
    procedure DoHintText(var HintText: AnsiString); virtual;
    procedure Redraw(Canvas: TCanvas; Dest: TRect); virtual;
    procedure DrawTextBased(Canvas: TCanvas; R: TRect); virtual;
    procedure DrawGlyph(Canvas: TCanvas; R: TRect); virtual;
    procedure DrawAction(Canvas: TCanvas; R: TRect); virtual;
    procedure DrawGauge(Canvas: TCanvas; R: TRect); virtual;
    procedure DrawIndeterminateGauge(Canvas: TCanvas; R: TRect); virtual;
    function InitGaugeBitmap: TBitmap; virtual;
    procedure Click; virtual;
    procedure InitiateAction;
    function CalculatedShowActionCaption: Boolean;
    function AdjustedHint: String;
    property LinkedPanel: TStatusPanel
       read GetLinkedPanel;
    property GaugeBitmap: TBitmap
       read GetGaugeBitmap;
    property ToolTipID: LongWord
       read FToolTipID
       write FToolTipID;
  public
    constructor Create(AOwner: TCollection); override;
    procedure Cleanup; override;
    procedure Assign(Source: TPersistent); override;
    procedure Invalidate;

    property StatusBar: TvtCustomStatusBar
       read GetStatusBar;
    property Action: TBasicAction
       read GetAction
       write SetAction;
    property ImageIndex: TImageIndex
       read FImageIndex
       write SetImageIndex
       default -1;
    property ShowActionCaption: Boolean
       read f_ShowActionCaption
       write pm_SetShowActionCaption;
  published
    property GaugeAttrs: TvtGaugeAttrs
       read FGaugeAttrs
       write SetGaugeAttrs;
    property Alignment: TAlignment
       read GetAlignment
       write SetAlignment
       default taLeftJustify;
    property Bevel: TStatusPanelBevel
       read GetBevel
       write SetBevel
       default pbLowered;
    property BorderWidth: TBorderWidth
      read FBorderWidth
      write SetBorderWidth
      default 0;
    property BiDiMode: TBiDiMode
       read GetBiDiMode
       write SetBiDiMode
       stored IsBiDiModeStored;
    property ParentBiDiMode: Boolean
       read GetParentBiDiMode
       write SetParentBiDiMode
       default True;

    // PanelType must come before most of the other properties because it would
    //   stomp on some of their values as they are streamed.  Some of the other
    //   properties have to be ordered a certain way, too, so don't mess with
    //   the declaration order.
    property PanelType: TvtStatusPanelType
       read FPanelType
       write SetPanelType
       default sptNormal;
    property Glyph: TPicture
       read FGlyph
       write SetGlyph;
    property Text: AnsiString
       read FText
       write SetText
       stored IsTextStored;
    property DateFormat: AnsiString
       read FDateFormat
       write SetDateFormat;
    property TimeFormat: AnsiString
       read FTimeFormat
       write SetTimeFormat;
    property Enabled: boolean
       read GetEnabled
       write SetEnabled
       default True;
    property Width: Integer
       read GetWidth
       write SetWidth;
    property AutoFit: boolean
       read FAutoFit
       write SetAutoFit
       default False;
    property Hint: AnsiString
       read GetHint
       write FHint;

    property OnDrawPanel: TvtDrawPanelEvent
       read FOnDrawPanel
       write FOnDrawPanel;
    property OnHintText: TvtPanelHintTextEvent
       read FOnHintText
       write FOnHintText;
    property OnClick: TNotifyEvent
       read FOnClick
       write FOnClick;
  end;

  TvtStatusPanels = class(TCollection)
  private
    FTimer: TTimer;
    FTimerClients: TList;
    FLastDate: TDateTime;
    FStatusBar: TvtCustomStatusBar;
    FLinkedPanels: TStatusPanels;
    function GetItem(Index: Integer): TvtStatusPanel;
    procedure SetItem(Index: Integer; Value: TvtStatusPanel);
  protected
    procedure Update(Item: TCollectionItem); override;
    function GetOwner: TPersistent; override;
    procedure RegisterTimer(Client: TvtStatusPanel);
    procedure DeregisterTimer(Client: TvtStatusPanel);
    procedure TimerEvent(Sender: TObject);
  public
    constructor Create(StatusBar: TvtCustomStatusBar; LinkedPanels: TStatusPanels);
    destructor Destroy; override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    function Add: TvtStatusPanel;
    property Items[Index: Integer]: TvtStatusPanel
       read GetItem
       write SetItem;
       default;
  end;

  TvtCustomStatusBar = class(TCustomStatusBar)
  private
    FPanels: TvtStatusPanels;
    FExtentCanvas: HDC;
    FExtentFont: HFONT;
    FExtentFontOld: HFONT;
    FImages: TCustomImageList;
    FImageChangeLink: TChangeLink;
    procedure SetPanels(const Value: TvtStatusPanels);
    procedure SetImages(const aValue: TCustomImageList);
    function  PanelsStrored: Boolean;
    procedure ImageListChange(Sender: TObject);
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMHintShow(var Msg: TMessage); message CM_HINTSHOW;
    procedure UpdateExtentFont;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
   procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    function AllPanelsText : AnsiString;
      {* - возвращает текст всех панелей разделенный знаком '|'. }
  protected
    {$IFNDEF DesignTimeLibrary}
    {$IfNDef XE}
    function IsActionLinked: Boolean; override;
    {$EndIf  XE}
    {$ENDIF DesignTimeLibrary}
    procedure UpdatePanelsWidth; virtual;
    procedure Resize; override;
    procedure DrawPanel(Panel: TStatusPanel; const Rect: TRect); override;
    procedure Loaded; override;
    procedure CreateWnd; override;
    procedure WndProc(var Msg: TMessage); override;
    function GetPanelRect(Index: integer): TRect;
    function FindLinkedPanel(Panel: TStatusPanel): TvtStatusPanel;
    function PanelByPt(const aPt: TPoint): TvtStatusPanel;
    function FindPanelByMouse: TvtStatusPanel;

    function TextExtent(const Text: AnsiString; NeedCorrect: Boolean = False): TSize;
    procedure Click; override;
    procedure DblClick; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure PanelActionExecuted(aClient: TvtStatusPanel); virtual;
    procedure CheckActionAutopopup(aID: LongWord; aEnabled: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitiateAction; override;
    procedure InvalidatePanel(Index: integer);
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function  InUpdating: Boolean;

    property Panels: TvtStatusPanels
       read FPanels
       write SetPanels
       stored PanelsStrored;

    property Images: TCustomImageList
       read FImages
       write SetImages;

    end;

  TvtStatusBar = class(TvtCustomStatusBar)
   published
    property Action;
    property AutoHint default False;
    property Align default alBottom;
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    property Color default cDefBack;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font stored IsFontStored;
    property Constraints;
    property Panels;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont default True;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property SimplePanel default False;
    property SimpleText;
    property SizeGrip default True;
    property UseSystemFont default False;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnCreatePanelClass;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnHint;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

  TdfsStatusBar = class(TvtStatusBar)
  end;//TdfsStatusBar


// You may want to change this value if you don't like the speed of the
// indeterminate gauge
const
  INDETERMINATE_GAUGE_UPDATE_INTERVAL: integer = 50; // in milliseconds

const
  IndeterminateGuages: TvtGaugeStyles = [gsIndeterminate, gsIndeterminate2];

implementation

uses
  RTLConsts,
  CommCtrl, TypInfo, SysUtils, Menus,

  l3Interfaces,
  l3Base,
  l3Bitmap,
  l3Interlocked,
  
  afwDrawing,
  afwFacade
  
  {$If not defined(NoScripts)}
  ,
  StatusPanelWordsPack
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  StatusBarWordsPack
  {$IfEnd} //not NoScripts  
  ;

{$Include l3Unknown.imp.pas}  

const
  cPanelTextSeparator = '|';
  cGaugeWidth = 200;

var
  RegisteredTimers: integer;

// Utility function for making a copy of a font handle
function CopyHFont(Font: HFONT): HFONT;
var
  LF: TLogFont;
begin
  if Font <> 0 then
  begin
    GetObject(Font, SizeOf(LF), @LF);
    Result := CreateFontIndirect(LF);
  end else
    Result := 0;
end;

{ TvtGaugeAttrs }

procedure TvtGaugeAttrs.Assign(Source: TPersistent);
var
  SrcAttrs: TvtGaugeAttrs absolute Source;
begin
  if Source is TvtGaugeAttrs then
  begin
    FOwner := SrcAttrs.Owner;
    Position := SrcAttrs.Position;
    Style := SrcAttrs.Style;
  end else
    inherited Assign(Source);
end;

constructor TvtGaugeAttrs.Create(AOwner: TvtStatusPanel);
begin
  inherited Create;
  FOwner := AOwner;
  FStyle := gsPercent;
  FPosition := 0;
  FSpeed := 4;
  FColor := clHighlight;
  FTextColor := clHighlightText;
end;

procedure TvtGaugeAttrs.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FOwner.FGaugeBitmap.Free;
    FOwner.FGaugeBitmap := NIL;
    FOwner.Invalidate;
  end;
end;

procedure TvtGaugeAttrs.SetPosition(const Value: TPercent);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    FOwner.Invalidate;
  end;
end;

procedure TvtGaugeAttrs.SetSpeed(const Value: integer);
begin
  if (FSpeed <> Value) and (FSpeed > 0) then
    FSpeed := Value;

  if Owner.FGaugeDirection < 0 then
    Owner.FGaugeDirection := -FSpeed
  else
    Owner.FGaugeDirection := FSpeed;
end;

procedure TvtGaugeAttrs.SetStyle(const Value: TvtGaugeStyle);
begin
  if FStyle <> Value then
  begin
    if (Owner.PanelType = sptGauge) and (FStyle in IndeterminateGuages) and
       Owner.Enabled then
      TvtStatusPanels(Owner.Collection).DeregisterTimer(Owner);
    FStyle := Value;
    FOwner.Invalidate;
    if (Owner.PanelType = sptGauge) and (FStyle in IndeterminateGuages) and
       Owner.Enabled then
      TvtStatusPanels(Owner.Collection).RegisterTimer(Owner);
  end;
end;


procedure TvtGaugeAttrs.SetTextColor(const Value: TColor);
begin
  if Value <> FTextColor then
  begin
    FTextColor := Value;
    Owner.Invalidate;
  end;
end;

{ TvtStatusPanel }

procedure TvtStatusPanel.Assign(Source: TPersistent);
var
  SrcPanel: TvtStatusPanel absolute Source;
begin
  if Source is TvtStatusPanel then
  begin
{    if LinkedPanel <> NIL then
      LinkedPanel.Free;
    LinkedPanel := SrcPanel.FLinkedPanel;}

    GaugeAttrs.Assign(SrcPanel.GaugeAttrs);
    Alignment := SrcPanel.Alignment;
    Bevel := SrcPanel.Bevel;
    BiDiMode := SrcPanel.BiDiMode;
    ParentBiDiMode := SrcPanel.ParentBiDiMode;
    Glyph.Assign(SrcPanel.Glyph);
    Text := SrcPanel.Text;
    DateFormat := SrcPanel.DateFormat;
    TimeFormat := SrcPanel.TimeFormat;
    Enabled := SrcPanel.Enabled;
    Width := SrcPanel.Width;
    AutoFit := SrcPanel.AutoFit;
    Hint := SrcPanel.Hint;

    OnDrawPanel := SrcPanel.OnDrawPanel;
    OnHintText := SrcPanel.OnHintText;

    // Do last!
    PanelType := SrcPanel.PanelType;
  end else
    inherited Assign(Source);
end;

constructor TvtStatusPanel.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);

  if AOwner is TvtStatusPanels then
  begin
    TvtStatusPanels(AOwner).FLinkedPanels.Add;
    LinkedPanel.Style := psOwnerDraw;
  end else
    raise Exception.Create('TvtStatusPanel owner must be TvtStatusPanels');
  FKeyOn := FALSE;
  FGaugeLastPos := 0;
  FGaugeDirection := 1;
  FPanelType := sptNormal;
  FAutoFit := FALSE;
  FEnabled := TRUE;
  FTimeFormat := '';
  FDateFormat := '';
  FGaugeAttrs := TvtGaugeAttrs.Create(Self);
  FGlyph := TPicture.Create;
  FGlyph.OnChange := GlyphChanged;
  FImageIndex := -1;
end;


procedure TvtStatusPanel.Cleanup;
begin
  if Enabled then
    case FPanelType of
      sptDate, sptTime, sptDateTime, sptTimeDate:
        TvtStatusPanels(Collection).DeregisterTimer(Self);
      sptGauge:
        if GaugeAttrs.Style in IndeterminateGuages then
          TvtStatusPanels(Collection).DeregisterTimer(Self);
    end;

  FGlyph.Free;
  FGaugeAttrs.Free;
  FGaugeBitmap.Free;
  if (Index >= 0) then
  // - если LinkedPanels не была уже удалена в TnscStatusBar.DoUpdateStrings SafeClear
   TvtStatusPanels(Collection).FLinkedPanels[Index].Free;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=313757523
   // http://mdp.garant.ru/pages/viewpage.action?pageId=278838904
  Collection := nil;

  inherited;
end;


function TvtStatusPanel.GetAlignment: TAlignment;
begin
  Result := LinkedPanel.Alignment
end;

function TvtStatusPanel.GetBevel: TStatusPanelBevel;
begin
  Result := LinkedPanel.Bevel
end;

function TvtStatusPanel.GetBiDiMode: TBiDiMode;
begin
  Result := LinkedPanel.BiDiMode
end;

function TvtStatusPanel.GetParentBiDiMode: Boolean;
begin
  Result := LinkedPanel.ParentBiDiMode
end;

function TvtStatusPanel.GetStatusBar: TvtCustomStatusBar;
begin
 if (Collection = nil) then
  Result := nil
 else
 begin
  Assert(Assigned(Collection));
  Result := TvtStatusPanels(Collection).FStatusBar;
 end;//Collection = nil
end;

function TvtStatusPanel.GetWidth: Integer;
begin
  Result := LinkedPanel.Width
end;

procedure TvtStatusPanel.Invalidate;
begin
 if (StatusBar <> nil) then
  if (Index >= 0) then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=321983826
   StatusBar.InvalidatePanel(Index);
end;

function TvtStatusPanel.IsBiDiModeStored: Boolean;
begin
  Result := not ParentBiDiMode;
end;

procedure TvtStatusPanel.Redraw(Canvas: TCanvas; Dest: TRect);
var
  Buffer: TBitmap;
  R: TRect;
begin
  if (not StatusBar.HandleAllocated) or StatusBar.InUpdating or (IsRectEmpty(Dest)) then
    exit;

  InflateRect(Dest, -1, -1); // Don't paint over the shadows.

  R := Dest;
  OffsetRect(R, -Dest.Left, -Dest.Top);
  Buffer := Tl3Bitmap.Create;
  try
    Buffer.Width := R.Right;
    Buffer.Height := R.Bottom;

    Buffer.Canvas.Font.Handle := CopyHFont(Canvas.Font.Handle);
    Buffer.Canvas.Brush.Color := StatusBar.Color;
    Buffer.Canvas.FillRect(R);

    if BorderWidth > 0 then
      InflateRect(R, -BorderWidth, -BorderWidth);

    if Enabled then
    begin
      case PanelType of
        sptNormal, sptDate, sptTime, sptDateTime, sptTimeDate, sptEllipsisText,
        sptEllipsisPath, sptOwnerDraw:
          begin
            if (PanelType = sptOwnerDraw) and
               not (csDesigning in StatusBar.ComponentState) then
              exit;
            DrawTextBased(Buffer.Canvas, R);
          end;

          sptGlyph:
            DrawGlyph(Buffer.Canvas, R);

          sptGauge:
            if GaugeAttrs.Style in IndeterminateGuages then
              DrawIndeterminateGauge(Buffer.Canvas, R)
            else
              DrawGauge(Buffer.Canvas, R);
          sptAction:
            DrawAction(Buffer.Canvas, R);
      end;
    end
    else
     if PanelType = sptAction then
      DrawAction(Buffer.Canvas, R);

    Canvas.Draw(Dest.Left, Dest.Top, Buffer);
  finally
    Buffer.Free;
  end;
end;

procedure TvtStatusPanel.DrawGauge(Canvas: TCanvas; R: TRect);
var
  R1, R2: TRect;
  R1Rgn, R2Rgn, OldRgn: HRGN;
  Pct: AnsiString;
  OldColor: TColorRef;
  DTFlags: UINT;
begin
  R1 := R;
  R2 := R;
  R1.Right := R1.Left + MulDiv(R.Right-R.Left, FGaugeAttrs.Position, 100);
  with Canvas do
  begin
    Brush.Color := GaugeAttrs.Color;
    FillRect(R1);
    R2.Left := R1.Right;
    Brush.Color := StatusBar.Color;
    FillRect(R2);

    { This could probably be simplified with ExtTextOut and SetTextAlign now
      things are being properly buffered off-screen.  But, this is working and
      doesn't seem slow, so....  "If it ain't broke, don't fix it."  :)        }
    if Text = '' then
      Pct := IntToStr(FGaugeAttrs.Position) + '%'
    else
      Pct := Text; // Use what's in the Panel's text property.
    // don't change background color behind text!
    Brush.Style := bsClear;
    OldColor := GetTextColor(Handle);

    R1Rgn := CreateRectRgnIndirect(R1);
    R2Rgn := CreateRectRgnIndirect(R2);
    OldRgn := CreateRectRgn(0, 0, 1, 1);
    try
      GetClipRgn(Handle, OldRgn);

      DTFlags := DT_VCENTER or DT_NOPREFIX or DT_SINGLELINE;
      case Alignment of
        taCenter:       DTFlags := DTFlags or DT_CENTER;
        taRightJustify: DTFlags := DTFlags or DT_RIGHT;
      end;
      // Draw the text in the "filled" area with text color
      if (R1Rgn<>0) and (SelectClipRgn(Handle, R1Rgn) <> ERROR) then
        try
          SetTextColor(Handle, ColorToRGB(GaugeAttrs.TextColor));
          DrawText(Handle, PAnsiChar(Pct), -1, R, DTFlags);
        finally
          SelectClipRgn(Handle, OldRgn);
        end;

      // Draw the text in the "empty" area with normal color
      if (R2Rgn<>0) and (SelectClipRgn(Handle, R2Rgn) <> ERROR) then
        try
//          SetTextColor(Handle, OldColor);
          SetTextColor(Handle, ColorToRGB(StatusBar.Font.Color));
          DrawText(Handle, PAnsiChar(Pct), -1, R, DTFlags);
        finally
          SelectClipRgn(Handle, OldRgn);
        end;
    finally
      SetTextColor(Handle, OldColor);
      DeleteObject(R1Rgn);
      DeleteObject(R2Rgn);
      DeleteObject(OldRgn);
    end;
  end;
end;

procedure TvtStatusPanel.DrawGlyph(Canvas: TCanvas; R: TRect);
const
  TEXT_SPACE = 2;
var
  TW: integer;
  GR: TRect;
begin
  GR := R;
  if Text <> '' then
    TW := Canvas.TextWidth(Text) + TEXT_SPACE
  else
    TW := 0;
  if (Alignment = taCenter) or AutoFit then
     with GR do
       Left := Left + ((Right - Left - Glyph.Width - TW) div 2)
  else if Alignment = taRightJustify then
    GR.Left := GR.Right - Glyph.Width;

  GR.Top := GR.Top + (GR.Bottom - GR.Top - Glyph.Height) div 2;

  if Glyph.Graphic is TBitmap then
  begin
    // Draw it transparently
    Canvas.BrushCopy(Bounds(GR.Left, GR.Top, Glyph.Width,
       Glyph.Height), Glyph.Bitmap, Rect(0, 0, Glyph.Width,
       Glyph.Height), Glyph.Bitmap.Canvas.Pixels[0, Glyph.Height-1]);
  end else
    Canvas.Draw(GR.Left, GR.Top, Glyph.Graphic);
  if Text <> '' then
  begin
    SetTextColor(Canvas.Handle, ColorToRGB(StatusBar.Font.Color));
    case Alignment of
      taLeftJustify,
      taCenter:
        begin
          GR.Left := GR.Left + Glyph.Width + TEXT_SPACE;
          GR.Top := R.Top;
          GR.Bottom := R.Bottom;
          DrawText(Canvas.Handle, PAnsiChar(Text), -1, GR, DT_SINGLELINE or
            DT_NOPREFIX or DT_VCENTER);
        end;
      taRightJustify:
        begin
          GR.Left := GR.Left - TW - TEXT_SPACE;
          GR.Top := R.Top;
          GR.Bottom := R.Bottom;
          DrawText(Canvas.Handle, PAnsiChar(Text), -1, GR, DT_SINGLELINE or
            DT_NOPREFIX or DT_VCENTER);
        end;
    end;
  end;
end;

function TvtStatusPanel.InitGaugeBitmap: TBitmap;
var
	r1, b1, g1, r2, b2, g2: byte;
	c1, c2: Longint;
  i: integer;
	divi: integer;
	mul: extended;
begin
	c1 := ColorToRGB(StatusBar.Color);
	c2 := ColorToRGB(GaugeAttrs.Color);
	r1 := GetRValue(c1);
  b1 := GetBValue(c1);
  g1 := GetGValue(c1);
	r2 := GetRValue(c2);
  b2 := GetBValue(c2);
  g2 := GetGValue(c2);
	Result := Tl3Bitmap.Create;
	with Result do
	begin
		Height := StatusBar.Height;
		Width := 100;
		divi := Width-1;
		Canvas.Brush.Color := clRed;
		Canvas.FillRect(Rect(0, 0, Width, Height));
		for i := 0 to divi do
		begin
			mul := (i/divi);
			Canvas.Pen.Color := RGB(trunc(r1 + (r2 - r1) * mul),
         trunc(g1 + (g2 - g1) *mul), trunc(b1 + (b2 - b1) * mul));
			Canvas.MoveTo(i, 0);
			Canvas.LineTo(i, Height);
		end;
	end;
end;

procedure TvtStatusPanel.DrawIndeterminateGauge(Canvas: TCanvas; R: TRect);
var
	gb:TBitmap;
	gbr:TRect;
  x: integer;
begin
  inc(FGaugeLastPos, FGaugeDirection);
  case GaugeAttrs.Style of
    gsIndeterminate:
      begin
        with Canvas do
        begin
          Brush.Color := GaugeAttrs.Color;
          Pen.Color := GaugeAttrs.Color;
          gbr := R;
          InflateRect(R, 0, -((R.Bottom - R.Top) div 3));
          x := R.Bottom - R.Top;
          if (FGaugeDirection > 0) and ((FGaugeLastPos + X + 1) >=
             (R.Right - R.Left)) then
          begin
            FGaugeDirection := -GaugeAttrs.Speed;
          end else if (FGaugeDirection < 0) and (FGaugeLastPos <= 1) then
          begin
            FGaugeDirection := GaugeAttrs.Speed;
          end;
          Inc(R.Left, FGaugeLastPos);
          R.Right := R.Left + X;
          // Make it a wee bit bigger
          InflateRect(R, 1, 1);

          with R do
            Ellipse(Left, Top, Right, Bottom);
        end;
      end;

    gsIndeterminate2:
      begin
        with Canvas do
        begin
          gb := GaugeBitmap;
          if (FGaugeDirection > 0) and
             ((FGaugeLastPos+ 1) >= (R.Right - R.Left)) then
            FGaugeDirection := -FGaugeAttrs.Speed
          else if (FGaugeDirection < 0) and (FGaugeLastPos <= -gb.Width) then
            FGaugeDirection := FGaugeAttrs.Speed;
          Inc(R.Left, FGaugeLastPos);
          gbr := Rect(0, 0, gb.Width, gb.Height);
          if (r.right - r.left) > gb.width then
            r.right := r.left + gb.Width
          else
            if (r.right - r.left) < gb.width then
            begin
              if FGaugeDirection > 0 then
                gbr.Right := r.right - r.Left
              else
                gbr.Left := gbr.right - (r.right - r.left);
            end;

          if FGaugeDirection > 0 then
            CopyRect(r, gb.Canvas, gbr)
          else
            CopyRect(r, gb.Canvas,
               Rect(gbr.right-1, gbr.Bottom-1, gbr.left-1, gbr.top-1))
        end;
      end;
  end;
end;

procedure TvtStatusPanel.DrawTextBased(Canvas: TCanvas; R: TRect);
var
  DTFlags: UINT;
begin
  DTFlags := DT_SINGLELINE or DT_NOPREFIX or DT_VCENTER;
  if AutoFit then
    DTFLags := DTFlags or DT_CENTER
  else
    case Alignment of
      taCenter:       DTFlags := DTFlags or DT_CENTER;
      taRightJustify:
        begin
          dec(R.Right);
          DTFlags := DTFlags or DT_RIGHT;
        end;
    end;
  case PanelType of
    sptEllipsisPath: DTFlags := DTFlags or DT_PATH_ELLIPSIS;
    sptEllipsisText: DTFlags := DTFlags or DT_END_ELLIPSIS;
  end;
  SetTextColor(Canvas.Handle, ColorToRGB(StatusBar.Font.Color));
  if PanelType = sptOwnerDraw then
    // This only happens when in design mode, see Redraw method.
    DrawText(Canvas.Handle, ' *OD* ', -1, R, DTFlags)
  else
    DrawText(Canvas.Handle, PAnsiChar(Text), -1, R, DTFlags);
end;

procedure TvtStatusPanel.SetAlignment(const Value: TAlignment);
begin
  if LinkedPanel.Alignment <> Value then
  begin
    LinkedPanel.Alignment := Value;
    Invalidate;
  end;
end;

procedure TvtStatusPanel.SetAutoFit(const Value: boolean);
begin
  if FAutoFit <> Value then
  begin
    FAutoFit := Value;
    UpdateAutoFitWidth;
  end;
end;

procedure TvtStatusPanel.SetBevel(const Value: TStatusPanelBevel);
begin
  if LinkedPanel.Bevel <> Value then
    LinkedPanel.Bevel := Value;
end;

procedure TvtStatusPanel.SetBiDiMode(const Value: TBiDiMode);
begin
  if LinkedPanel.BiDiMode <> Value then
    LinkedPanel.BiDiMode := Value;
end;

procedure TvtStatusPanel.SetParentBiDiMode(const Value: Boolean);
begin
  if LinkedPanel.ParentBiDiMode <> Value then
    LinkedPanel.ParentBiDiMode := Value;
end;

procedure TvtStatusPanel.SetDateFormat(const Value: AnsiString);
begin
  if FDateFormat <> Value then
  begin
    FDateFormat := Value;
    UpdateDateTime;
  end;
end;

procedure TvtStatusPanel.SetEnabled(const Value: boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    EnabledChanged;
  end;
end;

procedure TvtStatusPanel.SetGlyph(const Value: TPicture);
begin
  FGlyph.Assign(Value);
  // GlyphChanged method will take care of updating display.
end;

procedure TvtStatusPanel.SetPanelType(const Val: TvtStatusPanelType);

 procedure l_SetAutoFit(aValue: Boolean);
 begin
  if not (csLoading in StatusBar.ComponentState) then
   AutoFit := aValue;
 end;

begin
  if Val <> FPanelType then
  begin
    if Enabled then
      case FPanelType of
        sptDate, sptTime, sptDateTime, sptTimeDate:
          TvtStatusPanels(Collection).DeregisterTimer(Self);
        sptGauge:
          if GaugeAttrs.Style in IndeterminateGuages then
            TvtStatusPanels(Collection).DeregisterTimer(Self);
      end;

    FPanelType := Val;
    case FPanelType of
      sptDate, sptTime, sptDateTime, sptTimeDate:
        begin
          l_SetAutoFit(FALSE);
          if Enabled then
            TvtStatusPanels(Collection).RegisterTimer(Self);
          UpdateDateTime;
        end;
      sptEllipsisText, sptEllipsisPath:
        begin
          l_SetAutoFit(FALSE);
          if Hint = '' then
            Hint := '...';
        end;
      sptGlyph:
        begin
          l_SetAutoFit(TRUE);
        end;
      sptGauge:
        begin
          Alignment := taCenter;
          if GaugeAttrs.Style in IndeterminateGuages then
          begin
            Enabled := FALSE; // Enabled is false, so don't need to register
            FGaugeLastPos := 0;
            FGaugeDirection := GaugeAttrs.Speed;
          end;
        end;
      sptAction:
        begin
          ActionChange(Action, True);
          l_SetAutoFit(True);
        end;
    else
      l_SetAutoFit(FALSE);
    end;
    
    Invalidate;
  end;
end;


procedure TvtStatusPanel.SetText(const Value: AnsiString);
begin
//outputdebugstring(PAnsiChar(value));
  if FText <> Value then
  begin
//outputdebugstring(PAnsiChar(ftext));
    FText := Value;
//outputdebugstring(PAnsiChar(ftext));
    Invalidate;
    UpdateAutoFitWidth;
    if PanelType = sptAction then
     StatusBar.UpdatePanelsWidth;
  end;
end;

procedure TvtStatusPanel.SetTimeFormat(const Value: AnsiString);
begin
  if FTimeFormat <> Value then
  begin
    FTimeFormat := Value;
    UpdateDateTime;
  end;
end;

procedure TvtStatusPanel.SetWidth(const Value: Integer);
begin
  if ((not FAutoFit) or (csLoading in StatusBar.ComponentState)) and
     (LinkedPanel.Width <> Value) then
    LinkedPanel.Width := Value;
  if (PanelType = sptGauge) and (GaugeAttrs.Style in IndeterminateGuages) then
  begin
    FGaugeLastPos := 0;
    FGaugeDirection := GaugeAttrs.Speed;
    Invalidate;
  end;
end;

procedure TvtStatusPanel.TimerNotification;
begin
  if PanelType in [sptDate, sptTime, sptDateTime, sptTimeDate] then
    UpdateDateTime
  else if (PanelType = sptGauge) and (GaugeAttrs.Style in IndeterminateGuages) then
    // Call Redraw directly. It will take care of erasing the old part.  If we
    // used Invalidate, the background would get erased, too, and it would
    // flicker a lot.
    Redraw(StatusBar.Canvas, StatusBar.GetPanelRect(Index));
end;

procedure TvtStatusPanel.UpdateAutoFitWidth;
begin
  if FAutoFit and
     (StatusBar <> NIL) and (StatusBar.HandleAllocated) AND
     (Index >= 0)
     // http://mdp.garant.ru/pages/viewpage.action?pageId=321983826
     then
  begin
    if PanelType = sptGlyph then
    begin
      if Text = '' then
        LinkedPanel.Width := BorderWidth + Glyph.Width + 4
      else
        LinkedPanel.Width := StatusBar.TextExtent(Text).cx + 2 +
          (BorderWidth * 2) + Glyph.Width + 4;
    end
    else
      if (PanelType = sptAction) and Assigned(StatusBar.Images) and (ImageIndex <> -1) then
      begin
       if not CalculatedShowActionCaption or (Text = '') then
         LinkedPanel.Width := (BorderWidth * 2) + StatusBar.Images.Width + 8
       else
         LinkedPanel.Width := StatusBar.TextExtent(Text, True).cx + 2 +
           (BorderWidth * 2) + StatusBar.Images.Width + 19;
      end
      else
       if (PanelType = sptGauge) then
        LinkedPanel.Width := cGaugeWidth
       else
        LinkedPanel.Width := StatusBar.TextExtent(Text, PanelType = sptAction).cx + 6 + BorderWidth;
  end;
  Invalidate;
end;

procedure TvtStatusPanel.UpdateDateTime;
var
  Fmt: AnsiString;
  Txt: AnsiString;
begin
  case PanelType of
    sptDate:
      if DateFormat = '' then
        Fmt := {$IfDef XE}FormatSettings.{$EndIf}ShortDateFormat
      else
        Fmt := DateFormat;
    sptTime:
      if TimeFormat = '' then
        Fmt := {$IfDef XE}FormatSettings.{$EndIf}LongTimeFormat
      else
        Fmt := TimeFormat;
    sptDateTime:
      begin
        if DateFormat = '' then
          Fmt := {$IfDef XE}FormatSettings.{$EndIf}ShortDateFormat
        else
          Fmt := DateFormat;
        if TimeFormat = '' then
          Fmt := Fmt + ' ' + {$IfDef XE}FormatSettings.{$EndIf}LongTimeFormat
        else
          Fmt := Fmt + ' ' + TimeFormat;
      end;
    sptTimeDate:
      begin
        if TimeFormat = '' then
          Fmt := {$IfDef XE}FormatSettings.{$EndIf}LongTimeFormat
        else
          Fmt := TimeFormat;
        if DateFormat = '' then
          Fmt := Fmt + ' ' + {$IfDef XE}FormatSettings.{$EndIf}ShortDateFormat
        else
          Fmt := Fmt + ' ' + DateFormat;
      end;
  end;
  Txt := FormatDateTime(Fmt, Now);
  if Txt <> Text then
  begin
    Text := Txt;
    //    Invalidate(TRUE);
    Redraw(Statusbar.Canvas, StatusBar.GetPanelRect(Index));
  end;
end;

procedure TvtStatusPanel.GlyphChanged(Sender: TObject);
begin
  if PanelType = sptGlyph then
  begin
    Invalidate;
    UpdateAutoFitWidth;
  end;
end;


procedure TvtStatusPanel.DrawPanel(Rect: TRect);
begin
  if (csDesigning in StatusBar.ComponentState) or (Addr(OnDrawPanel) = NIL) or
     (PanelType <> sptOwnerDraw) then
    Redraw(StatusBar.Canvas, StatusBar.GetPanelRect(Index))
  else if assigned(FOnDrawPanel) then
    FOnDrawPanel(StatusBar, Self, Rect);
end;


function TvtStatusPanel.GetEnabled: boolean;
begin
  if csWriting in StatusBar.ComponentState then
    Result := FEnabled
  else
    Result := FEnabled and StatusBar.Enabled;
end;

procedure TvtStatusPanel.EnabledChanged;
begin
  // Enabled property (self or parent) _changed, update register/deregister calls
  if FPanelType = sptAction then
   StatusBar.CheckActionAutopopup(ToolTipID, Enabled);
  if Enabled then
  begin
    case FPanelType of
      sptDate, sptTime, sptDateTime, sptTimeDate:
        TvtStatusPanels(Collection).RegisterTimer(Self);
      sptGauge:
        if GaugeAttrs.Style in IndeterminateGuages then
          TvtStatusPanels(Collection).RegisterTimer(Self);
    end;
  end else begin
    case FPanelType of
      sptDate, sptTime, sptDateTime, sptTimeDate:
        TvtStatusPanels(Collection).DeregisterTimer(Self);
      sptGauge:
        if GaugeAttrs.Style in IndeterminateGuages then
          TvtStatusPanels(Collection).DeregisterTimer(Self);
    end;
  end;

  Invalidate;
  if not Enabled then
  begin
    FGaugeLastPos := 0;
    FGaugeDirection := GaugeAttrs.Speed;
  end;
end;


function TvtStatusPanel.GetHint: AnsiString;
begin
  if (not (csDesigning in StatusBar.ComponentState)) and
     (PanelType in [sptEllipsisText, sptEllipsisPath]) and (FHint = '...') then
    Result := Text
  else
    Result := FHint;
  DoHintText(Result);
end;

procedure TvtStatusPanel.DoHintText(var HintText: AnsiString);
begin
  if assigned(FOnHintText) then
    FOnHintText(StatusBar, Self, HintText);
end;

procedure TvtStatusPanel.SetGaugeAttrs(const Value: TvtGaugeAttrs);
begin
  FGaugeAttrs := Value;
end;

function TvtStatusPanel.GetDisplayName: String;
begin
  case PanelType of
    sptNormal, sptEllipsisText, sptEllipsisPath:
      Result := Text;
  else
    Result := GetEnumName(TypeInfo(TvtStatusPanelType), ord(PanelType));
  end;

  if Result = '' then
    Result := inherited GetDisplayName;
end;

procedure TvtStatusPanel.SetIndex(Value: integer);
var
  CurIndex: Integer;
begin
  CurIndex := Index;
  if (CurIndex >= 0) and (CurIndex <> Value) then
  begin
    TvtStatusPanels(Collection).FLinkedPanels[CurIndex].Index := Value;
    inherited SetIndex(Value);
  end;
end;

function TvtStatusPanel.GetLinkedPanel: TStatusPanel;
begin
  Result := TvtStatusPanels(Collection).FLinkedPanels[Index];
end;

procedure TvtStatusPanel.Click;
var
 l_P : TvtStatusPanel;
begin
 l_P := Use;
 try
  if assigned(FOnClick) then
    FOnClick(Self);
  if PanelType = sptAction then
   if (StatusBar <> nil) then
    StatusBar.PanelActionExecuted(Self);
 finally
  FreeAndNil(l_P);
 end;//try..finally  
end;

function TvtStatusPanel.GetGaugeBitmap: TBitmap;
begin
  if FGaugeBitmap = NIL then
    FGaugeBitmap := InitGaugeBitmap;
  Result := FGaugeBitmap;
end;

procedure TvtStatusPanel.SetBorderWidth(const Value: TBorderWidth);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    UpdateAutoFitWidth;
    Invalidate;
  end;
end;

function TvtStatusPanel.IsTextStored: Boolean;
begin
  Result := not (PanelType in [sptDate, sptTime, sptDateTime, sptTimeDate]);
end;

function CorrectFont(Font: HFONT; ChangeSize: Integer): HFONT;
var
  LF: TLogFont;
begin
  if Font <> 0 then
  begin
    GetObject(Font, SizeOf(LF), @LF);
    LF.lfUnderline := 1;
    if ChangeSize <> 0 then
     LF.lfHeight := -MulDiv(-MulDiv(LF.lfHeight, 72, Screen.PixelsPerInch) + ChangeSize, Screen.PixelsPerInch, 72);
    Result := CreateFontIndirect(LF);
  end else
    Result := 0;
end;

procedure TvtStatusPanel.DrawAction(Canvas: TCanvas; R: TRect);
const
  TEXT_SPACE = 2;
var
  TW: integer;
  GR: TRect;
  OldColor: TColorRef;
  OldFont: THandle;
  NewFont: THandle;
  l_TextOffset: Integer;
begin
  GR := R;
  if CalculatedShowActionCaption and (Text <> '') then
    TW := Canvas.TextWidth(Text) + TEXT_SPACE
  else
    TW := 0;

  if Assigned(StatusBar) and Assigned(StatusBar.Images) and (ImageIndex <> -1) then
  begin
   if (Alignment = taCenter) then
      with GR do
        Left := Left + ((Right - Left - StatusBar.Images.Width - TW) div 2)
   else if Alignment = taRightJustify then
     GR.Left := GR.Right - StatusBar.Images.Width;

   GR.Top := GR.Top + (GR.Bottom - GR.Top - StatusBar.Images.Height) div 2;
   StatusBar.Images.Draw(Canvas, GR.Left + 2, GR.Top, ImageIndex, Enabled);
   l_TextOffset := StatusBar.Images.Width + TEXT_SPACE + 2;
  end
  else
   l_TextOffset := 0;
  if CalculatedShowActionCaption and (Text <> '') then
  begin
    OldColor := GetTextColor(Canvas.Handle);
    NewFont := CorrectFont(Canvas.Font.Handle, 1);
    OldFont := SelectObject(Canvas.Handle, NewFont);
    if Enabled then
     SetTextColor(Canvas.Handle, ColorToRGB(clBlue))
    else
     SetTextColor(Canvas.Handle, ColorToRGB(clGrayText));
    case Alignment of
      taLeftJustify,
      taCenter:
        begin
          GR.Left := GR.Left + l_TextOffset;
          GR.Top := R.Top;
          GR.Bottom := R.Bottom;
          DrawText(Canvas.Handle, PAnsiChar(Text), -1, GR, DT_SINGLELINE or
            DT_NOPREFIX or DT_VCENTER);
        end;
      taRightJustify:
        begin
          GR.Left := GR.Left - TW - TEXT_SPACE;
          GR.Top := R.Top;
          GR.Bottom := R.Bottom;
          DrawText(Canvas.Handle, PAnsiChar(Text), -1, GR, DT_SINGLELINE or
            DT_NOPREFIX or DT_VCENTER);
        end;
    end;
    SetTextColor(Canvas.Handle, OldColor);
    SelectObject(Canvas.Handle, OldFont);
    DeleteObject(NewFont);
  end;
end;

procedure TvtStatusPanel.SetAction(aValue: TBasicAction);
begin
 if (aValue = nil) or (StatusBar = nil) then
  FreeAndNil(FActionLink)
 else
 begin
  if FActionLink = nil then
    FActionLink := TvtStatusPanelActionLink.Create(Self);
  FActionLink.Action := aValue;
  FActionLink.OnChange := DoActionChange;
  ActionChange(aValue, csLoading in aValue.ComponentState);
  UpdateAutoFitWidth;
  aValue.FreeNotification(StatusBar);
 end;
{$IFNDEF DesignTimeLibrary}
{$IfNDef XE}
 if Assigned(StatusBar) then
  StatusBar.ActionRefChanged;
{$EndIf  XE}
{$ENDIF DesignTimeLibrary}  
end;

procedure TvtStatusPanel.InitiateAction;
begin
 if Assigned(FActionLink) then
  FActionLink.Update;
end;

function TvtStatusPanel.GetAction: TBasicAction;
begin
 if Assigned(FActionLink) then
  Result := FActionLink.Action
 else
  Result := nil;
end;

procedure TvtStatusPanel.DoActionChange(Sender: TObject);
begin
 if Sender = Action then ActionChange(Sender, False);
end;

procedure TvtStatusPanel.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
 if (Sender is TCustomAction) and (PanelType = sptAction) then
  with TCustomAction(Sender) do
  begin
   if not CheckDefaults or (Self.Text = '') then
    Self.Text := Caption;
   if not CheckDefaults or (Self.Hint = '') then
    Self.Hint := Hint;
   if not CheckDefaults or (Self.Enabled = True) then
    Self.Enabled := Enabled;
   if not CheckDefaults or (Self.Hint = '') then
    Self.Hint := Hint;
   if not CheckDefaults or (Self.ImageIndex = -1) then
    Self.ImageIndex := ImageIndex;
   if not CheckDefaults or not Assigned(Self.OnClick) then
    Self.OnClick := OnExecute;
  end;
end;

procedure TvtStatusPanel.SetCollection(Value: TCollection);
begin
 if Value = nil then
  Action := nil;
 inherited SetCollection(Value);
end;

procedure TvtStatusPanel.SetImageIndex(Value: TImageIndex);
begin
 if FImageIndex <> Value then
 begin
   FImageIndex := Value;
   if PanelType = sptAction then
   begin
    UpdateAutoFitWidth;
   StatusBar.UpdatePanelsWidth;
    Invalidate;
   end;
 end;
end;

procedure TvtStatusPanel.pm_SetShowActionCaption(const Value: Boolean);
begin
 if f_ShowActionCaption <> Value then
 begin
  f_ShowActionCaption := Value;
  if PanelType = sptAction then
  begin
   UpdateAutoFitWidth;
   StatusBar.UpdatePanelsWidth;
   Invalidate;
  end;
 end;
end;

function TvtStatusPanel.CalculatedShowActionCaption: Boolean;
begin
 Result := ShowActionCaption or (StatusBar.Images = nil) or (ImageIndex = -1);
end;

function TvtStatusPanel.AdjustedHint: String;
begin
 Result := Hint;
 if (PanelType = sptAction) and Assigned(Action) and (Action is TCustomAction) and
  TCustomAction(Action).DoHint(Result) and Application.HintShortCuts and
  (TCustomAction(Action).ShortCut <> scNone) and (Hint <> '') then
   Result := Format('%s (%s)', [Result, ShortCutToText(TCustomAction(Action).ShortCut)])
end;

{ TvtStatusPanels }

function TvtStatusPanels.Add: TvtStatusPanel;
begin
  Result := TvtStatusPanel(inherited Add);
end;

procedure TvtStatusPanels.BeginUpdate;
begin
 inherited BeginUpdate;
 FLinkedPanels.BeginUpdate;
end;

constructor TvtStatusPanels.Create(StatusBar: TvtCustomStatusBar;
   LinkedPanels: TStatusPanels);
begin
  FStatusBar := StatusBar;
  FLinkedPanels := LinkedPanels;
  FTimer := NIL;
  FTimerClients := TList.Create;

  inherited Create(TvtStatusPanel);
end;

procedure TvtStatusPanels.DeregisterTimer(Client: TvtStatusPanel);
var
  x: integer;
  NewTimerRes: integer;
begin
  if FTimerClients.Remove(Client) <> -1 then
    dec(RegisteredTimers);
  if FTimerClients.Count < 1 then
  begin
    FTimer.Free;
    FTimer := NIL;
  end else begin
    NewTimerRes := 60000; // Least impact we can manage easily
    for x := 0 to FTimerClients.Count-1 do
      case TvtStatusPanel(FTimerClients[x]).PanelType of
        sptTime, sptDateTime, sptTimeDate:
          NewTimerRes := 1000;
        sptGauge:
          if TvtStatusPanel(FTimerClients[x]).GaugeAttrs.Style in
             IndeterminateGuages then begin
            NewTimerRes := INDETERMINATE_GAUGE_UPDATE_INTERVAL;
            break;
          end;
      end;

    FTimer.Interval := NewTimerRes;
  end;
end;

destructor TvtStatusPanels.Destroy;
begin
  // Call inherited first because it causes children to be destroyed, and that
  // might cause FTimerClients to be needed.
  inherited Destroy;

  FTimer.Free;
  FTimer := NIL;
  FTimerClients.Free;
  FTimerClients := NIL; // Yes, there is a reason for this!
end;

procedure TvtStatusPanels.EndUpdate;
begin
 FLinkedPanels.EndUpdate;
 inherited EndUpdate;
end;

function TvtStatusPanels.GetItem(Index: Integer): TvtStatusPanel;
begin
  Result := TvtStatusPanel(inherited GetItem(Index));
end;

function TvtStatusPanels.GetOwner: TPersistent;
begin
  Result := FStatusBar;
end;

procedure TvtStatusPanels.RegisterTimer(Client: TvtStatusPanel);
var
  FirstClient: boolean;
begin
  if FTimer = NIL then
  begin
    FTimer := TTimer.Create(FStatusBar);
    FLastDate := Date;
    FTimer.OnTimer := TimerEvent;
  end;
  if FTimerClients.IndexOf(Client) >= 0 then
    exit;  // We're already in the list!
    
  FTimerClients.Add(Client);
  inc(RegisteredTimers);
  FirstClient := FTimerClients.Count = 1;
  case Client.PanelType of
    sptDate:
      if FirstClient then
        FTimer.Interval := 60000; // Least impact we can manage easily
    sptTime, sptDateTime, sptTimeDate:
      if FirstClient or (FTimer.Interval > 1000) then
        FTimer.Interval := 1000;
    sptGauge:
      if Client.GaugeAttrs.Style in IndeterminateGuages then
        FTimer.Interval := INDETERMINATE_GAUGE_UPDATE_INTERVAL;
  end;
  FTimer.Enabled := TRUE;
end;

procedure TvtStatusPanels.SetItem(Index: Integer; Value: TvtStatusPanel);
begin
  // I have no idea if this will work or not....
  inherited SetItem(Index, Value);
  FLinkedPanels[Index] := Value.LinkedPanel;
end;

procedure TvtStatusPanels.TimerEvent(Sender: TObject);
var
  x: integer;
  DateUpdate: boolean;
  Panel: TvtStatusPanel;
begin
  if FLastDate <> Date then
  begin
    DateUpdate := TRUE;
    FLastDate := Date;
  end else
    DateUpdate := FALSE;

  for x := 0 to FTimerClients.Count-1 do
  begin
    Panel := TvtStatusPanel(FTimerClients[x]); // shorthand
    if (Panel.PanelType in [sptTime, sptDateTime, sptTimeDate]) or
       (DateUpdate and (Panel.PanelType = sptDate)) or
       ((Panel.PanelType = sptGauge) and
       (Panel.GaugeAttrs.Style in IndeterminateGuages)) then
      TvtStatusPanel(FTimerClients[x]).TimerNotification;
  end;
end;

procedure TvtStatusPanels.Update(Item: TCollectionItem);
begin
  if Item is TvtStatusPanel then
    TvtStatusPanel(Item).Invalidate
  else
    FStatusBar.Invalidate;
end;

{ TvtStatusBar }

constructor TvtCustomStatusBar.Create(AOwner: TComponent);
begin
  FExtentCanvas := CreateCompatibleDC(0);
  FExtentFont := 0;
  FExtentFontOld := 0;

  inherited Create(AOwner);
  Color := cDefBack;
  
  ParentFont := True;
  //FUseSystemFont := True;
  // Allow it to accept controls dropped onto it.
  ControlStyle:= ControlStyle + [csAcceptsControls];

  FPanels := TvtStatusPanels.Create(Self, inherited Panels);
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
end;

procedure TvtCustomStatusBar.InvalidatePanel(Index: integer);
var
  PanelRect: TRect;
begin
  if (Index >= 0) and (Index < Panels.Count) then
  begin
    PanelRect := GetPanelRect(Index);
    if not IsRectEmpty(PanelRect) then
      Panels[Index].Redraw(Canvas, PanelRect)
  end else begin
    TList.Error(@SListIndexError, Index);
  end;
end;

function TvtCustomStatusBar.GetPanelRect(Index: integer): TRect;
begin
  SetRectEmpty(Result);
  if HandleAllocated then
    if Perform(SB_GETRECT, Index, LPARAM(@Result)) = 0 then
      SetRectEmpty(Result); // SB_GETRECT failed, probably not visible
end;

procedure TvtCustomStatusBar.SetPanels(const Value: TvtStatusPanels);
begin
  FPanels.Assign(Value);
// what about linked Panels????
end;

function TvtCustomStatusBar.PanelsStrored: Boolean;
begin
 Result := (FPanels <> nil) AND (FPanels.Count > 0);
end;

destructor TvtCustomStatusBar.Destroy;
begin
  FreeAndNil(FImageChangeLink);
  FPanels.Free;
  SelectObject(FExtentCanvas, FExtentFontOld);
  if FExtentFont <> 0 then
  begin
    DeleteObject(FExtentFont);
    FExtentFont := 0;
  end;
  if FExtentCanvas <> 0 then
  begin
    DeleteDC(FExtentCanvas);
    FExtentCanvas := 0;
  end;

  inherited;
end;


procedure TvtCustomStatusBar.DrawPanel(Panel: TStatusPanel; const Rect: TRect);
var
  DFSPanel: TvtStatusPanel;
  OldFont: HFONT;
begin
  // Panel is the REAL TStatusPanel, we need to find our special one.
  DFSPanel := FindLinkedPanel(Panel);
  Assert(DFSPanel <> NIL, 'Panel links corrupted');

  // Stupid VCL status bar doesn't always have the right font in Canvas.
  OldFont := SelectObject(Canvas.Handle, FExtentFont);
  try
    if Addr(OnDrawPanel) <> NIL then
      inherited DrawPanel(TStatusPanel(DFSPanel), Rect);
    DFSPanel.DrawPanel(Rect);
  finally
    SelectObject(Canvas.Handle, OldFont);
  end;
end;

function TvtCustomStatusBar.FindLinkedPanel(Panel: TStatusPanel): TvtStatusPanel;
var
  x: integer;
begin
  Result := NIL;
  for x := 0 to Panels.Count-1 do
    if Panels[x].LinkedPanel = Panel then
    begin
      Result := Panels[x];
      break;
    end;
end;

procedure TvtCustomStatusBar.CMFontChanged(var Msg: TMessage);
var
  x: integer;
begin
  inherited;

  UpdateExtentFont;

  if Panels = NIL then exit;

  Panels.BeginUpdate;
  try
    for x := 0 to Panels.Count-1 do
      if Panels[x].AutoFit then
        Panels[x].UpdateAutoFitWidth;
  finally
    Panels.EndUpdate;
  end;
end;

procedure TvtCustomStatusBar.CMEnabledChanged(var Msg: TMessage);
var
  x: integer;
begin
  inherited;
  Invalidate;
  for x := 0 to Panels.Count-1 do
    Panels[x].EnabledChanged;
end;

procedure TvtCustomStatusBar.CMHintShow(var Msg: TMessage);
  function FindClosestBefore(x: integer): TvtStatusPanel;
  var
    y: integer;
  begin
    Result := NIL;
    for y := 0 to Panels.Count-1 do
    begin
      if GetPanelRect(y).Left < x then
        Result := Panels[y]
      else
        break;
    end;
(*  If I do it this way, it screws up.  Optimizaer bug, maybe?
    for y := Panels.Count-1 downto 0 do
    begin
      if GetPanelRect(y).Left < x then
      begin
        Result := Panels[y];
        break;
      end;
    end;*)
  end;

  function FindClosestAfter(x: integer): TvtStatusPanel;
  var
    y: integer;
  begin
    Result := NIL;
    for y := 0 to Panels.Count-1 do
    begin
      if GetPanelRect(y).Right > x then
      begin
        Result := Panels[y];
        break;
      end;
    end;
  end;
var
  Panel: TvtStatusPanel;
  R: TRect;
begin
  inherited;

  with TCMHintShow(Msg) do
  begin
    begin
      Panel := PanelByPt(HintInfo.CursorPos);

      if (Panel = NIL) or (Panel.Hint = '') then
      begin
        // Hit a border, or a Panel without a hint.  What we have to do here is
        // tell the hint info how big of a rectangle the hint applies to.  So,
        // we must find the first Panel before this point with a hint, and the
        // first Panel after this point with a hint and set CursorRect equal to
        // the area between those two Panels.  CursorRect already has the area
        // of the status bar, so if we don't find a Panel, it's ok.

        // Find first valid Panel before hint position and set CursorRect.Left
        Panel := FindClosestBefore(HintInfo.CursorPos.x);
        while (Panel <> NIL) do
        begin
          R := GetPanelRect(Panel.Index);
          if Panel.Hint <> '' then
          begin
            HintInfo.CursorRect.Left := R.Right;
            Panel := NIL;
          end else
            Panel := FindClosestBefore(R.Left);
        end;

        // Find first valid Panel after hint position and set CursorRect.Right
        Panel := FindClosestAfter(HintInfo.CursorPos.x);
        while (Panel <> NIL) do
        begin
          R := GetPanelRect(Panel.Index);
          if Panel.Hint <> '' then
          begin
            HintInfo.CursorRect.Right := R.Left;
            Panel := NIL;
          end else
            Panel := FindClosestAfter(R.Right);
        end;
      end else begin
        // Give it the hint of the Panel
        HintInfo.HintStr := Panel.AdjustedHint;
        // Tell the hint mechanism that it needs to check the hint when the
        // cursor leaves the Panel rectangle.
        HintInfo.CursorRect := GetPanelRect(Panel.Index);
      end;
    end;
  end;
end;

procedure TvtCustomStatusBar.Loaded;
var
  x: integer;
begin
  inherited Loaded;

  UpdateExtentFont;

  for x := 0 to Panels.Count-1 do
    if Panels[x].AutoFit then
      Panels[x].UpdateAutoFitWidth;
end;

procedure TvtCustomStatusBar.CreateWnd;
var
  x: integer;
begin
  inherited CreateWnd;

  if not (csLoading in ComponentState) then
  begin
    UpdateExtentFont;

    for x := 0 to Panels.Count-1 do
      if Panels[x].AutoFit then
        Panels[x].UpdateAutoFitWidth;
  end;

end;

function TvtCustomStatusBar.TextExtent(const Text: AnsiString; NeedCorrect: Boolean = False): TSize;
var
 OldFont: THandle;
 NewFont: THandle;
begin
 if NeedCorrect then
 begin
  NewFont := CorrectFont(FExtentFont, 1);
  OldFont := SelectObject(FExtentCanvas, NewFont);
 end;
 try
  if not GetTextExtentPoint32(FExtentCanvas, PAnsiChar(Text), Length(Text),
     Result) then
  begin
    Result.cx := -1;
    Result.cy := -1;
  end;
 finally
  if NeedCorrect then
  begin
   SelectObject(FExtentCanvas, OldFont);
   DeleteObject(NewFont);
  end;
 end;
end;

procedure TvtCustomStatusBar.UpdateExtentFont;
begin
  if FExtentFont <> 0 then
  begin
    SelectObject(FExtentCanvas, FExtentFontOld);
    DeleteObject(FExtentFont);
  end;

  // In D4, the font handle might be different than what TFont describes!
  FExtentFont := CopyHFont(Font.Handle);
  FExtentFontOld := SelectObject(FExtentCanvas, FExtentFont);
end;

function TvtCustomStatusBar.AllPanelsText : AnsiString;
var
 lIndex : Integer;
begin
 Result := '';
 for lIndex := 0 to Pred(FPanels.Count) do
 begin
  if Result <> '' then
   Result := Result + cPanelTextSeparator;
  Result := Result + FPanels[lIndex].Text;
 end;
end;

procedure TvtCustomStatusBar.WndProc(var Msg: TMessage);

begin
 case Msg.Msg of
  WM_GETTEXT:
   with Msg do
    Result := StrLen(StrPLCopy(PAnsiChar(LParam), AllPanelsText, WParam - 1));
  WM_GETTEXTLENGTH:
   with Msg do
    Result := Length(AllPanelsText);
  else
   inherited WndProc(Msg);
 end;
end;

procedure TvtCustomStatusBar.Click;
var
 l_Panel: TvtStatusPanel;
begin
 l_Panel := FindPanelByMouse;
 if Assigned(l_Panel) then
 begin
  l_Panel.Use;
  try
   l_Panel.Click;
  finally
   FreeAndNil(l_Panel);
  end;//try..finally
 end;//Assigned(l_Panel)
 inherited Click;
end;

procedure TvtCustomStatusBar.WMPaint(var Msg: TWMPaint);
var
 R  : TRect;
 PS : TPaintStruct;
begin
  if InUpdating then
  begin
   BeginPaint(Handle, PS);
   EndPaint(Handle, PS);
   Exit;
  end;//InUpdating
  // в родительких методах запускаетс€ отрисовка панелей
  inherited;
  // рисуем собственный Grip, нужного нам цвета
  if (Color <> clBtnFace) {AND (Color <> cDefBack)} then
   if (afw.GetParentForm(Self).WindowState <> wsMaximized) then
   begin
    R := ClientRect;
    R.Left := R.Right - 15;
    Inc(R.Top, 4);
    Dec(R.Bottom);
    AwfDrawSizeGrip(Canvas.Handle, R, cDefBack);
   end;//Color <> clBtnFace
  {$IfDef Nemesis}
  // рисуем обрамл€ющую рамку статусбара
  R := ClientRect;
  Canvas.Brush.Color := clBtnShadow;
  Canvas.FrameRect(R);
  // убираем верхную и левую кромки
  R.Bottom := R.Top + 3;
  Dec(R.Right);
  Canvas.Brush.Color := Self.Color;
  Canvas.FillRect(R);
  R := ClientRect;
  R.Right := R.Left + 1;
  Canvas.FillRect(R);
  {$EndIf  Nemesis}
end;

procedure TvtCustomStatusBar.WMNCPaint(var Message: TWMNCPaint);
{$IfDef Nemesis}
(*var
 l_DC    : HDC;
 l_Rect  : TRect;
 l_Brush : HBrush;*)
{$EndIf Nemesis}
begin
 inherited ;
 Exit;       // ¬ременно отказываемс€ от WMNCPaint. ѕереносим всю отрисовку в WMPaint 
 
(* {$IfNDef Nemesis}
 inherited;
 {$Else   Nemesis}
 // http://mdp.garant.ru/pages/viewpage.action?pageId=253664876
 // if (BorderStyle = bsSingle) then
 begin
  l_DC := GetWindowDC(Handle);
  try
   GetWindowRect(Handle, l_Rect);
   OffsetRect(l_Rect, -l_Rect.Left, -l_Rect.Top);
   l_Brush := CreateSolidBrush(ColorToRGB(Color));
   try
    Inc(l_Rect.Bottom);
    Inc(l_Rect.Right);
    FillRect(l_DC, l_Rect, l_Brush);
    Dec(l_Rect.Bottom);
    Dec(l_Rect.Right);
   finally
    DeleteObject(l_Brush)
   end;//try..finally
   l_Brush := CreateSolidBrush(ColorToRGB(clBtnShadow));
   try
    FrameRect(l_DC, l_Rect, l_Brush);
   finally
    DeleteObject(l_Brush)
   end;//try..finally
  finally
   ReleaseDC(Handle, l_DC);
  end;//try..finally
  UpdatePanels(False, False);
 end;//BorderStyle = bsSingle
 {$EndIf  Nemesis}
 Message.Result := 0;*)
end;//TvtCustomStatusBar.WMNCPaint

function TvtCustomStatusBar.ExecuteAction(Action: TBasicAction): Boolean;
begin
//  outputdebugstring(PAnsiChar(Panels[0].ftext));
  Result := inherited ExecuteAction(Action);
//  outputdebugstring(PAnsiChar(Panels[0].ftext));
  if Result then
   Invalidate;
//  outputdebugstring(PAnsiChar(Panels[0].ftext));
end;

procedure TvtCustomStatusBar.UpdatePanelsWidth;
var
 l_AutoFitWidth: Integer;
 l_OtherWidth: Integer;
 l_Delta: Integer;
 l_FirstAutoFitIndex: Integer;
 l_GripSize: Integer;
 l_IDX: Integer;
 l_Rect: TRect;
begin
 l_AutoFitWidth := 0;
 l_FirstAutoFitIndex := -1;
 for l_IDX := Panels.Count - 1 downto 0 do
  if Panels[l_IDX].AutoFit then
  begin
   Inc(l_AutoFitWidth, Panels[l_IDX].Width);
   l_FirstAutoFitIndex := l_IDX;
  end
  else
   Break;
 if l_AutoFitWidth > 0 then
 begin

  l_GripSize := 0;
  for l_IDX := Panels.Count-1 downto 0 do
   if SendMessage(Handle, SB_GETRECT, l_IDX, LongInt(@l_Rect)) <> 0 then
   begin
    l_GripSize := ClientWidth - l_Rect.Right;
    Break;
   end;

  l_OtherWidth := 0;
  for l_IDX := 0 to l_FirstAutoFitIndex - 2 do
   Inc(l_OtherWidth, Panels[l_IDX].Width);
  l_Delta := ClientWidth - l_GripSize - l_OtherWidth - l_AutoFitWidth;
  if l_Delta >= 0 then
   Panels[l_FirstAutoFitIndex - 1].Width := l_Delta
  else
  begin
   l_IDX := l_FirstAutoFitIndex - 1;
   while (l_Delta < 0) and (l_IDX >= 0) do
   begin
    if Panels[l_IDX].Width + l_Delta >= 0 then
    begin
     Panels[l_IDX].Width := Panels[l_IDX].Width + l_Delta;
     l_Delta := 0
    end
    else
    begin
     inc(l_Delta, Panels[l_IDX].Width);
     Panels[l_IDX].Width := 0;
    end;
    Dec(l_IDX);
   end;
  end;
 end;
end;

procedure TvtCustomStatusBar.Resize;
begin
 UpdatePanelsWidth;
 inherited Resize;
end;

procedure TvtCustomStatusBar.Notification(AComponent: TComponent;
  Operation: TOperation);
var
 l_IDX: Integer;  
begin
 inherited Notification(aComponent, Operation);
 if Operation = opRemove then
 begin
  if aComponent is TBasicAction then
  begin
   for l_IDX := 0 to Panels.Count - 1 do
    if Panels[l_IDX].Action = aComponent then
     Panels[l_IDX].Action := nil;
  end
  else
  if (AComponent = Images) then
    Images := nil;
 end;
end;

{$IFNDEF DesignTimeLibrary}
{$IfNDef XE}
function TvtCustomStatusBar.IsActionLinked: Boolean;
var
 l_IDX: Integer;
begin
 Result := inherited IsActionLinked;
 if not Result then
  for l_IDX := 0 to Panels.Count - 1 do
   if (Panels[l_IDX].PanelType = sptAction) and Assigned(Panels[l_IDX].Action) then
   begin
    Result := True;
    Break;
   end;
end;
{$EndIf XE}
{$ENDIF DesignTimeLibrary}

procedure TvtCustomStatusBar.InitiateAction;
var
 l_IDX: Integer;
begin
 inherited InitiateAction;
 for l_IDX := 0 to Panels.Count - 1 do
  Panels[l_IDX].InitiateAction;
end;

{ TvtStatusPanelActionLink }

procedure TvtStatusPanelActionLink.AssignClient(AClient: TObject);
begin
 inherited;
 FClient := AClient as TvtStatusPanel;
end;

function TvtStatusPanelActionLink.IsCaptionLinked: Boolean;
begin
 Result := inherited IsCaptionLinked and
   (FClient.Text = (Action as TCustomAction).Caption);
end;

function TvtStatusPanelActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

function TvtStatusPanelActionLink.IsHintLinked: Boolean;
begin
 Result := inherited IsCaptionLinked and
   (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TvtStatusPanelActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

function TvtStatusPanelActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and
    (@FClient.OnClick = @Action.OnExecute);
end;

procedure TvtStatusPanelActionLink.SetCaption(const Value: String);
begin
 if IsCaptionLinked then FClient.Text := Value;
end;

procedure TvtStatusPanelActionLink.SetEnabled(Value: Boolean);
begin
 if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TvtStatusPanelActionLink.SetHint(const Value: String);
begin
 if IsHintLinked then FClient.Hint := Value;
end;

procedure TvtStatusPanelActionLink.SetImageIndex(Value: Integer);
begin
 if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

procedure TvtStatusPanelActionLink.SetOnExecute(Value: TNotifyEvent);
begin
 if IsOnExecuteLinked then FClient.OnClick := Value;
end;

procedure TvtCustomStatusBar.SetImages(const aValue: TCustomImageList);
begin
 if Images <> nil then
   Images.UnRegisterChanges(FImageChangeLink);
 FImages := aValue;
 if Images <> nil then
 begin
   Images.RegisterChanges(FImageChangeLink);
   Images.FreeNotification(Self);
 end;
 ImageListChange(Images);
end;

procedure TvtCustomStatusBar.ImageListChange(Sender: TObject);
var
 l_IDX: Integer;
begin
 for l_IDX := 0 to Panels.Count - 1 do
  if (Panels[l_IDX].PanelType = sptAction) then
   Panels[l_IDX].Invalidate;
end;

procedure TvtCustomStatusBar.WMSetCursor(var Message: TWMSetCursor);
var
 l_Panel: TvtStatusPanel;
begin
 with Message do
  if (CursorWnd = Handle) and (Smallint(HitTest) = HTCLIENT) then
  begin
   l_Panel := FindPanelByMouse;
   if Assigned(l_Panel) and (l_Panel.PanelType = sptAction) and l_Panel.Enabled then
   begin
    Windows.SetCursor(Screen.Cursors[crHandPoint]);
    Result := 1;
   end
   else
    inherited;
  end
  else
   inherited;
end;                            

function TvtCustomStatusBar.FindPanelByMouse: TvtStatusPanel;
var
  CursorPos: TPoint;
begin
  GetCursorPos(CursorPos);
  Result := PanelByPt(ScreenToClient(CursorPos));
end;

function TvtCustomStatusBar.InUpdating: Boolean;
begin
 Result := HandleAllocated AND Visible AND afw.IsObjectLocked(Self);
end;

function TvtCustomStatusBar.PanelByPt(const aPt: TPoint): TvtStatusPanel;
var
 l_IDX: Integer;
begin
 Result := nil;
 for l_IDX := 0 to Panels.Count-1 do
 begin
  if PtInRect(GetPanelRect(l_IDX), aPt) then
  begin
   Result := Panels[l_IDX];
   break;
  end;
 end;
end;

procedure TvtCustomStatusBar.PanelActionExecuted(aClient: TvtStatusPanel);
begin
// Do nothing;
end;

procedure TvtCustomStatusBar.DblClick;
var
 l_Panel: TvtStatusPanel;
begin
 l_Panel := FindPanelByMouse;
 if Assigned(l_Panel) and (l_Panel.PanelType = sptAction) then
  l_Panel.Click;
 inherited DblClick;
end;

procedure TvtCustomStatusBar.CheckActionAutopopup(aID: LongWord; aEnabled: Boolean);
begin

end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtStatusBar.pas initialization enter'); {$EndIf}
  RegisteredTimers := 0;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtStatusBar.pas initialization leave'); {$EndIf}
finalization

  // remove hook just in case it somehow got left installed
  Assert(RegisteredTimers = 0, 'TvtStatusBar: Unbalanced timer registrations');

end.
