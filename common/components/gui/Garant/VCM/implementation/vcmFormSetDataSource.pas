unit vcmFormSetDataSource;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmFormSetDataSource.pas"
// �����: 11.12.2008 19:38
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Implementation::TvcmFormSetDataSource
//
// ��������� ���������� ������������ ���������� ��� TvcmFormSetFactory.MakeFormSet
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  vcmExternalInterfaces,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _SetType_ = IvcmFormSetDataSource;
 {$Include ..\implementation\vcmTinyUseCaseController.imp.pas}
 TvcmFormSetDataSource = class(_vcmTinyUseCaseController_)
  {* ��������� ���������� ������������ ���������� ��� TvcmFormSetFactory.MakeFormSet }
 end;//TvcmFormSetDataSource
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  vcmLocalInterfaces,
  l3Base,
  SysUtils
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

type _Instance_R_ = TvcmFormSetDataSource;

{$Include ..\implementation\vcmTinyUseCaseController.imp.pas}


{$IfEnd} //not NoVCM
end.