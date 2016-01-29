unit evParaDrawTools;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evParaDrawTools.pas"
// Начат: 13.01.2004 18:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Printing::evParaDrawTools
//
// Выделенные когда-то из evTextSource методы рисования/печати
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  nevRealTools
  ;

function EvDrawPara(const anArea: TnevShapeArea;
  const aPara: InevObject;
  const aTop: InevBasePoint;
  const aBlock: InevRange;
  aPrevHeight: Integer): TnevShapeInfo;
   {* Метод рисования параграфа }

implementation

// unit methods

function EvDrawPara(const anArea: TnevShapeArea;
  const aPara: InevObject;
  const aTop: InevBasePoint;
  const aBlock: InevRange;
  aPrevHeight: Integer): TnevShapeInfo;
//#UC START# *49CCC052009F_481D76A4005D_var*
//#UC END# *49CCC052009F_481D76A4005D_var*
var
 l_Painter : InevDrawingShape;
 l_Points : TnevShapePoints;
begin
//#UC START# *49CCC052009F_481D76A4005D_impl*
 anArea.rCanvas.BeginPaint;
 try
  if not aPara.AsObject.IsValid then
   with anArea.rCanvas do
    FillRect(ClipRect)
  else
  begin
   if aPara.AsObject.QT(InevDrawingShape, l_Painter, nil) then
    try
     l_Points.rTop := aTop;
     l_Points.rCaret := nil;
     l_Points.rSelection := aBlock;
     l_Points.rPrevHeight := aPrevHeight;
     l_Points.rRealTop := nil;
     l_Points.rFake := False;
     l_Points.rCheckCaret := nil;
     l_Points.rCheckSelection := nil;
     anArea.rCanvas.Printed := l_Painter.Draw(anArea, l_Points, Result);
    finally
     l_Painter := nil;
    end;//try..finally
  end;//aPara.IsValid
  anArea.rCanvas.SetPageTop;
 finally
  anArea.rCanvas.EndPaint;
 end;//try..finally
//#UC END# *49CCC052009F_481D76A4005D_impl*
end;//EvDrawPara

end.