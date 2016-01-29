unit nevLeafParaInevLeafParaMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevLeafParaInevLeafParaMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevLeafParaInevLeafParaMapper
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
 TnevLeafParaInevLeafParaMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevLeafParaInevLeafParaMapper
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevTools,
  SysUtils
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TnevLeafParaInevLeafParaMapper

class function TnevLeafParaInevLeafParaMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D7D29E0029_var*
var
 l_TP : InevLeafPara;
//#UC END# *53D639B601D7_53D7D29E0029_var*
begin
//#UC START# *53D639B601D7_53D7D29E0029_impl*
 if not aTag.QT(InevLeafPara, l_TP, aProcessor) OR
    not l_TP.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D7D29E0029_impl*
end;//TnevLeafParaInevLeafParaMapper.Make

{$IfEnd} //k2ForEditor

end.