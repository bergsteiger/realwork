unit nscStatusBarSep;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscStatusBarSep.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::StatusBar::TnscStatusBarSep
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
  Classes
  {$If not defined(NoTB97)}
  ,
  TB97Tlbr
  {$IfEnd} //not NoTB97
  ,
  Messages,
  nscNewInterfaces,
  StatusBarUtils,
  Controls {a}
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 _nscStatusBarItemNotification_Parent_ = TToolbarSep97;
 {$Include ..\Nemesis\nscStatusBarItemNotification.imp.pas}
 TnscStatusBarSep = class(_nscStatusBarItemNotification_)
 end;//TnscStatusBarSep
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

{$Include ..\Nemesis\nscStatusBarItemNotification.imp.pas}


{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscStatusBarSep
 TtfwClassRef.Register(TnscStatusBarSep);
{$IfEnd} //Nemesis AND not NoScripts

end.