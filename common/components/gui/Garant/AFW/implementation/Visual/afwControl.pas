unit afwControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/AFW/implementation/Visual/afwControl.pas"
// �����: 23.12.1998 12:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::AFW::afwControl::TafwControl
//
// ������� ����� ��� ����������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwBaseControl
  ;

type
 TafwControl = class(TafwBaseControl)
  {* ������� ����� ��� ����������� ��������� }
 end;//TafwControl

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
// ����������� TafwControl
 TtfwClassRef.Register(TafwControl);
{$IfEnd} //not NoScripts

end.