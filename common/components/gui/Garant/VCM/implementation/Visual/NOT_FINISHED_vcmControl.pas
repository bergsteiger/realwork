unit NOT_FINISHED_vcmControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Visual"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Visual/NOT_FINISHED_vcmControl.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VCM$Visual::Visual$Controls::TvcmControl
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
  afwCustomCommonControl
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmControl = class(TafwCustomCommonControl)
 end;//TvcmControl
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� TvcmControl
 TtfwClassRef.Register(TvcmControl);
{$IfEnd} //not NoScripts AND not NoVCM

end.