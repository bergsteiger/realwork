unit NOT_FINISHED_vtCustomCommonPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT$Panels"
// ������: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtCustomCommonPanel.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT$Panels:: Panels::TvtCustomCommonPanel
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

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
// ����������� TvtCustomCommonPanel
 TtfwClassRef.Register(TvtCustomCommonPanel);
{$IfEnd} //not NoScripts

end.