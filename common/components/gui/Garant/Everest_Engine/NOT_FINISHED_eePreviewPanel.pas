unit NOT_FINISHED_eePreviewPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/NOT_FINISHED_eePreviewPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::Editor::TeePreviewPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  vtCustomPreviewPanel
  ;

type
 TeeCustomPreviewPanel = class(TvtCustomPreviewPanel)
 end;//TeeCustomPreviewPanel

 TeePreviewPanel = class
 end;//TeePreviewPanel

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
// Регистрация TeeCustomPreviewPanel
 TtfwClassRef.Register(TeeCustomPreviewPanel);
{$IfEnd} //not NoScripts

end.