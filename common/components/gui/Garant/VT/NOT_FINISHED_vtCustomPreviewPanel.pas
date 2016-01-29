unit NOT_FINISHED_vtCustomPreviewPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Panels"
// Модуль: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtCustomPreviewPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT$Panels:: Panels::TvtCustomPreviewPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  afwCustomCommonControl
  ;

type
 TvtCustomPreviewPanel = class(TafwCustomCommonControl)
 end;//TvtCustomPreviewPanel

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
// Регистрация TvtCustomPreviewPanel
 TtfwClassRef.Register(TvtCustomPreviewPanel);
{$IfEnd} //not NoScripts

end.