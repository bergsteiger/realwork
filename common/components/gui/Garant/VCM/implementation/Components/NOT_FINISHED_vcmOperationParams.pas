unit NOT_FINISHED_vcmOperationParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Components/NOT_FINISHED_vcmOperationParams.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Components::TvcmOperationParams
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
  vcmBaseCollectionItem
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmOperationParams = class(TvcmBaseCollectionItem)
 end;//TvcmOperationParams
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
// ����������� TvcmOperationParams
 TtfwClassRef.Register(TvcmOperationParams);
{$IfEnd} //not NoScripts AND not NoVCM

end.