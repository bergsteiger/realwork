unit nevTextParaInevTextParaMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevTextParaInevTextParaMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevTextParaInevTextParaMapper
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
 TnevTextParaInevTextParaMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevTextParaInevTextParaMapper
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevTools
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TnevTextParaInevTextParaMapper

class function TnevTextParaInevTextParaMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D78F15032B_var*
var
 l_TP : InevTextPara;
//#UC END# *53D639B601D7_53D78F15032B_var*
begin
//#UC START# *53D639B601D7_53D78F15032B_impl*
 if not aTag.QT(InevTextPara, l_TP, aProcessor) OR
    not l_TP.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D78F15032B_impl*
end;//TnevTextParaInevTextParaMapper.Make

{$IfEnd} //k2ForEditor

end.