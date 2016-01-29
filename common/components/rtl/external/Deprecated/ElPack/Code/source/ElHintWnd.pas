{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

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

(*

07/11/2002

  Fixed the problem with charset not being set for HTML rendering engine

*)

unit ElHintWnd;  { TElHintWindow component. }

interface

uses
{$ifdef VCL_6_USED}
  Types,
{$endif}
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  SysUtils,
  Classes,
{$IFDEF HAS_HTML_RENDER}
  HTMLRender,
{$ENDIF}
  ElVCLUtils,
  ElStrUtils
  ;

type
  TElHintWindow = class(THintWindow)
  protected
    FFont : TFont;
    FActivating : boolean;
    {$ifdef ELPACK_UNICODE}
    FWideCaption : WideString;
    {$endif}
{$IFDEF HAS_HTML_RENDER}
    FRender : TElHTMLRender;
    FIsHTML : boolean;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FOnImageNeeded : TElHTMLImageNeededEvent;
{$ENDIF}
    procedure SetFont(newValue : TFont);
  protected
    FWordWrap: Boolean;
{$ifdef HAS_HTML_RENDER}
    procedure TriggerLinkClickEvent(HRef : TElFString); virtual;
    procedure TriggerImageNeededEvent(Sender: TObject; Src : TElFString; var Image : TBitmap); virtual;
{$endif}
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        override;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure SetWordWrap(Value: Boolean);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;

    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
    {$ifdef ELPACK_UNICODE}
    function CalcHintRectW(MaxWidth: Integer; const AHint: WideString; AData: Pointer): TRect;
    procedure ActivateHintW(Rect: TRect; const AHint: WideString); virtual;
    {$endif}
    property Canvas;
  published
    property Font : TFont read FFont write SetFont;  { Published }
    property WordWrap: Boolean read FWordWrap write SetWordWrap default false;
    {$ifdef ELPACK_UNICODE}
    property WideCaption : WideString read FWideCaption write FWideCaption;
    {$endif}
{$IFDEF HAS_HTML_RENDER}
    property IsHTML : boolean read FIsHTML write FIsHTML;
    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write
        FOnLinkClick;
{$ENDIF}
  end;  { TElHintWindow }

{$ifdef ELPACK_UNICODE}
function GetUnicodeHint(Hint : string) : WideString;
{$endif}

implementation

const WrapFlags : array[boolean] of Integer
      = (0, DT_WORDBREAK);

{$ifdef ELPACK_UNICODE}
function GetUnicodeHint(Hint : string) : WideString;
var i : integer;
begin
  result := Hint;
  if (Length(Hint) > 4) then
  begin
    if Copy(Hint, Length(Hint) - 3, 4) = #00#00#$FE#$FF then
    begin
      i := StrLen(PChar(Hint)) + 1;
      SetLength(result, (Length(Hint) - i - 4) div 2);
      Move(Hint[i + 1], Result[1], Length(Result) * 2);
    end;
  end;
end;
{$endif}

{$ifdef HAS_HTML_RENDER}
procedure TElHintWindow.TriggerImageNeededEvent(Sender: TObject; Src : TElFString; var Image : TBitmap);
begin
  if assigned (FOnImageNeeded) then
    FOnImageNeeded(Self, Src, Image);
end;
{$endif}

{$ifdef ELPACK_UNICODE}
function TElHintWindow.CalcHintRectW(MaxWidth: Integer; const AHint: WideString; AData: Pointer): TRect;
begin
{$IFDEF HAS_HTML_RENDER}
  if IsHTML then
  begin
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := Color;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.PrepareText(AHint, 0, false);
    Result := Rect(0, 0, FRender.Data.TextSize.cx, FRender.Data.TextSize.cy + 2);
    Inc(Result.Right, 6);
    Inc(Result.Bottom, 2);
  end
  else
{$ENDIF}
  begin
    Canvas.Font.Assign(Font);
    Result := Rect(0, 0, MaxWidth, 0);
    ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(AHint), -1, Result,
              DT_CALCRECT or DT_LEFT or WrapFlags[WordWrap] or DT_NOPREFIX
              {$ifdef VCL_4_USED}
              or DrawTextBiDiModeFlagsReadingOnly
              {$endif}
              );
    Inc(Result.Right, 6);
    Inc(Result.Bottom, 2);
  end;
end;

procedure TElHintWindow.ActivateHintW(Rect: TRect; const AHint: WideString);
begin
  FActivating := true;
  FWideCaption := AHint;

  Inc(Rect.Bottom, 4);

  UpdateBoundsRect(Rect);

  {$ifdef VCL_4_USED}
  if Rect.Top + Height > Screen.DesktopHeight then
    Rect.Top := Screen.DesktopHeight - Height;
  if Rect.Left + Width > Screen.DesktopWidth then
    Rect.Left := Screen.DesktopWidth - Width;
  if Rect.Left < Screen.DesktopLeft then
    Rect.Left := Screen.DesktopLeft;
  if Rect.Bottom < Screen.DesktopTop then
    Rect.Bottom := Screen.DesktopTop;
  {$else}
  if Rect.Top + Height > Screen.Height then
    Rect.Top := Screen.Height - Height;
  if Rect.Left + Width > Screen.Width then
    Rect.Left := Screen.Width - Width;
  if Rect.Left < 0 then Rect.Left := 0;
  if Rect.Bottom < 0 then Rect.Bottom := 0;
  {$endif}
  SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, Width, Height,
    SWP_SHOWWINDOW or SWP_NOACTIVATE);
  FActivating := false;
  Invalidate;
end;
{$endif ELPACK_UNICODE}

function TElHintWindow.CalcHintRect;
begin
{$IFDEF HAS_HTML_RENDER}
  if IsHTML then
  begin
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := Color;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.PrepareText(AHint, 0, false);
    Result := Rect(0, 0, FRender.Data.TextSize.cx, FRender.Data.TextSize.cy + 2);
    Inc(Result.Right, 6);
    Inc(Result.Bottom, 2);
  end else
{$ENDIF}
  begin
    Canvas.Font.Assign(Font);
    Result := Rect(0, 0, MaxWidth, 0);
    DrawText(Canvas.Handle, PChar(AHint), Length(AHint), Result,
              DT_CALCRECT or DT_LEFT or WrapFlags[WordWrap] or DT_NOPREFIX
              {$ifdef VCL_4_USED}
              or DrawTextBiDiModeFlagsReadingOnly
              {$endif}
              );

    Inc(Result.Right, 6);
    Inc(Result.Bottom, 2);
  end;
end;

procedure TElHintWindow.Paint;  { public }
var R: TRect;
begin
  R := ClientRect;
  Canvas.Font.Assign(Font);

  Inc(R.Left, 2);
  Inc(R.Top, 2);


{$IFDEF HAS_HTML_RENDER}
  if IsHTML then
  begin

    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := Color;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    {$ifdef ELPACK_UNICODE}
    FRender.PrepareText(FWideCaption, 0, false);
    {$else}
    FRender.PrepareText(Caption, 0, false);
    {$endif}
    FRender.DrawText(Canvas, Point(0, 0), R, clNone);
  end
  else
{$ENDIF}
  begin
    {$ifdef ELPACK_UNICODE}
    ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(FWideCaption), -1, R, DT_LEFT or DT_NOPREFIX or WrapFlags[WordWrap]);
    {$else}
    DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or WrapFlags[WordWrap]);
    {$endif}
  end;
end; { Paint }

procedure TElHintWindow.SetFont(newValue : TFont);
{ Sets data member FFont to newValue. }
begin
  FFont.Assign(newValue);
end;  { SetFont }

destructor TElHintWindow.Destroy;
begin
  FFont.Free;
{$IFDEF HAS_HTML_RENDER}
   FRender.Free;
{$ENDIF}
  inherited Destroy;
end;  { Destroy }

constructor TElHintWindow.Create(AOwner : TComponent);
{ Creates an object of type TElHintWindow, and initializes properties. }
begin
  inherited Create(AOwner);
  FFont := TFont.Create;
{$IFDEF HAS_HTML_RENDER}
   FRender := TElHTMLRender.Create;
   FRender.OnImageNeeded := TriggerImageNeededEvent;
{$ENDIF}
end;  { Create }

{$ifdef HAS_HTML_RENDER}
procedure TElHintWindow.TriggerLinkClickEvent(HRef : TElFString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }
{$endif}

procedure TElHintWindow.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
    Y: Integer);
{$ifdef HAS_HTML_RENDER}
var href : TElFString;
{$endif}
begin
{$ifdef HAS_HTML_RENDER}
  FRender.Data.DefaultColor := Font.Color;
  FRender.Data.DefaultBgColor := Color;

  FRender.Data.DefaultStyle := Font.Style;
  FRender.Data.DefaultHeight := Font.Height;
  FRender.Data.DefaultFont := Font.Name;
  if FRender.IsCursorOverLink(Point(X - 2, Y - 2), Point(0, 0), Rect(2, 2, ClientWidth - 2, ClientHeight - 2), href) then
  begin
    TriggerLinkClickEvent(href);
    exit;
  end;
{$endif}
  inherited;
end;


procedure TElHintWindow.CMTextChanged(var Message: TMessage);
var HRect : TRect;
begin
  if FActivating then Exit;
  {$ifdef ELPACK_UNICODE}
  HRect := CalcHintRectW(10000, FWideCaption, nil);
  {$else}
  HRect := CalcHintRect(10000, Caption, nil);
  {$endif}

  Width := HRect.Right - HRect.Left;
  Height := HRect.Bottom - HRect.Top;
end;

procedure TElHintWindow.SetWordWrap(Value: Boolean);
var HRect : TRect;
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    if FActivating then Exit;

    {$ifdef ELPACK_UNICODE}
    HRect := CalcHintRectW(10000, FWideCaption, nil);
    {$else}
    HRect := CalcHintRect(10000, Caption, nil);
    {$endif}

    Width := HRect.Right - HRect.Left;
    Height := HRect.Bottom - HRect.Top;
  end;
end;

end.
