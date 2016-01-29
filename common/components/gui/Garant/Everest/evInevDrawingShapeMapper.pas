unit evInevDrawingShapeMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evInevDrawingShapeMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Drawing Framework::TevInevDrawingShapeMapper
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
  k2InterfaceMapper,
  l3IID,
  l3Variant
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
type
 TevInevDrawingShapeMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TevInevDrawingShapeMapper
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}
uses
  nevRealTools
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}

// start class TevInevDrawingShapeMapper

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

{$IfEnd} //evNeedPainters

end.