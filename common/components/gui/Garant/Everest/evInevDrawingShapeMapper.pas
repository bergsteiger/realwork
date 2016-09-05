unit evInevDrawingShapeMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\evInevDrawingShapeMapper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevInevDrawingShapeMapper" MUID: (53D8EF87005F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , k2InterfaceMapper
 , l3Variant
 , l3IID
;

type
 TevInevDrawingShapeMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevInevDrawingShapeMapper
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 , nevRealTools
 //#UC START# *53D8EF87005Fimpl_uses*
 //#UC END# *53D8EF87005Fimpl_uses*
;

class function TevInevDrawingShapeMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D8EF87005F_var*
var
 l_Pnt : IevPainter;
//#UC END# *53D639B601D7_53D8EF87005F_var*
begin
//#UC START# *53D639B601D7_53D8EF87005F_impl*
 if not aTag.QT(IevPainter, l_Pnt, aProcessor) OR
    (l_Pnt = nil) then
  Result := false
 else
 begin
  InevDrawingShape(Tool) := l_Pnt;
  Result := true;
 end;//not aTag.QT(IevPainter, l_Pnt, aProcessor)
//#UC END# *53D639B601D7_53D8EF87005F_impl*
end;//TevInevDrawingShapeMapper.Make
{$IfEnd} // Defined(evNeedPainters)

end.
