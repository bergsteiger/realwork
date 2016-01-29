unit vtSpeedButton;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/vtSpeedButton.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::Buttons::TvtSpeedButton
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  Classes
  {$If not defined(NoTB97)}
  ,
  tb97Ctls
  {$IfEnd} //not NoTB97
  
  ;

type
 TvtSpeedButton = class(TToolbarButton97)
 end;//TvtSpeedButton

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// Регистрация TvtSpeedButton
 TtfwClassRef.Register(TvtSpeedButton);
{$IfEnd} //not NoScripts

end.