unit fcToolTip;
{
//
// Components : TfcToolTip
//
// Copyright (c) 1999 by Woll2Woll Software
}

interface

uses Graphics, Messages, Classes, Windows, Controls, SysUtils, Forms,
  fcCommon;

type
  TfcToolTip = class(THintWindow)
  protected
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
  public
    function CalcHintRect(MaxWidth: Integer; const AHint: string;
      AData: Pointer): TRect; override;
    procedure ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer); override;
  end;

var fcHintFont: TFont;
    fcHintPos: TPoint = (X: -1; Y: -1);

implementation

function TfcToolTip.CalcHintRect(MaxWidth: Integer; const AHint: string;
  AData: Pointer): TRect;
begin
  Canvas.Font.Assign(fcHintFont);
  result := inherited CalcHintRect(MaxWidth, AHint, AData);
end;

procedure TfcToolTip.ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer);
begin
  if (fcHintPos.x <> -1) and (fcHintPos.y <> -1) then
    with fcHintPos do Rect := Classes.Rect(x, y, x + fcRectWidth(Rect), y + fcRectHeight(Rect));
  inherited;
end;

procedure TfcToolTip.Paint;
begin
  Canvas.Font.Assign(fcHintFont);
  inherited;
end;

procedure TfcToolTip.WndProc(var Message: TMessage);
begin
  inherited;
end;

initialization
  fcHintFont := TFont.Create;
finalization
  fcHintFont.Free;
end.
