unit NOT_FINISHED_vtCustomPreviewPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT$Panels"
// ������: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtCustomPreviewPanel.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT$Panels:: Panels::TvtCustomPreviewPanel
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

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
// ����������� TvtCustomPreviewPanel
 TtfwClassRef.Register(TvtCustomPreviewPanel);
{$IfEnd} //not NoScripts

end.