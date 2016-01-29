unit NOT_FINISHED_OvcBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Orpheus"
// Модуль: "w:/common/components/rtl/external/Orpheus/NOT_FINISHED_OvcBase.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Orpheus::OvcBase::TOvcBase
//
// base class for Orpheus components. Provides controller access.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Orpheus\OVC.INC}

interface

uses
  OvcController
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;

type
 TOvcBase = class(TCustomControl)
  {* base class for Orpheus components. Provides controller access. }
 public
 // public fields
   Controller : TOvcController;
    {* Контроллер команд.}
 end;//TOvcBase

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// Регистрация TOvcBase
 TtfwClassRef.Register(TOvcBase);
{$IfEnd} //not NoScripts

end.