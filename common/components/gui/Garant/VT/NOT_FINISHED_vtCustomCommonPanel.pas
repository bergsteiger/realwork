unit NOT_FINISHED_vtCustomCommonPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Panels"
// Модуль: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtCustomCommonPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT$Panels:: Panels::TvtCustomCommonPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  vtPanel
  ;

type
 TvtCustomCommonPanel = class(TvtPanel)
 end;//TvtCustomCommonPanel

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
// Регистрация TvtCustomCommonPanel
 TtfwClassRef.Register(TvtCustomCommonPanel);
{$IfEnd} //not NoScripts

end.