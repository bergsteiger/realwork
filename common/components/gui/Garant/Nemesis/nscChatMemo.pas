unit nscChatMemo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscChatMemo.pas"
// Начат: 18.08.2009 14:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::Memos::TnscChatMemo
//
// Мемо-поле для чата F1
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  nscCustomChatMemo
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
//#UC START# *4A8A8739017Dci*
//#UC END# *4A8A8739017Dci*
//#UC START# *4A8A8739017Dcit*
//#UC END# *4A8A8739017Dcit*
 TnscChatMemo = class(TnscCustomChatMemo)
  {* Мемо-поле для чата F1 }
//#UC START# *4A8A8739017Dpubl*
  published
    property PopupMenu;
//#UC END# *4A8A8739017Dpubl*
 end;//TnscChatMemo
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}


//#UC START# *4A8A8739017Dimpl*
//#UC END# *4A8A8739017Dimpl*

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscChatMemo
 TtfwClassRef.Register(TnscChatMemo);
{$IfEnd} //Nemesis AND not NoScripts

end.