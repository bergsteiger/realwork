unit vtColorBoxNodePainter;

{ $Id: vtColorBoxNodePainter.pas,v 1.14 2011/05/17 14:55:08 lulin Exp $ }

// $Log: vtColorBoxNodePainter.pas,v $
// Revision 1.14  2011/05/17 14:55:08  lulin
// {RequestLink:266409354}.
//
// Revision 1.13  2009/03/26 17:22:16  lulin
// [$140282719]. Новая "мода". Пишем комментарий об окончании метода.
//
// Revision 1.12  2009/03/26 10:22:21  fireton
// - изменился интерфейс _Il3NodePainter (параметры aSelStart и aSelEnd)
//
// Revision 1.11  2009/03/19 09:03:33  oman
// - fix: Пытаемся рисовать в редакторе (К-137463980)
//
// Revision 1.10  2009/03/19 08:42:29  oman
// - fix: Пытаемся рисовать в редакторе (К-137463980)
//
// Revision 1.9  2009/03/18 14:02:15  oman
// - fix: Пытаемся рисовать в редакторе (К-137463980)
//
// Revision 1.8  2009/03/18 12:48:51  oman
// - fix: Подключаем хинты (К-137463980)
//
// Revision 1.7  2009/03/18 10:14:30  oman
// - fix: Поддержка стилы cbNoNames (К-137463980)
//
// Revision 1.6  2009/03/18 09:55:16  oman
// - fix: Прорисовываем текст (К-137463980)
//
// Revision 1.5  2009/03/18 08:05:19  oman
// - fix: Прорисовываем квадратики (К-137463980)
//
// Revision 1.4  2009/03/17 15:05:27  oman
// - fix: Пытаемся рисовать (К-137463980)
//
// Revision 1.3  2009/03/17 14:10:23  oman
// - fix: Подаем настроенную канву сверху (К-139440480)
//
// Revision 1.2  2009/03/17 13:48:47  oman
// - fix: Заготовки для отрисовки (К-137463980)
//
// Revision 1.1  2009/03/17 07:32:22  oman
// - fix: Заготовки контрола (К-137463980)
//
//

{$Include vtDefine.inc }

interface

uses
 Graphics,

 l3InternalInterfaces,
 l3Interfaces,
 l3Types,
 l3Units,
 l3ProtoObject
 ;

type
 TvtColorBoxNodePainter = class(Tl3ProtoObject, Il3NodePainter)
 private
  f_Caption: Il3CString;
  f_Color: TColor;
  f_DrawNames: Boolean;
 protected
  //Il3NodePainter
  procedure PaintNode(const aCanvas: Il3Canvas;
   const aRect: Tl3Rect;
   SelStart, SelEnd: Integer;
   DoInverse: Boolean = False);
    {* Рисует ноду. }
  function CalcHeight(const aCanvas: Il3InfoCanvas; aWidth: Integer): Integer;
    {* Считает высоту по ширине. }
  function HintSupported: Boolean;
  function GetItemTextIndent(const aCanvas: Il3InfoCanvas;
   aTextHeight: Integer): Integer;
 protected
  procedure Cleanup;
   override;
 public
  constructor Create(const aCaption: Il3CString; aColor: TColor; DrawNames: Boolean);
   reintroduce;
  class function Make(const aCaption: Il3CString; aColor: TColor; DrawNames: Boolean): Il3NodePainter;
   reintroduce;
 end;//TvtColorBoxNodePainter

implementation

uses
 SysUtils,
 Windows,

 l3String
 ;

const
 cIndent = 5;

{ TvtColorBoxNodePainter }

function TvtColorBoxNodePainter.CalcHeight(const aCanvas: Il3InfoCanvas; aWidth: Integer): Integer;
begin
 Result := aCanvas.TextExtent(l3PCharLen(f_Caption)).Y;
end;

procedure TvtColorBoxNodePainter.Cleanup;
begin
 f_Caption := nil;
 inherited Cleanup;
end;

constructor TvtColorBoxNodePainter.Create(const aCaption: Il3CString;
  aColor: TColor; DrawNames: Boolean);
begin
 inherited Create;
 f_Caption := aCaption;
 f_Color := aColor;
 f_DrawNames := DrawNames;
end;

function TvtColorBoxNodePainter.GetItemTextIndent(
  const aCanvas: Il3InfoCanvas; aTextHeight: Integer): Integer;
begin
 if aTextHeight = -1 then
  Result := CalcHeight(aCanvas, 0)
 else
  Result := aTextHeight;
 Inc(Result, aCanvas.DP2LP(l3SPoint(cIndent, 0)).X);
end;

function TvtColorBoxNodePainter.HintSupported: Boolean;
begin
 Result := True;
end;

class function TvtColorBoxNodePainter.Make(const aCaption: Il3CString;
  aColor: TColor; DrawNames: Boolean): Il3NodePainter;
var
 l_Inst: TvtColorBoxNodePainter;
begin
 l_Inst := TvtColorBoxNodePainter.Create(aCaption, aColor, DrawNames);
 try
  Result := l_Inst;
 finally
  FreeAndNil(l_Inst);
 end;
end;

procedure TvtColorBoxNodePainter.PaintNode(const aCanvas: Il3Canvas;
  const aRect: Tl3Rect; SelStart, SelEnd: Integer; DoInverse: Boolean);

 function ColorToBorderColor(AColor: TColor): TColor;
 type
  TColorQuad = record
   Red,
   Green,
   Blue,
   Alpha: Byte;
  end;
 begin
  if (TColorQuad(AColor).Red > 192) or
     (TColorQuad(AColor).Green > 192) or
     (TColorQuad(AColor).Blue > 192) then
   Result := clBlack
  else if DoInverse then
   Result := clWhite
  else
   Result := AColor;
 end;

var
 l_Rect: Tl3Rect;
 l_SRect: Tl3SRect;
begin
 with aCanvas do
 begin
  PushBC;                  

  l_Rect := aRect;
  if f_DrawNames then
   l_Rect.Right := l_Rect.Bottom - l_Rect.Top + l_Rect.Left;
  l_SRect := LR2DR(l_Rect);
  l_SRect.Inflate1(-1);
  BackColor := ColorToRGB(f_Color);
  FillRect(l_SRect);
  BackColor := ColorToBorderColor(ColorToRGB(f_Color));
  Canvas.FrameRect(TRect(l_SRect));

  PopBC;
  if DoInverse then
   aCanvas.BeginInvert;

  if f_DrawNames then
  begin
   TextOut(l3Point(l_Rect.Right + DP2LP(l3SPoint(cIndent,0)).X,
                   aRect.Top + (aRect.Bottom - aRect.Top - CalcHeight(aCanvas, 0)) div 2),
     l3PCharLen(f_Caption));
  end;
  with aCanvas do
   FillEmptyRect(aRect);

  if DoInverse then
   aCanvas.EndInvert;
 end;
end;

end.
