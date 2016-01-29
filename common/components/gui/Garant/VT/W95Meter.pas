unit W95Meter;
{* Компонент реализующий прогресс-индикатор в стиле Windows 95. }

{ $Id: W95Meter.pas,v 1.24 2013/04/19 13:06:19 lulin Exp $ }

// $Log: W95Meter.pas,v $
// Revision 1.24  2013/04/19 13:06:19  lulin
// - портируем.
//
// Revision 1.23  2012/11/30 15:08:24  voba
// - tune
//
// Revision 1.22  2011/06/17 11:59:04  lulin
// {RequestLink:228688486}.
//
// Revision 1.21  2007/02/19 15:19:58  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.20  2007/02/12 18:06:17  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.19  2006/12/05 14:15:40  lulin
// - контрол переехал в визуальную библиотеку.
//
// Revision 1.18  2005/10/06 08:25:12  lulin
// - убран устаревший класс.
//
// Revision 1.17  2005/05/27 14:42:31  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.16  2005/05/24 12:48:17  lulin
// - для канвы используем интерфейс, а не объект.
//
// Revision 1.15  2005/05/23 15:39:51  lulin
// - убрал надоевшую зависимость между библиотеками.
//
// Revision 1.14  2004/11/11 14:26:06  fireton
// - add: новое свойство - MinShowPeriod
//
// Revision 1.13  2003/04/19 11:24:48  law
// - new file: vtDefine.inc.
//
// Revision 1.12  2002/04/17 08:20:10  law
// - new method: DoSetStr.
//
// Revision 1.11  2002/01/25 11:38:08  law
// - bug fix: не стирался прогресс при установлении в 0.
//
// Revision 1.10  2001/09/21 09:58:56  law
// - cleanup.
//
// Revision 1.9  2001/09/07 12:41:28  law
// - property: свойство Align добавлено в published секцию.
//
// Revision 1.8  2001/09/04 16:47:26  law
// - comments: xHelpGen.
//
// Revision 1.7  2001/06/18 15:59:44  voba
// no message
//
// Revision 1.6  2001/02/27 15:11:54  voba
// Убрал линюю отрисовку при Percent > 100
//
// Revision 1.5  2000/12/15 15:36:28  law
// - вставлены директивы Log.
//

{$Include vtDefine.inc }

interface

uses
  Windows,
  Messages,

  Classes,
  Graphics,
  Forms,

  l3Types,
  l3Interfaces,
  l3InternalInterfaces,
  l3Defaults,

  afwControl
  ;

const
 cDefBack = {$IfDef Nemesis}cGarant2011BackColor{$Else}clBtnFace{$EndIf}; 

type
  TvtStyleType = (st95None,st95Lowered,st95Raised);
   {* Тип внешнего вида индикатора. }

  TOnSetStr = procedure(Const aStr : AnsiString) of object;
   {* Событие, вызываемое при смене строки индикатора. }

  TvtW95Meter = class(TafwControl, Il3Meter)
   {*! Компонент реализующий прогресс-индикатор в стиле Windows 95. Для конечного использования. }
    private
      fPercent      : Integer;
      fMaxValue     : Longint;
      fBackColor    : TColor;
      fSegColor     : Tcolor;
      fSegWidth     : integer;
      fSegGap       : integer;
      fEdgeStyle    : TvtStyleType;
      fCurNumber    : Longint;
      fMaxNumber    : Longint;
      fOnSetStr     : TOnSetStr;
      fHideInactive : Boolean;
      FMinShowPeriod: Cardinal;
      FStartedTime: Cardinal;

      procedure SetPercent   (Value : Integer);
      procedure SetBackColor (Value : Tcolor);
      procedure SetSegColor  (Value : Tcolor);
      procedure SetSegWidth  (Value : Integer);
      procedure SetSegGap    (Value : integer);
      procedure SetStyle     (Value : TvtStyleType);
      procedure SetCurNumber (Value : Longint);
      procedure SetMinShowPeriod(const Value: Cardinal);

      function  VisibleStored: Boolean;
        {-}
    protected
    // internal methods
      procedure UpdateProgress(const Canvas: Il3Canvas);
        {-}
      procedure Paint(const aCanvas: Il3Canvas);
        override;
        {-}
      procedure Loaded;
        override;
        {-}  
    public
    // public methods
      constructor Create(AOwner: TComponent);
        override;
        {-}
      procedure ProgressProc(aState: Byte; aPercent: Integer; aValue: Longint; const aMsg: AnsiString);
        {-}
      procedure ProgressProc_ev(aState: Byte; aValue: Longint; const aMsg: AnsiString);
        {-}
      procedure Il3Meter_ProgressProc(aState: Byte; aValue: Longint; const aMsg: Il3CString);
        {-}
      procedure Il3Meter.ProgressProc = Il3Meter_ProgressProc;
        {-}
      procedure DoSetStr(const aStr: AnsiString);
        {-}
    published
    // published properties
      property OnClick;
      property OnDblClick;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnSetStr : TOnSetStr
        read fOnSetStr
        write fOnSetStr;
        {* - событие, вызываемое при смене строки индикатора. }
      property Cursor;
      property Align;
        {-}
      property Anchors;
        {-}
      property EdgeStyle: TvtStyleType
        read FEdgeStyle
        write SetStyle
        default st95Lowered;
        {* - внешний вид индикатора. }
      property SegmentGap:integer
        read FSegGap
        write SetSegGap
        default 2;
        {* - зазор между сегментами. }
      property SegmentWidth:integer
        read FSegWidth
        write SetSegWidth
        default 8;
        {* - ширина сегмента индикатора. }
      property SegmentColor:Tcolor
        read FSegColor
        write SetSegColor
        default clNavy;
        {* - цвет сегмента индикатора. }
      property BackGroundColor:TColor
        read FBackColor
        write SetBackColor
        default cDefBack;
        {* - цвет фона. }
      property Percent : Integer
        read FPercent
        write SetPercent
        default 0;
        {* - текущее состояние в процентах. }
      property CurNumber : Longint
        read FCurNumber
        write SetCurNumber
        default 0;
        {* - текущее значение. }
      property MaxNumber : Longint
        read FMaxNumber
        write FMaxNumber
        default 0;
        {* - максимальное значение. }
      property BorderStyle
        default bsSingle;
        {-}
      property Visible
        stored VisibleStored;
        {-}
      property Enabled;
        {-}
      property Width
        default 100;
        {-}
      property Height
        default 18;
        {-}
      property HideInactive : Boolean
        read fHideInactive
        write fHideInactive
        default false;
      property MinShowPeriod: Cardinal read FMinShowPeriod write SetMinShowPeriod default 1000;
        {* - прятать если неактивен? }
  end;{TvtW95Meter}

  TW95Meter = class(TvtW95Meter)
   {*! Компонент реализующий прогресс-индикатор в стиле Windows 95. Для совместимости с предыдущими версиями. }
  end;{TW95Meter}

implementation

uses
  SysUtils,
  
  l3Math,
  l3String
  ;

// start class TvtW95Meter   

constructor TvtW95Meter.Create(AOwner: TComponent);
begin
 inherited;
 BorderStyle := bsSingle;
 Width := 100;
 Height := 18;
 FPercent := 0;
 FBackColor := cDefBack;
 FSegColor := clNavy;
 FSegWidth := 8;
 FSegGap := 2;
 FMinShowPeriod := 1000;
 FEdgeStyle := st95Lowered;
 If fHideInactive then Visible := False;
end;

procedure TvtW95Meter.SetSegWidth(value:integer);
begin
 if (value > 0) and (value <> FSegWidth) then begin
  FSegWidth := value;
  Refresh;
 end;
end;

procedure TvtW95Meter.SetSegGap(value:integer);
begin
 if (Value > 0) and (Value <> FSegGap) then begin
  FSegGap := Value;
  Refresh;
 end;
end;

procedure TvtW95Meter.SetBackColor(value:Tcolor);
begin
 if FBackColor <> value then begin
  FBackColor := value;
  Refresh;
 end;
end;

procedure TvtW95Meter.SetSegColor(value:Tcolor);
begin
 if FSegColor <> Value then begin
  FSegColor := Value;
  Refresh;
 end;
end;

procedure TvtW95Meter.SetPercent(Value : Integer);
var
 bRefresh : boolean;
 l_Canvas : Il3Canvas;
begin
 if (Value < 0)
  then Value := 0
  else
   if (Value > 100)
    then Value := 100;

 if (Value <> FPercent) then begin
  if FPercent > Value then
   bRefresh := true
  else
   bRefresh := false;
  FPercent := Value;
  {if (FPercent < 0) then
   FPercent := 0
  else if (FPercent > 100) then
   FPercent := 100;}
  l_Canvas := Canvas;
  l_Canvas.BeginPaint;
  try
   l_Canvas.DrawEnabled := true;
   if (Fpercent = 0) or (bRefresh) or (csDesigning in ComponentState) then begin
    Perform(WM_ERASEBKGND, WParam(l_Canvas.DC), 0);
    Paint(l_Canvas);
   end else
    UpdateProgress(l_Canvas);
  finally
   l_Canvas.EndPaint;
  end;{try..finally}
 end;{Value <> FPercent}
end;

procedure TvtW95Meter.SetCurNumber (Value : Longint);
begin
 if FCurNumber = Value then exit;
 if MaxNumber = 0 then Raise Exception.Create('MaxNumber не задан!');
 FCurNumber := Value;
 Percent := l3MulDiv(FCurNumber, 100, FMaxNumber);
end;

function TvtW95Meter.VisibleStored: Boolean;
  {-}
begin
 Result := not HideInactive;
end;

procedure TvtW95Meter.SetStyle(value: TvtStyleType);
begin
 if value <> FEdgeStyle then begin
  FEdgeStyle := value;
  Refresh;
 end;
end;

procedure TvtW95Meter.UpdateProgress(const Canvas: Il3Canvas);

procedure DoHorizontal;
var
 i : integer;
 x1,y1,x2,y2,max : integer;
begin
 x1 := 4;
 x2 := x1+FSegWidth;
 y1 := 4;
 y2 := Height-4;
 max := Width div (FSegWidth+FSegGap);
 max := l3MulDiv(max, FPerCent, 100);
 for i := 1 to Max do with Canvas.Canvas do
   begin
     if x2 <= width - 4 then Rectangle(x1,y1,x2,y2);
     x1 := x1+FSegWidth+FSegGap;
     x2 := x1+FSegWidth;
   end;
end;

procedure DoVertical;
var
 i : integer;
 x1,y1,x2,y2,max : integer;
begin
 x1 := 4;
 x2 := Width-4;
 y1 := Height-(FSegWidth+4);
 y2 := Height-4;
 max := Height div (FSegWidth+FSegGap);
 max := l3MulDiv(max, FPercent, 100);
 for i := 1 to max do with Canvas.Canvas do
   begin
     if y1 >= 4 then Rectangle(x1,y1,x2,y2);
     y1 := y1-(FSegWidth+FSegGap);
     y2 := y1+ FsegWidth;
   end;
end;

begin
 with Canvas.Canvas do begin
  pen.color := FSegColor;
  brush.color := FsegColor;
 end;{with Canvas.Canvas} 
 if Width > Height then DoHorizontal else DoVertical;
end;

procedure TvtW95Meter.Paint(const aCanvas: Il3Canvas);
begin
 aCanvas.BeginPaint;
 try
  aCanvas.DrawEnabled := true;
  if FEdgeStyle <> st95none then
   with aCanvas.Canvas do
   begin
     Brush.Color := FBackColor;
     pen.Width := 1;
     if FEdgeStyle = st95Lowered
      then pen.color := clgray
      else pen.color := clWhite;
     moveto(0,height);
     lineto(0,0);
     lineto(width-1,0);
     if FEdgeStyle = st95Lowered
      then pen.color:=clWhite
      else pen.color := clGray;
     lineto(width-1,height-1);
     lineto(0,height-1);
   end;{with Canvas.Canvas}
  if FPercent > 0 then
   UpdateProgress(aCanvas);
 finally
  aCanvas.EndPaint;
 end;{try..finally}
end;

procedure TvtW95Meter.Loaded;
  //override;
  {-}
begin
 inherited;
 if HideInactive then
  Visible := false;
end;

procedure TvtW95Meter.ProgressProc_ev(aState: Byte; aValue: Longint; const aMsg: AnsiString);
begin
 ProgressProc(aState, 0, aValue, aMsg);
end;

procedure TvtW95Meter.Il3Meter_ProgressProc(aState: Byte; aValue: Longint; const aMsg: Il3CString);
  {-}
begin
 ProgressProc(aState, 0, aValue, l3Str(aMsg));
end;

procedure TvtW95Meter.DoSetStr(const aStr: AnsiString);
  {-}
begin
 if Assigned(fOnSetStr) then fOnSetStr(aStr)
end;

procedure TvtW95Meter.ProgressProc(aState: Byte; aPercent: Integer; aValue: Longint; const aMsg: AnsiString);
Begin
 Case aState of
  piStart: begin
   fMaxValue := aValue;
   if fMaxValue = 0 then fMaxValue := 1;
   Percent := 0;
   FStartedTime := GetTickCount;
   if aMsg <> '' then DoSetStr(aMsg);
  end;//piStart
  piCurrent: begin
   if fHideInactive and not Visible and (GetTickCount-FStartedTime >= FMinShowPeriod) then
    Visible := True;
   try
    if aMsg <> '' then DoSetStr(aMsg);
    if (fMaxValue <= 0) then
     Percent := aPercent
    else
     Percent := l3MulDiv(aValue, 100, fMaxValue);
   except
   end;
  end;//piCurrent
  piEnd: begin
   fMaxValue := 0;
   if fHideInactive then Visible := false;
   DoSetStr('');
  end;//piEnd
 end;//Case aState
end;

procedure TvtW95Meter.SetMinShowPeriod(const Value: Cardinal);
begin
 if FMinShowPeriod <> Value then
 begin
  FMinShowPeriod := Value;
 end;
end;

end.





