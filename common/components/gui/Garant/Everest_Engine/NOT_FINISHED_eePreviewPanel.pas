unit NOT_FINISHED_eePreviewPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest Engine"
// ������: "w:/common/components/gui/Garant/Everest_Engine/NOT_FINISHED_eePreviewPanel.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::Editor::TeePreviewPanel
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

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
// ����������� TeeCustomPreviewPanel
 TtfwClassRef.Register(TeeCustomPreviewPanel);
{$IfEnd} //not NoScripts

end.