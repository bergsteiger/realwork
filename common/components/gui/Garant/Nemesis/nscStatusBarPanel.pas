unit nscStatusBarPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscStatusBarPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::StatusBar::TnscStatusBarPanel
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
  tb97Ctls
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
//#UC START# *503DEACA03BBci*
//#UC END# *503DEACA03BBci*
 _nscStatusBarItemNotification_Parent_ = TCustomToolbarPanel97;
 {$Include ..\Nemesis\nscStatusBarItemNotification.imp.pas}
//#UC START# *503DEACA03BBcit*
//#UC END# *503DEACA03BBcit*
 TnscStatusBarPanel = class(_nscStatusBarItemNotification_)
//#UC START# *503DEACA03BBpubl*
 public
  property AutoSize;
//#UC END# *503DEACA03BBpubl*
 end;//TnscStatusBarPanel
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


//#UC START# *503DEACA03BBimpl*
//#UC END# *503DEACA03BBimpl*

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscStatusBarPanel
 TtfwClassRef.Register(TnscStatusBarPanel);
{$IfEnd} //Nemesis AND not NoScripts

end.