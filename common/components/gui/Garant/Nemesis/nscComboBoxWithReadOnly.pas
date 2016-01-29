unit nscComboBoxWithReadOnly;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscComboBoxWithReadOnly.pas"
// Начат: 06.11.2009 21:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::Editor::TnscComboBoxWithReadOnly
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
  nscComboBox
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
//#UC START# *4AF46F430293ci*
//#UC END# *4AF46F430293ci*
//#UC START# *4AF46F430293cit*
//#UC END# *4AF46F430293cit*
 TnscComboBoxWithReadOnly = class(TnscEdit)
//#UC START# *4AF46F430293publ*
  published
  // published methods
   property ReadOnly;
     {-}
//#UC END# *4AF46F430293publ*
 end;//TnscComboBoxWithReadOnly
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


//#UC START# *4AF46F430293impl*
//#UC END# *4AF46F430293impl*

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscComboBoxWithReadOnly
 TtfwClassRef.Register(TnscComboBoxWithReadOnly);
{$IfEnd} //Nemesis AND not NoScripts

end.