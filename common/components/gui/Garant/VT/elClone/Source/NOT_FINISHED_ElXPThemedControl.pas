unit NOT_FINISHED_ElXPThemedControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT"
// ������: "w:/common/components/gui/Garant/VT/elClone/Source/NOT_FINISHED_ElXPThemedControl.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT::elClone::TElXPThemedControl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
  afwCustomCommonControl
  ;

type
 TElXPThemedControl = class(TafwCustomCommonControl)
 end;//TElXPThemedControl

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
// ����������� TElXPThemedControl
 TtfwClassRef.Register(TElXPThemedControl);
{$IfEnd} //not NoScripts

end.