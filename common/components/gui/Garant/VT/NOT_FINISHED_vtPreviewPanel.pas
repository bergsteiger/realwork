unit NOT_FINISHED_vtPreviewPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT$Panels"
// ������: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtPreviewPanel.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT$Panels:: Panels::TvtPreviewPanel
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

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
// ����������� TvtPreviewPanel
 TtfwClassRef.Register(TvtPreviewPanel);
{$IfEnd} //not NoScripts

end.