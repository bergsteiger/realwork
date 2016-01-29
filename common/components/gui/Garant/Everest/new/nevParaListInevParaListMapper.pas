unit nevParaListInevParaListMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevParaListInevParaListMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevParaListInevParaListMapper
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
 TnevParaListInevParaListMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevParaListInevParaListMapper
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevTools,
  SysUtils
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TnevParaListInevParaListMapper

class function TnevParaListInevParaListMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D780CC0395_var*
var
 l_PL : InevParaList;
//#UC END# *53D639B601D7_53D780CC0395_var*
begin
//#UC START# *53D639B601D7_53D780CC0395_impl*
 if not aTag.QT(InevParaList, l_PL, aProcessor) OR
    not l_PL.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D780CC0395_impl*
end;//TnevParaListInevParaListMapper.Make

{$IfEnd} //k2ForEditor

end.