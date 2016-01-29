unit nevControlParaModelControlMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevControlParaModelControlMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevControlParaModelControlMapper
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
 TnevControlParaModelControlMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevControlParaModelControlMapper
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  k2Tags,
  SysUtils
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TnevControlParaModelControlMapper

class function TnevControlParaModelControlMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D6528E028F_var*
//#UC END# *53D639B601D7_53D6528E028F_var*
begin
//#UC START# *53D639B601D7_53D6528E028F_impl*
 if not Supports(IUnknown(aTag.IntA[k2_tiModelControl]), IID.IID, Tool) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D6528E028F_impl*
end;//TnevControlParaModelControlMapper.Make

{$IfEnd} //k2ForEditor

end.