unit afwControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AFW"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/AFW/implementation/Visual/afwControl.pas"
// Начат: 23.12.1998 12:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::AFW::afwControl::TafwControl
//
// Базовый класс для управляющих элементов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwBaseControl
  ;

type
 TafwControl = class(TafwBaseControl)
  {* Базовый класс для управляющих элементов }
 end;//TafwControl

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
// Регистрация TafwControl
 TtfwClassRef.Register(TafwControl);
{$IfEnd} //not NoScripts

end.