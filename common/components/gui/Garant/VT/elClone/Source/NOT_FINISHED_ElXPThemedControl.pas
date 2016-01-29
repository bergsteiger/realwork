unit NOT_FINISHED_ElXPThemedControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/elClone/Source/NOT_FINISHED_ElXPThemedControl.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT::elClone::TElXPThemedControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
  afwCustomCommonControl
  ;

type
 TElXPThemedControl = class(TafwCustomCommonControl)
 end;//TElXPThemedControl

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
// Регистрация TElXPThemedControl
 TtfwClassRef.Register(TElXPThemedControl);
{$IfEnd} //not NoScripts

end.