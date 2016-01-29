unit nevControlParaIevControlFriendMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevControlParaIevControlFriendMapper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevControlParaIevControlFriendMapper
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
 TnevControlParaIevControlFriendMapper = class(Tk2InterfaceMapper)
 public
 // realized methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevControlParaIevControlFriendMapper
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  evQueryCardInt,
  SysUtils
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TnevControlParaIevControlFriendMapper

class function TnevControlParaIevControlFriendMapper.Make(aTag: Tl3Variant;
  const IID: Tl3GUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D64CA801F6_var*
var
 l_CP: IevControlFriend;
//#UC END# *53D639B601D7_53D64CA801F6_var*
begin
//#UC START# *53D639B601D7_53D64CA801F6_impl*
 if not aTag.QT(IevControlFriend, l_CP, aProcessor) OR
    not l_CP.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D64CA801F6_impl*
end;//TnevControlParaIevControlFriendMapper.Make

{$IfEnd} //k2ForEditor

end.