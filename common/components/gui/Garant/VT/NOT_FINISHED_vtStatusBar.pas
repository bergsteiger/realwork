unit NOT_FINISHED_vtStatusBar;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT"
// ������: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtStatusBar.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::StatusBar::TvtStatusBar
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  ComCtrls
  {$IfEnd} //not NoVCL
  
  ;

type
 TvtCustomStatusBar = class(TCustomStatusBar)
 end;//TvtCustomStatusBar

 TvtStatusPanel = class
 end;//TvtStatusPanel

 TvtStatusBar = class(TvtCustomStatusBar)
 end;//TvtStatusBar

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  StatusPanelWordsPack
  {$IfEnd} //not NoScripts
  ,
  afwDrawing
  {$If not defined(NoScripts)}
  ,
  StatusBarWordsPack
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// ����������� TvtCustomStatusBar
 TtfwClassRef.Register(TvtCustomStatusBar);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� TvtStatusPanel
 TtfwClassRef.Register(TvtStatusPanel);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� TvtStatusBar
 TtfwClassRef.Register(TvtStatusBar);
{$IfEnd} //not NoScripts

end.