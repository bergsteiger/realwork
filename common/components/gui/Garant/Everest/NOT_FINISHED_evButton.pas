unit NOT_FINISHED_evButton;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest$Visual"
// Модуль: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evButton.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest$Visual::Buttons::TevButton
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

interface

uses
  Classes
  {$If not defined(NoTB97)}
  ,
  tb97Ctls
  {$IfEnd} //not NoTB97
  
  ;

type
 TevCustomButton = class(TCustomToolbarButton97)
 protected
 // protected methods
   function HackCheck: Boolean; virtual;
 end;//TevCustomButton

 TevCustomButtonActionLink = class(TToolbarButton97ActionLink)
 end;//TevCustomButtonActionLink

 TevButton = class(TevCustomButton)
 end;//TevButton

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TevCustomButton

function TevCustomButton.HackCheck: Boolean;
//#UC START# *52A08AF5004B_52A085CE03AC_var*
//#UC END# *52A08AF5004B_52A085CE03AC_var*
begin
//#UC START# *52A08AF5004B_52A085CE03AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A08AF5004B_52A085CE03AC_impl*
end;//TevCustomButton.HackCheck

initialization
{$If not defined(NoScripts)}
// Регистрация TevCustomButton
 TtfwClassRef.Register(TevCustomButton);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TevButton
 TtfwClassRef.Register(TevButton);
{$IfEnd} //not NoScripts

end.