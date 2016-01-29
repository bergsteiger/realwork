unit NOT_FINISHED_vtPreviewPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Panels"
// Модуль: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtPreviewPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT$Panels:: Panels::TvtPreviewPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  vtCustomPreviewPanel
  ;

type
 TvtPreviewPanel = class(TvtCustomPreviewPanel)
 end;//TvtPreviewPanel

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
// Регистрация TvtPreviewPanel
 TtfwClassRef.Register(TvtPreviewPanel);
{$IfEnd} //not NoScripts

end.