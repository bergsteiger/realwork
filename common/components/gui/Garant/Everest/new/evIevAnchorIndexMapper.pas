unit evIevAnchorIndexMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/evIevAnchorIndexMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TevIevAnchorIndexMapper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  k2InterfaceMapper,
  l3IID,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevIevAnchorIndexMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TevIevAnchorIndexMapper
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}

// start class TevIevAnchorIndexMapper

class function TevIevAnchorIndexMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D8EE9F00BC_var*
//#UC END# *53D639B601D7_53D8EE9F00BC_var*
begin
//#UC START# *53D639B601D7_53D8EE9F00BC_impl*
 if not aTag.Owner.QT(IID.IID, Tool, aProcessor) then
 // - спросим родителя
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D8EE9F00BC_impl*
end;//TevIevAnchorIndexMapper.Make

{$IfEnd} //k2ForEditor

end.