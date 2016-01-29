unit fcLabel;

{
//
// Components : TfcCustomLabel, TfcLabel
//
// Copyright (c) 1999 by Woll2Woll Software
//
}

interface

{$i fcIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Math, fcCommon, fcText;

type
  TfcCustomLabel = class(TGraphicControl)
  private
    // Property Storage Variables
    FAutoSize: Boolean;
    FFocusControl: TWinControl;
    FTextOptions: TfcCaptionText;

    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    function GetTransparent: Boolean;
    procedure SetFocusControl(Value: TWinControl);
    procedure SetTransparent(Value: Boolean);

    // Message Handlers
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMMouseEnter(var Message: TWMMouse); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TWMMouse); message CM_MOUSELEAVE;
  protected
    // Virtual Property Access Methods
    procedure SetAutoSize(Value: Boolean); virtual;

    // Virtual Methods
    procedure MouseEnter; virtual;
    procedure MouseLeave; virtual;

    // Overriden Methods
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;

    property Canvas;
  public
    Patch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetTextEnabled: Boolean; virtual;
    procedure AdjustBounds; virtual;

    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property TextOptions: TfcCaptionText read FTextOptions write FTextOptions;
    property Transparent: Boolean read GetTransparent write SetTransparent default False;

    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TfcLabel = class(TfcCustomLabel)
  published
    {$ifdef fcDelphi4Up}
    property Anchors;
    property Constraints;
    {$endif}
    property Align;
    property AutoSize;
    property Caption;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TextOptions;
    property Transparent;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

implementation

// IUnknown

constructor TfcCustomLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle + [csOpaque, csReplicatable];
  FTextOptions := TfcCaptionText.Create(MakeCallbacks(Invalidate, AdjustBounds, GetTextEnabled),
    Canvas, Font);

  FAutoSize := True;
  Height := 17;
  Width := 65;
end;

destructor TfcCustomLabel.Destroy;
begin
  FTextOptions.Free;
  inherited;
end;

procedure TfcCustomLabel.Paint;
begin
  with Canvas do
  begin
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(ClientRect);
    end;
    Brush.Style := bsClear;
    TextOptions.TextRect := ClientRect;

    // Correct for alignment
    TextOptions.Draw;
  end;
end;

function TfcCustomLabel.GetTextEnabled: Boolean;
begin
  result := Enabled;
end;

procedure TfcCustomLabel.AdjustBounds;
var
  DC: HDC;
  ARect: TRect;
  X: Integer;
begin
  if not (csReading in ComponentState) and FAutoSize then
  begin
    DC := GetDC(0);
    Canvas.Handle := DC;
    ARect := TextOptions.CalcDrawRect(True);
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    x := Left;
    if TextOptions.Alignment = taRightJustify then
      x := (Left + Width) - fcRectWidth(ARect);
    SetBounds(x, Top, fcRectWidth(ARect), fcRectHeight(ARect));
  end;
end;

procedure TfcCustomLabel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

function TfcCustomLabel.GetTransparent: Boolean;
begin
  result := not (csOpaque in ControlStyle);
end;

procedure TfcCustomLabel.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TfcCustomLabel.SetTransparent(Value: Boolean);
begin
  if Transparent <> Value then
  begin
    if Value then
      ControlStyle := ControlStyle - [csOpaque] else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

procedure TfcCustomLabel.Loaded;
begin
  inherited;
  AdjustBounds;
end;

procedure TfcCustomLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
end;

procedure TfcCustomLabel.CMTextChanged(var Message: TMessage);
begin
  TextOptions.Text := Caption;
  AdjustBounds;
  Invalidate;
end;

procedure TfcCustomLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AdjustBounds;
end;

procedure TfcCustomLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and (toShowAccel in TextOptions.Options) and
    IsAccel(Message.CharCode, Caption) then
    with FFocusControl do
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
      end;
end;

procedure TfcCustomLabel.CMMouseEnter(var Message: TWMMouse);
begin
  inherited;
  MouseEnter;
end;

procedure TfcCustomLabel.CMMouseLeave(var Message: TWMMouse);
begin
  inherited;
  MouseLeave;
end;

procedure TfcCustomLabel.MouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(self);
end;

procedure TfcCustomLabel.MouseLeave;
begin
  if Assigned(FOnMouseLeave) then FOnMouseLeave(self);
end;

procedure TfcCustomLabel.WndProc(var Message: TMessage);
begin
  inherited;
end;

end.
