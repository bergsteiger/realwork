unit tb97Control;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "tb97"
// Модуль: "w:/common/components/rtl/external/tb97/tb97Control.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::tb97::tb97utils::Ttb97Control
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\tb97\TB97VER.INC}

interface

{$If not defined(NoTB97)}
uses
  afwCustomCommonControl
  ;
{$IfEnd} //not NoTB97

{$If not defined(NoTB97)}
type
 Ttb97Control = class(TafwCustomCommonControl)
 end;//Ttb97Control
{$IfEnd} //not NoTB97

implementation

{$If not defined(NoTB97)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoTB97

{$If not defined(NoTB97)}


{$IfEnd} //not NoTB97

initialization
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация Ttb97Control
 TtfwClassRef.Register(Ttb97Control);
{$IfEnd} //not NoScripts AND not NoTB97

end.