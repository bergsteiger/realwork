unit nevControlsBlockModelControlMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevControlsBlockModelControlMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevControlsBlockModelControlMapper
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
 TnevControlsBlockModelControlMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevControlsBlockModelControlMapper
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  k2Tags,
  SysUtils
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TnevControlsBlockModelControlMapper

class function TnevControlsBlockModelControlMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D638200108_var*
//#UC END# *53D639B601D7_53D638200108_var*
begin
//#UC START# *53D639B601D7_53D638200108_impl*
 if not Supports(IUnknown(aTag.IntA[k2_tiModelControl]), IID.IID, Tool) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D638200108_impl*
end;//TnevControlsBlockModelControlMapper.Make

{$IfEnd} //k2ForEditor

end.