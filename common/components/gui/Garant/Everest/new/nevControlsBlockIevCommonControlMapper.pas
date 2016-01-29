unit nevControlsBlockIevCommonControlMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevControlsBlockIevCommonControlMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevControlsBlockIevCommonControlMapper
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
 TnevControlsBlockIevCommonControlMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevControlsBlockIevCommonControlMapper
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  SysUtils,
  nevTools
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TnevControlsBlockIevCommonControlMapper

class function TnevControlsBlockIevCommonControlMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D637420240_var*
var
 l_CP: IevCommonControl;
//#UC END# *53D639B601D7_53D637420240_var*
begin
//#UC START# *53D639B601D7_53D637420240_impl*
 if not aTag.QT(IevCommonControl, l_CP, aProcessor) OR
    not l_CP.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D637420240_impl*
end;//TnevControlsBlockIevCommonControlMapper.Make

{$IfEnd} //k2ForEditor

end.