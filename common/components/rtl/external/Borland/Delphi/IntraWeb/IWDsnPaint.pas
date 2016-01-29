unit IWDsnPaint;

interface

{$R IWDsnPaintSupport.res}

uses
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  {$IFDEF Linux}QButtons, {$ELSE}Buttons,{$ENDIF}
  {$IFDEF Linux}Types, {$ELSE}Windows,{$ENDIF}
  IWControl, IWFont, Classes;

type
  TIWPaintHandlerDsn = class(TIWPaintHandler)
  protected
    procedure DrawOutline(const ABGColor: TColor = clSilver);
    procedure DrawResource(const AName: string; const ALeft: Integer; const ATop: Integer);
    procedure SetTransparent;
    procedure Draw3DBox; overload;
    procedure Draw3DBox(X1, Y1, X2, Y2: Integer); overload;
    procedure DrawArrow(ARect: TRect; ADirection: TArrowDirection);
    function DrawButton(const AClient: TRect; const ABevelWidth: Integer = 1;
      const AIsDown: Boolean = False; const AIsFocused: Boolean = False): TRect;
    procedure DrawScrollBar(ARect: TRect);
    procedure DrawTextLines(ARect: TRect; AText: TStrings);
    procedure SetCanvasFont(AFont: TIWFont);
  public
    procedure Paint; override;
  end;

  TIWPaintHandlerComponent = class(TIWPaintHandlerDsn)
  public
    procedure Paint; override;
  end;

implementation

uses
  SysUtils, SWSystem;

{ TIWPaintHandlerDsn }

procedure TIWPaintHandlerDsn.SetCanvasFont(AFont: TIWFont);
begin
  with FControl.Canvas do begin
    Font.Assign(AFont);
    if AFont.Color = clNone then begin
      Font.Color := clBlack;
    end;
  end;
end;

procedure TIWPaintHandlerDsn.DrawOutline(const ABGColor: TColor = clSilver);
var
  LPoints: array[0..4] of TPoint;
begin
  with FControl.Canvas do begin
    Brush.Style := bsSolid;
    Brush.Color := ABGColor;
    FillRect(Rect(0, 0, FControl.Width, FControl.Height));
    Pen.Color := clBlack;
    // FrameRect does not exist in Kylix 1. Maybe Kylix 2?
    LPoints[0] := Point(0, 0);
    LPoints[1] := Point(FControl.Width - 1, 0);
    LPoints[2] := Point(FControl.Width - 1, FControl.Height - 1);
    LPoints[3] := Point(0, FControl.Height - 1);
    LPoints[4] := Point(0, 0);
    Polyline(LPoints);
  end;
end;

procedure TIWPaintHandlerDsn.DrawResource(const AName: string; const ALeft, ATop: Integer);
var
  LBitmap: {$IFDEF Linux}QGraphics{$ELSE}Graphics{$ENDIF}.TBitmap;
  LInstance: LongWord;
  LName: String;
begin
  LInstance := FindInstanceContainingResource(UpperCase(AName), RT_BITMAP);
  LName := UpperCase(AName);
  if LInstance = 0 then begin
    // Paint Blank Image for componenets without coresponding palette image
    LInstance := FindInstanceContainingResource(UpperCase('BLANK'), RT_BITMAP);
    LName := 'BLANK';
  end;
  if LInstance <> 0 then begin
    LBitMap := {$IFDEF Linux}QGraphics{$ELSE}Graphics{$ENDIF}.TBitMap.Create; try
      LBitMap.LoadFromResourceName(LInstance, LName);
      FControl.Canvas.Draw(ALeft, ATop, LBitMap);
    finally FreeAndNil(LBitMap); end;
  end;
end;

procedure TIWPaintHandlerDsn.Paint;
begin
  DrawOutline;
end;

procedure TIWPaintHandlerDsn.SetTransparent;
begin
  {$IFNDEF Linux}
  SetBKMode(FControl.Canvas.Handle, TRANSPARENT);
  {$ENDIF}
end;

procedure TIWPaintHandlerDsn.Draw3DBox;
begin
  Draw3DBox(0, 0, FControl.Width, FControl.Height);
end;

procedure TIWPaintHandlerDsn.Draw3DBox(X1, Y1, X2, Y2: Integer);
begin
  with FControl.Canvas do begin
    Pen.Color := clGray;
    MoveTo(X1, Y1);
    LineTo(X2 - 1, Y1);
    MoveTo(X1, Y1);
    LineTo(X1, Y2 - 1);
    MoveTo(X1 + 1, Y1 + 1);
    Pen.Color := $00404040;
    LineTo(X2 - 2, Y1 + 1);
    MoveTo(X1 + 1, Y1 + 1);
    LineTo(X1 + 1, Y2 - 2);
    Pen.Color := clGray;
    MoveTo(X2 - 1, Y1);
    LineTo(X2 - 1, Y2);
    MoveTo(X1, Y2 - 1);
    LineTo(X2 - 1, Y2 - 1);
  end;
end;

procedure TIWPaintHandlerDsn.DrawArrow(ARect: TRect; ADirection: TArrowDirection);
var
  Mid: Integer;
begin
  with FCOntrol.Canvas do begin
    Brush.Color := clBlack;
    Pen.Color := clBlack;
    case Ord(ADirection) of
      0: // Up
        begin
          Mid := (ARect.Right + ARect.Left) div 2;
          Polygon([Point(Mid, ARect.Top + 5), Point(Arect.Right - 3, ARect.Bottom - 5),
            Point(Arect.Left + 3, ARect.Bottom - 5), Point(Mid, ARect.Top + 5)]);
        end;
      1: // Down
        begin
          Mid := (ARect.Right + ARect.Left) div 2;
          Polygon([Point(Mid, ARect.Bottom - 5), Point(ARect.Right - 3, ARect.Top + 5),
            Point(ARect.Left + 3, ARect.Top + 5), Point(Mid, ARect.Bottom - 5)]);
        end;
      2: // Left
        begin
          Mid := (ARect.Top + ARect.Bottom) div 2;
          Polygon([Point(ARect.Left + 3, Mid), Point(ARect.Right - 3, ARect.Top + 2),
            Point(ARect.Right - 3, ARect.Bottom - 2), Point(ARect.Left + 3, Mid)]);
        end;
      3: // Right
        begin
          Mid := (ARect.Top + ARect.Bottom) div 2;
          Polygon([Point(ARect.Left + 3, ARect.Top + 2), Point(ARect.Right - 3, Mid),
            Point(ARect.Left + 3, ARect.Bottom - 2), Point(ARect.Left + 3, ARect.Top + 2)]);
        end;
    end;
  end;
end;

procedure TIWPaintHandlerDsn.DrawScrollBar(ARect: TRect);
var
  LRect: TRect;
begin
  LRect := DrawButton(Rect(ARect.Left, ARect.Top + 1, ARect.Right, 18));
  DrawArrow(LRect, adUp);
  LRect := DrawButton(
    Rect(ARect.Left, ARect.Bottom - 16, ARect.Right, ARect.Bottom - ARect.Top + 1));
  DrawArrow(LRect, adDown);
{  with FCanvas do begin
    Pen.Color := clSilver;
    MoveTo(ARect.Left - 1,ARect.Top + 1);
    LineTo(ARect.Left - 1, ARect.Bottom + 1);
  end;}
end;

procedure TIWPaintHandlerDsn.DrawTextLines(ARect: TRect; AText: TStrings);
var
  YPos: Integer;
  Ln: Integer;
  Bt: Integer;
  LText: string;
begin
  Ln := 0;
  YPos := ARect.Top;
  FControl.Canvas.Brush.Style := bsClear;
  while (YPos < ARect.Bottom) and (Ln < AText.Count) do begin
    LText := AText[Ln];
    if Length(LText) < 1 then
      LText := ' ';
    Bt := YPos + FControl.Canvas.TextHeight(LText);
    FControl.Canvas.TextRect(Rect(ARect.Left, YPos, ARect.Right - ARect.Left, Bt), ARect.Left, YPos
      , LText);
    Inc(Ln);
    YPos := Bt;
  end;
end;

function TIWPaintHandlerDsn.DrawButton(const AClient: TRect;
  const ABevelWidth: Integer; const AIsDown, AIsFocused: Boolean): TRect;
begin
  Result := DrawButtonFace(FControl.Canvas, AClient, ABevelWidth
{$IFNDEF Linux}, bsAutoDetect, False{$ENDIF}, AIsDown, AIsFocused);
end;

{ TIWPaintHandlerComponent }

procedure TIWPaintHandlerComponent.Paint;
begin
  DrawOutline;
  DrawResource(FControl.ClassName, (FControl.Width - 24) div 2, (FControl.Height - 24) div 2);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\IntraWeb\IWDsnPaint.pas initialization enter'); {$EndIf}
  GDefaultPaintHandler := TIWPaintHandlerComponent;
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\IntraWeb\IWDsnPaint.pas initialization leave'); {$EndIf}
end.


