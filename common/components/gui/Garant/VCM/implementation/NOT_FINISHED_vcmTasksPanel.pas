unit NOT_FINISHED_vcmTasksPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// ������: "w:/common/components/gui/Garant/VCM/implementation/NOT_FINISHED_vcmTasksPanel.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::TasksPanel::vcmTasksPanel
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmBase,
  l3Interfaces,
  l3NotifyPtrList
  ;

type
 _l3Notifier_Parent_ = TvcmBase;
 {$Include w:\common\components\rtl\Garant\L3\l3Notifier.imp.pas}
 TvcmCustOpsNotifier = class(_l3Notifier_)
 end;//TvcmCustOpsNotifier
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  SysUtils
  ;

{$Include w:\common\components\rtl\Garant\L3\l3Notifier.imp.pas}

{$IfEnd} //not NoVCM
end.