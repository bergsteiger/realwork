unit evPageBreakPainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evPageBreakPainter.pas"
// Начат: 03.10.2000 16:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::LeafPara Painters::TevPageBreakPainter
//
// Реализация инструмента рисования для разрыва страниц.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedPainters)}
uses
  l3Interfaces,
  l3Units,
  evLeafParaPainter,
  l3StringIDEx
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
type
 TevPageBreakPainter = class(TevLeafParaPainter)
  {* Реализация инструмента рисования для разрыва страниц. }
 protected
 // overridden protected methods
   function DrawLeaf: Boolean; override;
 protected
 // protected methods
   function GetString: Il3CString; virtual;
     {* вернуть строчку для отображения. }
   procedure NewPage; virtual;
     {* вызывается перед началом новой страницы. }
   procedure DrawLine(const A: Tl3Point;
    const B: Tl3Point); virtual;
     {* нарисовать линию разрыва. }
 end;//TevPageBreakPainter
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}
uses
  k2Tags,
  l3Const,
  nevBase,
  Graphics,
  l3String,
  l3MessageID
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}

var
   { Локализуемые строки Local }
  str_nevmmPageBegin : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmPageBegin'; rValue : ' Начало страницы. ');
   { ' Начало страницы. ' }

// start class TevPageBreakPainter

function TevPageBreakPainter.GetString: Il3CString;
//#UC START# *480C9DC4032F_480C9D5E01EE_var*
//#UC END# *480C9DC4032F_480C9D5E01EE_var*
begin
//#UC START# *480C9DC4032F_480C9D5E01EE_impl*
 Result := str_nevmmPageBegin.AsCStr;
//#UC END# *480C9DC4032F_480C9D5E01EE_impl*
end;//TevPageBreakPainter.GetString

procedure TevPageBreakPainter.NewPage;
//#UC START# *480C9DDD01B0_480C9D5E01EE_var*
//#UC END# *480C9DDD01B0_480C9D5E01EE_var*
begin
//#UC START# *480C9DDD01B0_480C9D5E01EE_impl*
//#UC END# *480C9DDD01B0_480C9D5E01EE_impl*
end;//TevPageBreakPainter.NewPage

procedure TevPageBreakPainter.DrawLine(const A: Tl3Point;
  const B: Tl3Point);
//#UC START# *480C9DEF0099_480C9D5E01EE_var*
//#UC END# *480C9DEF0099_480C9D5E01EE_var*
begin
//#UC START# *480C9DEF0099_480C9D5E01EE_impl*
 Area.rCanvas.Line(A, B);
//#UC END# *480C9DEF0099_480C9D5E01EE_impl*
end;//TevPageBreakPainter.DrawLine

function TevPageBreakPainter.DrawLeaf: Boolean;
//#UC START# *4804C81000B9_480C9D5E01EE_var*
var
 l_DrawRect : Tl3Rect;
 l_Height   : Integer;
 l_DY       : Integer;
//#UC END# *4804C81000B9_480C9D5E01EE_var*
begin
//#UC START# *4804C81000B9_480C9D5E01EE_impl*
 with Area.rCanvas do
 begin
  if Printing then
  begin
   MoveWindowOrg(l3PointY(-l3Epsilon));
   Self.NewPage;
   Result := false;
  end//Printing
  else
  begin
   {$IfDef Nemesis}
   if not DrawSpecial then
    l_Height := 0
   else
   {$EndIf Nemesis}
    l_Height := ParaX.AsObject.IntA[k2_tiHeight];
   l_DY := TopAnchor.AsLeaf.PaintOffsetY(Area.rView.As_InevView, FormatInfo);
   l_DrawRect.TopLeft := Tl3Point(nevPt0);
   l_DrawRect.BottomRight := l3Point(ClipRect.Right, l_Height);
   MoveWindowOrg(l3PointY(l_DY));
   {$IfDef Nemesis}
   FillRect(l_DrawRect);
   {$ELSE}
   FillRect(l3Rect(l_DrawRect.TopLeft.Sub(l3PointX(Map.Bounds.Left)), l_DrawRect.BottomRight));
   {$EndIf Nemesis}
   l_Height := l_Height div 2;
   {$IfDef Nemesis}
   if DrawSpecial then
   {$EndIf Nemesis}
   begin
    with Font do
    begin
     Name := 'MS Sans Serif';
     Style := [];
     Size := 8;
     Pitch := fpDefault;
     Index := l3_fiNone;
     ForeColor := clBlack;
    end;//Font
    with l_DrawRect do
    begin
{$IFDEF Nemesis}    
     DrawLine(TopLeft.Add(l3PointY(l_Height)), BottomRight.Sub(l3PointY(l_Height)));
{$ELSE}     
     DrawLine(TopLeft.Add(l3Point(-Map.Bounds.Left, l_Height)), BottomRight.Sub(l3PointY(l_Height)));
{$ENDIF Nemesis}
     TextOut(TopLeft, l3PCharLen(Self.GetString));
    end;//with l_DrawRect.R
   end;//DrawSpecial
   Result := True;  
  end;//Printing
 end;//with ParaX
//#UC END# *4804C81000B9_480C9D5E01EE_impl*
end;//TevPageBreakPainter.DrawLeaf

{$IfEnd} //evNeedPainters

initialization
{$If defined(evNeedPainters)}
// Инициализация str_nevmmPageBegin
 str_nevmmPageBegin.Init;
{$IfEnd} //evNeedPainters

end.