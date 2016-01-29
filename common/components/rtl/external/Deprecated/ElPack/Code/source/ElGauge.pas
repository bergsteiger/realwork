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

unit ElGauge;

interface

uses
  SysUtils,
  Classes,
  Messages,
  Windows,
  Graphics,
  Controls,
  Forms,
  ElImgFrm,
{$ifdef VCL_6_USED}
Types,
{$endif}
  ElCGControl;

type
  TElGaugeKind = (egkNeedle, egkPie);

type
  TElGauge = class(TElCustomGraphicControl)
  private
    FTransparent : Boolean;
    FGaugeKind : TElGaugeKind;
    FText : string;
    FValue : Integer;
    FMinValue : Integer;
    FMaxValue : Integer;
    FShowPoints : Boolean;
    FPoints : Integer;
    FBackColor : TColor;
    FForeColor : TColor;
    FCriticalValue : Integer;
    FCriticalColor : TColor;
    Bitmap : TBitmap;
    FImgForm : TElImageForm;
    FImgFormChLink  : TImgFormChangeLink;
    procedure ImageFormChange(Sender : TObject);
    procedure SetImageForm(newValue : TElImageForm);
    procedure SetValue(newValue : Integer);
    procedure SetMinValue(newValue : Integer);
    procedure SetMaxValue(newValue : Integer);
    procedure SetShowPoints(newValue : Boolean);
    procedure SetPoints(newValue : Integer);
    procedure SetBackColor(newValue : TColor);
    procedure SetForeColor(newValue : TColor);
    procedure SetCriticalValue(newValue : Integer);
    procedure SetCriticalColor(newValue : TColor);
    procedure SetGaugeKind(newValue : TElGaugeKind);
    procedure SetTransparent(newValue : Boolean);
  protected
    procedure SetText(Value: string);
    procedure Paint; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Value : Integer read FValue write SetValue default 0;
    property MinValue : Integer read FMinValue write SetMinValue default 0;
    property MaxValue : Integer read FMaxValue write SetMaxValue default 100;
    property ShowPoints : Boolean read FShowPoints write SetShowPoints default true;
    property Points : Integer read FPoints write SetPoints default 11;
    property BackColor : TColor read FBackColor write SetBackColor default clBtnHighlight;
    property ForeColor : TColor read FForeColor write SetForeColor default clBtnText;
    property CriticalValue : Integer read FCriticalValue write SetCriticalValue;
    property CriticalColor : TColor read FCriticalColor write SetCriticalColor;
    property Transparent : Boolean read FTransparent write SetTransparent default False;  { Published }
    property ImageForm   : TElImageForm read FImgForm write SetImageForm;
    property Align;
    property Color;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property Text : string read FText write SetText;
    property GaugeKind : TElGaugeKind read FGaugeKind write SetGaugeKind;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DragKind;
{$ENDIF}
  end;

implementation

uses ElTools, ElVCLUtils;

procedure TElGauge.SetValue(newValue : Integer);
begin
  if (FValue <> newValue) and (newValue >= FMinValue) and (newValue <= FMaxValue) then
  begin
    FValue := newValue;
    Repaint;
  end; {if}
end; {SetValue}

procedure TElGauge.SetMinValue(newValue : Integer);
begin
  if (FMinValue <> newValue) then
  begin
    if newValue < FMaxValue then
    begin
      FMinValue := newValue;
      if FCriticalValue < FMinValue then FCriticalValue := FMinValue;
      Repaint;
    end;
  end; {if}
end; {SetMinValue}

procedure TElGauge.SetMaxValue(newValue : Integer);
begin
  if (FMaxValue <> newValue) then
  begin
    if newValue > FMinValue then
    begin
      FMaxValue := newValue;
      FCriticalValue := FMaxValue;
      Repaint;
    end;
  end; {if}
end; {SetMaxValue}

procedure TElGauge.SetShowPoints(newValue : Boolean);
begin
  if (FShowPoints <> newValue) then
  begin
    FShowPoints := newValue;
    Repaint;
  end; {if}
end; {SetShowPoints}

procedure TElGauge.SetPoints(newValue : Integer);
begin
  if (FPoints <> newValue) then
  begin
    FPoints := newValue;
    if FShowPoints then Repaint;
  end; {if}
end; {SetPoints}

procedure TElGauge.SetBackColor(newValue : TColor);
begin
  if (FBackColor <> newValue) then
  begin
    FBackColor := newValue;
    Repaint;
  end; {if}
end; {SetBackColor}

procedure TElGauge.SetForeColor(newValue : TColor);
begin
  if (FForeColor <> newValue) then
  begin
    FForeColor := newValue;
    Repaint;
  end; {if}
end; {SetForeColor}

procedure TElGauge.SetCriticalValue(newValue : Integer);
begin
  if (FCriticalValue <> newValue) and (FCriticalValue >= FMinValue) and (FCriticalValue <= FMaxValue) then
  begin
    FCriticalValue := newValue;
    Repaint;
  end; {if}
end; {SetCriticalValue}

procedure TElGauge.SetCriticalColor(newValue : TColor);
begin
  if (FCriticalColor <> newValue) then
  begin
    FCriticalColor := newValue;
    Repaint;
  end; {if}
end; {SetCritivalColor}

procedure TElGauge.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FImgForm then
    begin
      ImageForm := nil;
      Invalidate;
    end;
  end;
end;

procedure TElGauge.Paint;
var
  R, TR  : TRect;
  R1,
  BgRect : TRect;
  ACtl  : TWinControl;
  MX : integer;
  Angle : extended;
begin
  R := ClientRect;
  Bitmap.Width := R.Right - R.Left + 1;
  Bitmap.Height := R.Bottom - R.Top + 1;
  //BitBlt(Bitmap.Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, Bitmap.Canvas.Handle, R.Left, R.Top, SRCCOPY);
  with {Bitmap.}Canvas do
  begin
    if not Transparent then
    begin
      if (FImgForm <> nil) and (not (csDesigning in FImgForm.ComponentState)) then
      begin
        ACtl := FImgForm.GetRealControl;
        R1 := R;
        BgRect := R;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

        FImgForm.PaintBkgnd(Handle, R1, Point(Left, Top), false);
      end
      else
      begin
        Brush.Color := Color;
        FillRect(R);
        InflateRect(R, -1, -1);
      end;
    end;
    Pen.Color := FForeColor;
    Brush.Color := FBackColor;
    Pie(R.Left, R.Top, R.Right, R.Bottom * 2, R.Right, R.Bottom, R.Left, R.Bottom);
    MoveTo(R.Left + ((R.Right - R.Left) div 2), R.Bottom);
    if (Value > MinValue) and (Value <= MaxValue) then
    begin
      if FGaugeKind = egkPie then
      begin
        MX := (R.Right - R.Left) div 2;
        Brush.Color := FForeColor;
        if (FCriticalValue = FMaxValue) or (FCriticalValue = FMinValue) or (Value <= FCriticalValue) then
        begin
          Angle := Pi * ((Value - MinValue) / (MaxValue - MinValue));
          Pie(R.Left, R.Top, R.Right, R.Bottom * 2, Round(MX * (1 - Cos(Angle))),
            Round((R.Bottom - R.Top) * (1 - Sin(Angle))), R.Left, R.Bottom);
        end else
        begin
          Brush.Color := FCriticalColor;
          Pen.Color := FCriticalColor;
          Angle := Pi * ((Value - MinValue) / (MaxValue - MinValue));
          Pie(R.Left, R.Top, R.Right, R.Bottom * 2, Round(MX * (1 - Cos(Angle))),
            Round((R.Bottom - R.Top) * (1 - Sin(Angle))), R.Left, R.Bottom);
        end;
      end
      else
      begin
        if FValue <= FCriticalValue
           then Pen.Color := ForeColor
           else Pen.Color := FCriticalColor;
        MX := (R.Right - R.Left) div 2;
        MoveTo(MX, R.Bottom - 1);
        Angle := Pi * ((Value - MinValue) / (MaxValue - MinValue));
        LineTo(Round(MX * (1 - Cos(Angle))), Round((R.Bottom - R.Top - 1) * (1 - Sin(Angle))));
      end;
    end;
    if FText <> '' then
    begin
      Font.Assign(Self.Font);
      Brush.Style := bsClear;
      TR := ClientRect;
      DrawText(Handle, PChar(FText), -1, TR, DT_VCENTER or DT_CENTER or DT_CALCRECT);
      CenterRects((TR.Right - TR.Left), (R.Right - R.Left), (TR.Bottom - TR.Top), (R.Bottom - R.Top), R);
      DrawText(Handle, PChar(FText), -1, R, DT_CENTER);
    end;
  end; // with
  //GetClipBox(Canvas.Handle, R);
  //BitBlt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, Bitmap.Canvas.Handle, R.Left, R.Top, SRCCOPY);
end; {Paint}

procedure TElGauge.SetText(Value : string);
begin
  if (FText <> Value) then
  begin
    FText := Value;
    Invalidate;
  end; {if}
end; {SetText}

procedure TElGauge.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TElGauge.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then FImgForm.UnRegisterChanges(FImgFormChLink);
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    Invalidate;
  end;
end;

procedure TElGauge.SetGaugeKind(newValue : TElGaugeKind);
begin
  if (FGaugeKind <> newValue) then
  begin
    FGaugeKind := newValue;
    Repaint;
  end; {if}
end; {SetGaugeKind}

procedure TElGauge.SetTransparent(newValue : Boolean);
{ Sets data member FTransparent to newValue. }
begin
  if FTransparent <> NewValue then
  begin
    FTransparent := NewValue;
    if NewValue then
      ControlStyle := ControlStyle - [csOpaque] else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;  { SetTransparent }

destructor TElGauge.Destroy;
begin
  ImageForm := nil;
  FImgFormChLink.Free;
  Bitmap.Free;
  inherited Destroy;
end; {Destroy}

constructor TElGauge.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FValue := 0;
  FMinValue := 0;
  FMaxValue := 100;
  FShowPoints := True;
  FPoints := 11;
  FBackColor := clBtnHighlight;
  FForeColor := clBtnText;
  DragMode := dmManual;
  Bitmap := TBitmap.Create;
  Width := 200;
  Height := 50;
  { Initialize properties with default values: }
  FTransparent := False;
  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
end; {Create}

procedure TElGauge.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
end;
end.
