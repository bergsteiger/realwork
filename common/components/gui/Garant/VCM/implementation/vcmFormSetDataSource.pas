unit vcmFormSetDataSource;
 {* ��������� ���������� ������������ ���������� ��� TvcmFormSetFactory.MakeFormSet }

// ������: "w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmFormSetDataSource" MUID: (494141D20217)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmInterfaces
 , l3ProtoObjectWithCOMQI
 , vcmExternalInterfaces
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _SetType_ = IvcmFormSetDataSource;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}
 TvcmFormSetDataSource = class(_vcmTinyUseCaseController_)
  {* ��������� ���������� ������������ ���������� ��� TvcmFormSetFactory.MakeFormSet }
 end;//TvcmFormSetDataSource
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmLocalInterfaces
 , l3Base
 , SysUtils
 //#UC START# *494141D20217impl_uses*
 //#UC END# *494141D20217impl_uses*
;

type _Instance_R_ = TvcmFormSetDataSource;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
