unit NOT_FINISHED_nscPreviewPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/NOT_FINISHED_nscPreviewPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::Editor::TnscPreviewPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  eePreviewPanel
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscCustomPreviewPanel = class(TeeCustomPreviewPanel)
 end;//TnscCustomPreviewPanel

 TnscPreviewPanel = class
 end;//TnscPreviewPanel
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}


{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscCustomPreviewPanel
 TtfwClassRef.Register(TnscCustomPreviewPanel);
{$IfEnd} //Nemesis AND not NoScripts

end.