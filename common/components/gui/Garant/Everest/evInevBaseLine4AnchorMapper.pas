unit evInevBaseLine4AnchorMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evInevBaseLine4AnchorMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevInevBaseLine4AnchorMapper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  k2InterfaceMapper,
  l3IID,
  l3Variant
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevInevBaseLine4AnchorMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TevInevBaseLine4AnchorMapper
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  nevTools
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

// start class TevInevBaseLine4AnchorMapper

class function TevInevBaseLine4AnchorMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D8ED6D0117_var*
//#UC END# *53D639B601D7_53D8ED6D0117_var*
begin
//#UC START# *53D639B601D7_53D8ED6D0117_impl*
 if not aTag.QT(InevPoint, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D8ED6D0117_impl*
end;//TevInevBaseLine4AnchorMapper.Make

{$IfEnd} //evUseVisibleCursors

end.