unit NOT_FINISHED_vcmBaseUserTypesCollectionItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Visual"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Components/NOT_FINISHED_vcmBaseUserTypesCollectionItem.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::UserTypes::TvcmBaseUserTypesCollectionItem
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
  vcmUserTypesCollectionItemPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmBaseUserTypesCollectionItem = class(TvcmUserTypesCollectionItemPrim)
 end;//TvcmBaseUserTypesCollectionItem
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
// ����������� TvcmBaseUserTypesCollectionItem
 TtfwClassRef.Register(TvcmBaseUserTypesCollectionItem);
{$IfEnd} //not NoScripts AND not NoVCM

end.